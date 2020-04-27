// import 'package:flutter/material.dart';
// import 'package:haircut_delivery/clientapp/datas/client_app_services.dart';
// import 'package:haircut_delivery/clientapp/datas/client_app_shops.dart';
// import 'package:haircut_delivery/clientapp/models/client_app_service.dart';
// import 'package:haircut_delivery/clientapp/screens/activity/widgets/activity_item.dart';
// import 'package:haircut_delivery/clientapp/ui/appbar/client_app_default_appbar.dart';
// import 'package:haircut_delivery/clientapp/ui/client_app_drawer.dart';
// import 'package:haircut_delivery/marketplace/config/all_constants.dart';
// import 'package:haircut_delivery/marketplace/styles/text_style_with_locale.dart';
// import 'package:haircut_delivery/ui/tool_bar.dart';
// import 'package:haircut_delivery/util/ui_util.dart';

// class ClientAppHistoryPage extends StatefulWidget {
//   // Global key

//   ClientAppHistoryPage({Key key}) : super(key: key);

//   @override
//   _ClientAppHistoryPageState createState() => _ClientAppHistoryPageState();
// }

// class _ClientAppHistoryPageState extends State<ClientAppHistoryPage> {
//   HistoryType _activityState;

//   @override
//   void initState() {
//     super.initState();
//     _activityState = HistoryType.ALL;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Set the status bar's color.
//     UiUtil.changeStatusColor(const Color.fromARGB(255, 67, 66, 73));

//     return Scaffold(
//       body: SafeArea(
//         bottom: false,
//         child: Stack(
//           children: <Widget>[
//             Container(
//               color: Colors.white,
//               padding: EdgeInsets.only(
//                   top: TOOL_BAR_HEIGHT, left: 15, right: 15, bottom: 25),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   SizedBox(height: 20),
//                   _builBtns(),
//                   SizedBox(height: 20),
//                   _buildListView(),
//                 ],
//               ),
//             ),
//             Container(
//               height: marketPlaceToolbarHeight,
//               child: ClientAppDefaultAppBar(
//                 title: Text(
//                   'Point History',
//                   style: textStyleWithLocale(
//                     context: context,
//                     color: Colors.white,
//                     fontSize: 18,
//                   ),
//                 ),
//                 context: context,
//                 isBack: true,
//                 isShowCart: false,
//                 isShowMenu: false,
//                 onPressedBackBtn: () => Navigator.pop(context),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _builBtns() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         Expanded(
//           flex: 1,
//           child: ClipRRect(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(10),
//             ),
//             child: Container(
//               height: 45,
//               color: _activityState == HistoryType.ALL
//                   ? Color(0xffDD133B)
//                   : Color(0xffF9CCD0),
//               child: FlatButton(
//                 onPressed: () {
//                   setState(() {
//                     _activityState = HistoryType.ALL;
//                   });
//                 },
//                 child: Text(
//                   'All',
//                   style: _activityState == HistoryType.ALL
//                       ? _whiteText()
//                       : _redText(),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 1,
//           child: Container(
//             height: 45,
//             color: _activityState == HistoryType.GET_POINT
//                 ? Color(0xffDD133B)
//                 : Color(0xffF9CCD0),
//             child: FlatButton(
//               onPressed: () {
//                 setState(() {
//                   _activityState = HistoryType.GET_POINT;
//                 });
//               },
//               child: Text(
//                 'Get Point',
//                 style: _activityState == HistoryType.GET_POINT
//                     ? _whiteText()
//                     : _redText(),
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 1,
//           child: ClipRRect(
//             borderRadius: BorderRadius.only(
//               topRight: Radius.circular(10),
//             ),
//             child: Container(
//               height: 45,
//               color: _activityState == HistoryType.REDEEM
//                   ? Color(0xffDD133B)
//                   : Color(0xffF9CCD0),
//               child: FlatButton(
//                 onPressed: () {
//                   setState(() {
//                     _activityState = HistoryType.REDEEM;
//                   });
//                 },
//                 child: Text(
//                   'Redeem',
//                   style: _activityState == HistoryType.REDEEM
//                       ? _whiteText()
//                       : _redText(),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   TextStyle _redText() {
//     return textStyleWithLocale(
//         context: context, color: Color(0xffE2002D), fontSize: 16);
//   }

//   TextStyle _whiteText() {
//     return textStyleWithLocale(
//         context: context, color: Colors.white, fontSize: 16);
//   }

//   Widget _buildListView() {
//     List<ClientAppService> list;
//     if (_activityState == HistoryType.ALL) {
//       list = all;
//     } else if (_activityState == HistoryType.GET_POINT) {
//       list = getpoint;
//     } else {
//       list = redeem;
//     }

//     return Expanded(
//       child: ListView.builder(
//         shrinkWrap: true,
//         itemBuilder: (BuildContext context, int index) {
//           var shop = clientAppShops
//               .firstWhere((item) => item.shopId == list[index].shopId);
//           return ActivityItem(
//             service: list[index],
//             shop: shop,
//           );
//         },
//         itemCount: list.length,
//       ),
//     );
//   }
// }

// enum HistoryType { ALL, GET_POINT, REDEEM }
