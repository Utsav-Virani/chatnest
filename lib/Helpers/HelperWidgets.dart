import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/screens/HomeScreen.dart';
import 'package:chatnest/screens/MyProfileScreen.dart';
import 'package:chatnest/screens/SearchScreen.dart';
import 'package:chatnest/screens/WelcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';

Widget appBar(BuildContext context, {title}) {
  return AppBar(
    // backgroundColor: Colors.amber,
    centerTitle: true,
    backgroundColor: ColorPalette['primary'],
    title: Text(
      title,
      style: TextStyle(
        fontSize: 26,
      ),
    ),
    elevation: 0.0,
  );
}

Widget homeScreenDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: ColorPalette['primary'],
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF000000).withOpacity(0.35),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(
                  0.0,
                  3.0,
                ),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.bottomCenter,
                // color: Colors.orange,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      FirebaseAuth.instance.currentUser.displayName,
                      style: TextStyle(
                        color: ColorPalette['white_2'],
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser.email,
                      style: TextStyle(
                        color: ColorPalette['gray_2'],
                        fontFamily: 'OpenSans',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => WelcomeScreen(),
                    ),
                  );
                },
                color: ColorPalette['yellow_2'],
                child: Text("Sign Out"),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Widget bottomNavigator(BuildContext context) {}

// class BottomNavigator extends StatefulWidget {
//   final int selectedIndx;
//   BottomNavigator({this.selectedIndx});
//   @override
//   _BottomNavigatorState createState() => _BottomNavigatorState();
// }

// class _BottomNavigatorState extends State<BottomNavigator> {
//   int _page = 0;

//   @override
//   void initState() {
//     _page = widget.selectedIndx is Null ? 0 : widget.selectedIndx;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // child: ,
//       // color: Colors.blue,
//       height: MediaQuery.of(context).size.height * 0.1,
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       // color: Colors.amberAccent,
//       child: Container(
//         decoration: BoxDecoration(
//           // color: ColorPalette['nav_bar'],
//           // color: Color(0xFFd9a072),
//           borderRadius: BorderRadius.only(
//             // topLeft: Radius.circular(100),
//             topLeft: Radius.elliptical(140, 35),
//             topRight: Radius.elliptical(140, 35),
//           ),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _page = 0;
//                 });
//                 Navigator.of(context).pushReplacement(
//                   PageRouteBuilder(
//                     transitionDuration: Duration(seconds: 0),
//                     pageBuilder: (context, animation1, animation2) =>
//                         HomeScreen(
//                       selectedIndx: _page,
//                     ),
//                   ),
//                 );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: _page == 0 ? Colors.black : Colors.transparent,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(50),
//                   ),
//                 ),
//                 padding: const EdgeInsets.all(12.0),
//                 child: Icon(
//                   LineIcons.home,
//                   size: _page == 0 ? 26 : 24,
//                   color: _page == 0 ? ColorPalette['nav_bar'] : Colors.black,
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _page = 1;
//                 });
//                 // Navigator.of(context).pushReplacement(
//                 //   PageRouteBuilder(
//                 //     transitionDuration: Duration(seconds: 0),
//                 //     pageBuilder: (context, animation1, animation2) =>
//                 //         CallScreen(
//                 //       selectedIndx: _page,
//                 //     ),
//                 //   ),
//                 // );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: _page == 1 ? Colors.black : Colors.transparent,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(50),
//                   ),
//                 ),
//                 padding: const EdgeInsets.all(12.0),
//                 child: Icon(
//                   LineIcons.phone,
//                   size: _page == 1 ? 26 : 24,
//                   color: _page == 1 ? ColorPalette['nav_bar'] : Colors.black,
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _page = 2;
//                 });
//                 Navigator.of(context).pushReplacement(
//                   PageRouteBuilder(
//                     transitionDuration: Duration(seconds: 0),
//                     pageBuilder: (context, animation1, animation2) =>
//                         SearchScreen(
//                       // selectedIndx: _page,
//                     ),
//                   ),
//                 );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: _page == 2 ? Colors.black : Colors.transparent,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(50),
//                   ),
//                 ),
//                 padding: const EdgeInsets.all(12.0),
//                 child: Icon(
//                   LineIcons.search,
//                   size: _page == 2 ? 26 : 24,
//                   color: _page == 2 ? ColorPalette['nav_bar'] : Colors.black,
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   // _page = 2;
//                 });
//                 // Navigator.of(context).pushReplacement(
//                 //   PageRouteBuilder(
//                 //     transitionDuration: Duration(seconds: 0),
//                 //     pageBuilder: (context, animation1, animation2) =>
//                 //         SearchScreen(
//                 //       selectedIndx: _page,
//                 //     ),
//                 //   ),
//                 // );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: _page == 2 ? Colors.black : Colors.transparent,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(50),
//                   ),
//                 ),
//                 padding: const EdgeInsets.all(12.0),
//                 child: SvgPicture.asset("assets/svgs/ChatNest_outline.svg",height: 26,),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _page = 3;
//                 });
//                 // Navigator.of(context).pushReplacement(
//                 //   PageRouteBuilder(
//                 //     transitionDuration: Duration(seconds: 0),
//                 //     pageBuilder: (context, animation1, animation2) =>
//                 //         RequestScreen(
//                 //       selectedIndx: _page,
//                 //     ),
//                 //   ),
//                 // );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: _page == 3 ? Colors.black : Colors.transparent,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(50),
//                   ),
//                 ),
//                 padding: const EdgeInsets.all(12.0),
//                 child: Icon(
//                   Ionicons.person_add_outline,
//                   size: _page == 3 ? 26 : 24,
//                   color: _page == 3 ? ColorPalette['nav_bar'] : Colors.black,
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _page = 4;
//                 });
//                 Navigator.of(context).pushReplacement(
//                   PageRouteBuilder(
//                     transitionDuration: Duration(seconds: 0),
//                     pageBuilder: (context, animation1, animation2) =>
//                         MyProfile(
//                       selectedIndx: _page,
//                     ),
//                   ),
//                 );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: _page == 4 ? Colors.black : Colors.transparent,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(50),
//                   ),
//                 ),
//                 padding: const EdgeInsets.all(12.0),
//                 child: Icon(
//                   LineIcons.user,
//                   size: _page == 4 ? 26 : 24,
//                   color: _page == 4 ? ColorPalette['nav_bar'] : Colors.black,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

