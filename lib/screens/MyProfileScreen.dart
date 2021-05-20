import 'package:chatnest/Helpers/HelperWidgets.dart';
import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/screens/HomeScreen.dart';
import 'package:chatnest/screens/SearchScreen.dart';
import 'package:chatnest/screens/WelcomeScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';

class MyProfile extends StatefulWidget {
  final int selectedIndx;
  MyProfile({this.selectedIndx});

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  int _selectedIndex;

  GlobalKey _bottomNavigationKey = GlobalKey();
  int _page = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     '',
  //     // 'Home',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     '',
  //     // 'Search',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     '',
  //     // 'Request',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     '',
  //     // 'Profile',
  //     style: optionStyle,
  //   ),
  // ];

  @override
  void initState() {
    super.initState();
    // _page = widget.selectedIndx;
    _page = widget.selectedIndx is Null ? 4 : widget.selectedIndx;
  }

  // @override
  // void dispose() {
  //   setState(() {});
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: CurvedNavigationBar(
      //   key: _bottomNavigationKey,
      //   index: _page,
      //   height: 60.0,
      //   items: <Widget>[
      //     Padding(
      //       padding: const EdgeInsets.all(4.0),
      //       child: Icon(
      //         LineIcons.home,
      //         size: _page == 0 ? 33 : 30,
      //         // color: _page == 0 ? WhitePalette['white_4'] : Colors.black,
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(4.0),
      //       child: Icon(
      //         LineIcons.search,
      //         size: _page == 1 ? 33 : 30,
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(4.0),
      //       child: Icon(
      //         Ionicons.person_add_outline,
      //         size: _page == 2 ? 33 : 30,
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(4.0),
      //       child: Icon(
      //         LineIcons.user,
      //         size: _page == 3 ? 33 : 30,
      //       ),
      //     ),
      //   ],
      //   color: ColorPalette['primary'].withOpacity(0.67),
      //   buttonBackgroundColor: ColorPalette['primary'].withOpacity(0.67),
      //   backgroundColor: WhitePalette['white_4'],
      //   animationCurve: Curves.easeInOut,
      //   animationDuration: Duration(milliseconds: 400),
      //   onTap: (index) {
      //     switch (index) {
      //       case 0:
      //         Navigator.of(context).pushReplacement(PageRouteBuilder(
      //             transitionDuration: Duration(milliseconds: 400),
      //             pageBuilder: (context, animation1, animation2) {
      //               return HomeScreen(
      //                 selectedIndx: index,
      //               );
      //             }));
      //         break;
      //       case 1:
      //         Navigator.of(context).pushReplacement(PageRouteBuilder(
      //             transitionDuration: Duration(milliseconds: 400),
      //             pageBuilder: (context, animation1, animation2) {
      //               return SearchScreen(
      //                 selectedIndx: index,
      //               );
      //             }));
      //         break;
      //       case 2:
      //         Navigator.of(context).pushReplacement(PageRouteBuilder(
      //             transitionDuration: Duration(milliseconds: 400),
      //             pageBuilder: (context, animation1, animation2) {
      //               return SearchScreen(
      //                 selectedIndx: index,
      //               );
      //             }));
      //         break;
      //       case 3:
      //         Navigator.of(context).pushReplacement(PageRouteBuilder(
      //             transitionDuration: Duration(milliseconds: 400),
      //             pageBuilder: (context, animation1, animation2) {
      //               return MyProfile(
      //                 selectedIndx: index,
      //               );
      //             }));
      //         break;
      //       default:
      //     }
      //     setState(() {
      //       _page = index;
      //     });
      //   },
      //   letIndexChange: (index) => true,
      // ),

bottomNavigationBar: BottomNavigator(
        selectedIndx: _page,
      ),

      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         blurRadius: 20,
      //         color: Colors.black.withOpacity(.1),
      //       )
      //     ],
      //   ),
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      //       child: GNav(
      //         rippleColor: Colors.grey[300],
      //         hoverColor: Colors.grey[100],
      //         gap: 8,
      //         activeColor: Colors.black,
      //         iconSize: 24,
      //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      //         duration: Duration(milliseconds: 500),
      //         tabBackgroundColor: ColorPalette['primary'].withOpacity(0.7),
      //         color: Colors.black,
      //         tabs: [
      //           GButton(
      //             icon: LineIcons.home,
      //             // text: '',
      //             // text: 'Home',
      //             onPressed: () {
      //               Navigator.of(context).pushReplacement(
      //                 PageRouteBuilder(
      //                   transitionDuration: Duration(seconds: 0),
      //                   pageBuilder: (context, animation1, animation2) =>
      //                       HomeScreen(
      //                     selectedIndx: _selectedIndex,
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //           GButton(
      //             icon: LineIcons.search,
      //             // text: '',
      //             // text: 'Search',
      //             onPressed: () {
      //               Navigator.of(context).pushReplacement(
      //                 PageRouteBuilder(
      //                   transitionDuration: Duration(seconds: 0),
      //                   pageBuilder: (context, animation1, animation2) =>
      //                       SearchScreen(
      //                     selectedIndx: _selectedIndex,
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //           GButton(
      //             icon: Ionicons.person_add_outline,
      //             // text: '',
      //             // text: 'Request',
      //           ),
      //           GButton(
      //             icon: LineIcons.user,
      //             // text: '',
      //             // text: 'Profile',
      //             // onPressed: () {
      //             //   Navigator.of(context).push(
      //             //     MaterialPageRoute(
      //             //       builder: (context) {
      //             //         return MyProfile(
      //             //           selectedIndx: _selectedIndex,
      //             //         );
      //             //       },
      //             //     ),
      //             //   );
      //             // },
      //           ),
      //         ],
      //         selectedIndex: _selectedIndex,
      //         onTabChange: (index) {
      //           setState(() {
      //             _selectedIndex = index;
      //           });
      //         },
      //       ),
      //     ),
      //   ),
      // ),
      body: Container(
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
      ),
    );
  }
}
