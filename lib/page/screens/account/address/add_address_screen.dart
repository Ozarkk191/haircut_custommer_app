import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haircut_delivery/bloc/validate/validate_bloc.dart';
import 'package:haircut_delivery/page/base_components/appbar/client_app_normal_appbar.dart';
import 'package:haircut_delivery/page/base_components/buttons/big_round_button.dart';
import 'package:haircut_delivery/page/base_components/maps/location_map.dart';
import 'package:haircut_delivery/page/base_components/seperate_lines/text_line.dart';
import 'package:haircut_delivery/page/base_components/textfield/big_round_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  String _titleAddress = "";
  String _address = "";

  bool _check() {
    if (_titleAddress == "" || _address == "") {
      return false;
    } else {
      return true;
    }
  }

  _saveStringAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('address_string', "$_address");
    print("save $_address");
  }

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final ValidateBloc _bloc = context.bloc<ValidateBloc>();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 120,
                  ),
                  TextLine(title: 'เพิ่มที่อยู่'),
                  BlocBuilder<ValidateBloc, ValidateState>(
                      builder: (BuildContext context, ValidateState state) {
                    if (state is FirstErrorState) {
                      return BigRoundTextField(
                        hintText: 'Title Address',
                        marginTop: 20,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          _bloc.add(FirstnameFieldEvent(value: value));
                          setState(() {
                            _titleAddress = value;
                          });
                        },
                        errorText: state.errorText,
                      );
                    } else {
                      return BigRoundTextField(
                        hintText: 'Title Address',
                        marginTop: 20,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          _bloc.add(FirstnameFieldEvent(value: value));
                          setState(() {
                            _titleAddress = value;
                          });
                        },
                      );
                    }
                  }),
                  BlocBuilder<ValidateBloc, ValidateState>(
                      builder: (BuildContext context, ValidateState state) {
                    if (state is AddressErrorState) {
                      return BigRoundTextField(
                        marginTop: 20,
                        hintText: 'address',
                        maxLines: 4,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          _bloc.add(AddressFieldEvent(value: value));
                          setState(() {
                            _address = value;
                          });
                        },
                        errorText: state.errorText,
                      );
                    } else {
                      return BigRoundTextField(
                        marginTop: 20,
                        hintText: 'address',
                        maxLines: 4,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          _bloc.add(AddressFieldEvent(value: value));
                          setState(() {
                            _address = value;
                          });
                        },
                      );
                    }
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  BigRoundButton(
                    callback: !_check()
                        ? null
                        : () {
                            _saveStringAddress();
                          },
                    color: !_check() ? Colors.grey : Color(0xffDD133B),
                    textButton: 'Save',
                  ),
                  LocationMap(
                    latitude: 16.0990849,
                    longitude: 99.5077678,
                    shopAddress: 'บ้าน',
                    shopName: 'myHome',
                  ),
                ],
              ),
            ),
          ),
          ClientAppNormalAppBar(title: 'เพิ่มที่อยู่')
        ],
      ),
    );
  }
}
