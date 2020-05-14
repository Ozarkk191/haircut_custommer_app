// import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:haircut_delivery/model/prediction.dart';
// import 'package:google_maps_webservice/places.dart';

const TOOL_BAR_HEIGHT = 65.0;

/// Transparent tool bar with a Back button.
class TransparentToolBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: FlatButton(
        child: new Text(
          tr('tool_bar_back_button'),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.normal,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

/// Primary tool bar with a back button.
class PrimaryToolBar extends StatelessWidget {
  final String title;

  PrimaryToolBar({this.title, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: TOOL_BAR_HEIGHT,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: IconButton(
                  icon: Image.asset('assets/images/ic_back.png'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                title != null ? title : '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Home tool bar with a back button, a location search box, a cart button, and a hamburger button.
class HomeToolBar extends StatelessWidget {
  final String locationName;
  final GlobalKey<ScaffoldState> scaffoldKey;

  HomeToolBar({this.locationName, this.scaffoldKey, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 30,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Image.asset('assets/images/ic_marker_2.png'),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, right: 10),
                            child: Text(
                              locationName ?? 'home_pin_location',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(locationName != null
                                    ? 0xFF707070
                                    : 0x66707070),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Image.asset('assets/images/ic_cart.png'),
                  onPressed: null,
                ),
                IconButton(
                  icon: Image.asset('assets/images/ic_heart.png'),
                  onPressed: null,
                ),
                IconButton(
                  icon: Image.asset('assets/images/ic_hamburger.png'),
                  onPressed: () {
                    if (scaffoldKey != null) {
                      scaffoldKey.currentState.openEndDrawer();
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}

/// Tool bar with a search suggestion.
class PlaceAutocompleteToolBar extends StatelessWidget {
  final Key searchFieldKey;
  final String hintText;
  final List<Prediction> suggestions;
  final StringCallback onTextChanged;
  final InputEventCallback<Prediction> onItemSubmitted;

  PlaceAutocompleteToolBar(this.suggestions,
      {this.searchFieldKey,
      this.onTextChanged,
      this.onItemSubmitted,
      this.hintText,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
      borderRadius: const BorderRadius.all(const Radius.circular(30.0)),
    );
    return SizedBox(
      width: double.infinity,
      height: TOOL_BAR_HEIGHT,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: IconButton(
                  icon: Image.asset('assets/images/ic_back.png'),
                  onPressed: () {},
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 70, right: 15),
                child: SizedBox(
                  height: 40,
                  child: AutoCompleteTextField<Prediction>(
                    key: searchFieldKey,
                    suggestions: suggestions,
                    textChanged: onTextChanged,
                    itemSubmitted: onItemSubmitted,
                    submitOnSuggestionTap: true,
                    clearOnSubmit: false,
                    itemBuilder: (context, suggestion) => new Padding(
                      child:
                          new ListTile(title: new Text(suggestion.description)),
                      padding: EdgeInsets.all(8.0),
                    ),
                    itemFilter: (suggestion, input) => true,
                    itemSorter: (a, b) => 0,
                    decoration: new InputDecoration(
                      enabledBorder: border,
                      disabledBorder: border,
                      focusedBorder: border,
                      errorBorder: border,
                      focusedErrorBorder: border,
                      filled: true,
                      hintStyle: new TextStyle(color: const Color(0x88707070)),
                      hintText: hintText,
                      fillColor: const Color(0xFFEEEEEE),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
