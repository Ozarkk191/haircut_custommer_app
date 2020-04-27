import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haircut_delivery/bloc/my_place_list_bloc.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/place.dart';
import 'package:haircut_delivery/repository/user_repository.dart';
import 'package:haircut_delivery/screen/addmyplace/add_my_place_screen.dart';
import 'package:haircut_delivery/screen/editmyplace/edit_my_place_screen.dart';
import 'package:haircut_delivery/screen/home/home_screen.dart';
import 'package:haircut_delivery/screen/login/login_screen.dart';
import 'package:haircut_delivery/ui/button.dart';
import 'package:haircut_delivery/ui/container.dart';
import 'package:haircut_delivery/ui/dialog.dart';
import 'package:haircut_delivery/ui/tool_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPlacesListScreen extends StatefulWidget {
  @override
  _MyPlaceListScreenState createState() => _MyPlaceListScreenState();
}

class _MyPlaceListScreenState extends State<MyPlacesListScreen> {
  // BLoC
  final _bloc = MyPlaceListBloc();

  @override
  void initState() {
    super.initState();

    // Listen for the result of a deleting a place.
    _bloc.deleteMyPlaceStream.listen((data) {
      switch (data.status) {
        case ResponseStatus.SUCCESS:
          _bloc.fetchMyPlaceList();
          break;
        case ResponseStatus.ERROR:
          if (data.httpStatus == 401) {
            UserRepository.logOut();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
          }
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(message: data.message);
            },
          );
          _bloc.fetchMyPlaceList();
          break;
        default: // Do nothing.
      }
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            PrimaryToolBar(title: AppLocalizations.of(context).tr('my_place_list_title')),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ContentContainer(
                    verticalPaddingEnabled: true,
                    child: Row(
                      children: <Widget>[
                        PrimaryButton(
                          text: AppLocalizations.of(context).tr('my_place_list_add_home'),
                          onPressed: () async {
                            final bool reload = await Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new AddMyPlacesScreen(Place.GROUP_HOME)));
                            if (reload ?? false) {
                              _bloc.fetchMyPlaceList();
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: GrayButton(
                            text: AppLocalizations.of(context).tr('my_place_list_add_workplace'),
                            onPressed: () async {
                              final bool reload = await Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new AddMyPlacesScreen(Place.GROUP_WORK)));
                              if (reload ?? false) {
                                _bloc.fetchMyPlaceList();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<ApiResponse<List<Place>>>(
                    stream: _bloc.myPlaceListStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return _buildMyPlaceList(snapshot.data?.data ?? []);
                      }
                      return _buildMyPlaceList([]);
                    },
                  ),
                  Divider(thickness: 3, color: const Color(0xFFDDDDDD)),
                  InkWell(
                    onTap: () {
                      _onCurrentLocationItemTap();
                    },
                    child: ContentContainer(
                      verticalPaddingEnabled: true,
                      verticalPadding: 10,
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/ic_location.png'),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              AppLocalizations.of(context).tr('my_place_list_current_location'),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 3, color: const Color(0xFFDDDDDD)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Builds my place list from [placeList] data.
  Widget _buildMyPlaceList(List<Place> placeList) {
    var children = <Widget>[
      Divider(thickness: 3, color: const Color(0xFFDDDDDD)),
    ];
    if (placeList != null && placeList.isNotEmpty) {
      final lastIndex = placeList.length - 1;
      var index = 0;
      children.addAll(placeList.map((place) {
        final divider = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Divider(thickness: 1, color: index == lastIndex ? Colors.transparent : const Color(0xFF707070)),
        );
        index++;
        return Dismissible(
          key: Key(place.id.toString()),
          background: Container(color: Theme.of(context).primaryColor),
          onDismissed: (direction) {
            _bloc.deleteMyPlace(place.id);
          },
          child: InkWell(
            onTap: () async {
              // Save the location to local storage.
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('myLocationName', place.name);
              await prefs.setString('myLocationAddress', place.address);
              await prefs.setDouble('myLatitude', place.latitude);
              await prefs.setDouble('myLongitude', place.longitude);

              // Go to the Near Me screen.
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(page: HomeScreenPage.NEAR_ME)), (Route<dynamic> route) => false);
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 8),
                        child: Image.asset('assets/images/ic_home_2.png'),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(place.name, style: TextStyle(fontSize: 20)),
                            Text(place.address, style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: ImageIcon(AssetImage('assets/images/ic_edit.png')),
                        onPressed: () async {
                          final bool reload = await Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new EditMyPlacesScreen(place)));
                          if (reload ?? false) {
                            _bloc.fetchMyPlaceList();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                divider
              ],
            ),
          ),
        );
      }).toList());
    } else {
      children.add(
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(AppLocalizations.of(context).tr('my_place_list_no_data')),
        ),
      );
    }
    return ExpansionTile(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 8),
            child: Image.asset('assets/images/ic_coin.png'),
          ),
          Text(
            AppLocalizations.of(context).tr('my_place_list_saved_places'),
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
      children: children,
    );
  }

  /// Event handler for user tapping the current location item.
  Future<void> _onCurrentLocationItemTap() async {
    GeolocationStatus geolocationStatus = await Geolocator().checkGeolocationPermissionStatus();
    switch (geolocationStatus) {
      case GeolocationStatus.granted:
        Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        if (position == null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(message: AppLocalizations.of(context).tr('error_location_not_available'));
            },
          );
          return;
        }

        // Save the location to local storage.
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setDouble('myLatitude', position.latitude);
        await prefs.setDouble('myLongitude', position.longitude);

        // Go to the Near Me screen.
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(page: HomeScreenPage.NEAR_ME)), (Route<dynamic> route) => false);
        break;
      case GeolocationStatus.denied:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(message: AppLocalizations.of(context).tr('error_gps_not_enabled'));
          },
        );
        break;
      case GeolocationStatus.disabled:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(message: AppLocalizations.of(context).tr('error_location_permission_not_granted'));
          },
        );
        break;
      default:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(message: AppLocalizations.of(context).tr('error_location_not_available'));
          },
        );
    }
  }
}
