import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:haircut_delivery/bloc/home_banner_bloc.dart';
import 'package:haircut_delivery/bloc/service_bloc.dart';
import 'package:haircut_delivery/bloc/shop_list_bloc.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/home_banner.dart';
import 'package:haircut_delivery/model/service.dart';
import 'package:haircut_delivery/screen/servicelist/service_list_screen.dart';
import 'package:haircut_delivery/ui/loading_screen.dart';
import 'package:haircut_delivery/ui/tool_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopListScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  ShopListScreen({this.scaffoldKey, Key key}) : super(key: key);

  @override
  _ShopListScreenState createState() => _ShopListScreenState();
}

class _ShopListScreenState extends State<ShopListScreen> {
  // BLoC
  final _shopListBloc = ShopListBloc();
  final _homeBannerBloc = HomeBannerBloc();
  final _serviceBloc = ServiceBloc();

  // Constant
  final _serviceNameTextStyle = TextStyle(fontSize: 15);

  // Data
  String _myLocationName;

  @override
  void initState() {
    super.initState();

    // Fetch saved my location.
    _fetchMyLocation();
  }

  @override
  void dispose() {
    _shopListBloc.dispose();
    _homeBannerBloc.dispose();
    _serviceBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      ListView(
        children: [
          SizedBox(height: 40),
          _buildBannerSlider(),
          _buildServicesSection(),
        ],
      ),
      HomeToolBar(
        locationName: _myLocationName,
        scaffoldKey: widget.scaffoldKey,
      ),
    ]);
  }

  /// Fetches saved my location.
  Future _fetchMyLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final myLocationName = prefs.getString('myLocationName');
    final myLocationLatitude = prefs.getDouble('myLatitude');
    final myLocationLongitude = prefs.getDouble('myLongitude');
    if (myLocationLatitude != null && myLocationLongitude != null) {
      setState(() {
        _myLocationName = myLocationName ?? AppLocalizations.of(context).tr('home_current_location');
      });
    } else {
      setState(() {
        _myLocationName = null;
      });
    }
  }

  /// Builds the banner slider.
  Widget _buildBannerSlider() {
    return StreamBuilder<ApiResponse<List<HomeBanner>>>(
      stream: _homeBannerBloc.homeBannerListStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case ResponseStatus.SUCCESS:
              return AspectRatio(
                aspectRatio: 3 / 2,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return CachedNetworkImage(
                      imageUrl: snapshot.data.data[index].imageUrl,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => LoadingIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    );
                  },
                  itemCount: 2,
                  pagination: SwiperPagination(),
                  autoplay: true,
                ),
              );
            default:
              return Container();
          }
        }
        return Container();
      },
    );
  }

  /// Builds the services section.
  Widget _buildServicesSection() {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
        height: 265,
        child: StreamBuilder<ApiResponse<List<Service>>>(
          stream: _serviceBloc.serviceListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.data != null) {
                final services = snapshot.data.data;
                final servicesCount = services.length;
                return Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildServiceColumn(index * 8 < servicesCount ? services[(index * 8)] : null),
                              _buildServiceColumn((index * 8) + 1 < servicesCount ? services[(index * 8) + 1] : null),
                              _buildServiceColumn((index * 8) + 2 < servicesCount ? services[(index * 8) + 2] : null),
                              _buildServiceColumn((index * 8) + 3 < servicesCount ? services[(index * 8) + 3] : null),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildServiceColumn((index * 8) + 4 < servicesCount ? services[(index * 8) + 4] : null),
                              _buildServiceColumn((index * 8) + 5 < servicesCount ? services[(index * 8) + 5] : null),
                              _buildServiceColumn((index * 8) + 6 < servicesCount ? services[(index * 8) + 6] : null),
                              _buildServiceColumn((index * 8) + 7 < servicesCount ? services[(index * 8) + 7] : null),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: (snapshot.data.data.length / 8).ceil(),
                  pagination: SwiperPagination(),
                );
              }
              return Container();
            }
            return Container();
          },
        ),
      ),
    );
  }

  /// Builds the service column from the [service] object.
  Widget _buildServiceColumn(Service service) {
    if (service != null) {
      return Expanded(
        child: InkWell(
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new ServiceListScreen(service: service)));
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CachedNetworkImage(
                    imageUrl: service.iconUrl != null ? service.iconUrl : "",
                    fit: BoxFit.fill,
                    width: 60,
                    height: 60,
                    placeholder: (context, url) => LoadingIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(
                    service.name,
                    style: _serviceNameTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Expanded(child: Container());
    }
  }
}
