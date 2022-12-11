// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:riyadhmarket/components/safe_area/page_container.dart';
// import 'package:riyadhmarket/locale/localization.dart';
// import 'package:riyadhmarket/screens/notifications/components/notification_item.dart';
// import 'package:riyadhmarket/utils/app_colors.dart';

// class NotificationsScreen extends StatefulWidget {
//   NotificationsScreen({Key key}) : super(key: key);

//   @override
//   _NotificationsScreenState createState() => _NotificationsScreenState();
// }

// class _NotificationsScreenState extends State<NotificationsScreen> {
//   double _height, _width;

//   Widget _buildBodyItem() {
  
//     return ListView.builder(
//       itemCount: 6,
//       itemBuilder: 
//     (BuildContext context ,int index)
//     {
//   return Container(
//     width: _width,
//     height: _height *0.17,
//     child: NotificationItem(),
//   );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//        _width = MediaQuery.of(context).size.width;
       
//     final appBar = AppBar(
//       centerTitle: true,
//       title: Text(AppLocalizations.of(context).notifications, style: Theme.of(context).textTheme.display1),
//       actions: <Widget>[
//        Container(
//           margin: EdgeInsets.symmetric(horizontal: _width * 0.03),
//           child:  Image.asset('assets/images/trash.png',color:cWhite ,height: 25,width: 25,),
//         )
//       ],
//     );

//     _height = MediaQuery.of(context).size.height -
//         appBar.preferredSize.height -
//         MediaQuery.of(context).padding.top;

        
 
//     return PageContainer(
//       child: Scaffold(
//         appBar: appBar,
//         body: _buildBodyItem(),
//       ),
//     );
//   }
// }
