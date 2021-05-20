import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/screens/MyProfileScreen.dart';
import 'package:chatnest/screens/WelcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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

class BottomNavigator extends StatefulWidget {
  final int selectedIndx;
  BottomNavigator({this.selectedIndx});
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _page = 0;

  @override
  void initState() {
    _page = widget.selectedIndx is Null ? 0 : widget.selectedIndx;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // child: ,
      // color: Colors.blue,
      height: MediaQuery.of(context).size.height * 0.1,
      padding: EdgeInsets.symmetric(horizontal: 20),
      // color: Colors.amberAccent,
      child: Container(
        decoration: BoxDecoration(
          // color: ColorPalette['nav_bar'],
          // color: Color(0xFFd9a072),
          borderRadius: BorderRadius.only(
            // topLeft: Radius.circular(100),
            topLeft: Radius.elliptical(140, 35),
            topRight: Radius.elliptical(140, 35),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _page = 0;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _page == 0 ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  LineIcons.home,
                  size: _page == 0 ? 26 : 24,
                  color: _page == 0 ? ColorPalette['nav_bar'] : Colors.black,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _page = 1;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _page == 1 ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  LineIcons.phone,
                  size: _page == 1 ? 26 : 24,
                  color: _page == 1 ? ColorPalette['nav_bar'] : Colors.black,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _page = 2;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _page == 2 ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  LineIcons.search,
                  size: _page == 2 ? 26 : 24,
                  color: _page == 2 ? ColorPalette['nav_bar'] : Colors.black,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _page = 3;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _page == 4 ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Ionicons.person_add_outline,
                  size: _page == 3 ? 26 : 24,
                  color: _page == 3 ? ColorPalette['nav_bar'] : Colors.black,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _page = 4;
                });
                Navigator.of(context).pushReplacement(PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 400),
                  pageBuilder: (context, animation1, animation2) {
                    return MyProfile(
                      selectedIndx: _page,
                    );
                  }));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _page == 4 ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  LineIcons.user,
                  size: _page == 4 ? 26 : 24,
                  color: _page == 4 ? ColorPalette['nav_bar'] : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