const String _svg_8s8yfm =
    '<svg viewBox="0.0 0.0 30.0 30.0" ><path  d="M 0 15 C 0 6.728467464447021 6.728467464447021 0 15 0 C 23.27153396606445 0 30 6.728467464447021 30 15 C 30 23.27153396606445 23.27153396606445 30 15 30 C 6.728467464447021 30 0 23.27153396606445 0 15 Z M 2.250472545623779 15 C 2.250472545623779 22.03087043762207 7.970479965209961 27.75087928771973 15 27.75087928771973 C 22.03087043762207 27.75087928771973 27.75087928771973 22.03087043762207 27.75087928771973 15 C 27.75087928771973 7.970479965209961 22.03087043762207 2.250472545623779 15 2.250472545623779 C 7.970479965209961 2.250472545623779 2.250472545623779 7.970479965209961 2.250472545623779 15 Z M 16.37026405334473 21.00216102600098 L 11.14031219482422 15.79785823822021 C 10.92835903167725 15.58590602874756 10.8095588684082 15.29970359802246 10.8095588684082 15 C 10.8095588684082 14.70164775848389 10.92835903167725 14.41409492492676 11.14031219482422 14.20349311828613 L 16.37026405334473 8.996490478515625 C 16.81036949157715 8.559085845947266 17.52047538757324 8.559085845947266 17.96058082580566 8.999190330505371 C 18.39933395385742 9.440645217895508 18.39663505554199 10.15345191955566 17.9578800201416 10.59085655212402 L 13.52983570098877 15 L 17.9578800201416 19.40914535522461 C 18.39663505554199 19.84789848327637 18.39933395385742 20.55935668945313 17.96058082580566 20.99946022033691 C 17.74187850952148 21.22221374511719 17.45162582397461 21.33156394958496 17.16407203674316 21.33156394958496 C 16.87787055969238 21.33156394958496 16.58896636962891 21.22221374511719 16.37026405334473 21.00216102600098 Z" fill="#ff7847" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
