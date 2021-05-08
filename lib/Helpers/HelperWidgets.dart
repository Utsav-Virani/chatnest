import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/screens/WelcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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

Widget bottomNavigator(BuildContext context) {
  return CurvedNavigationBar(
    items: [],
  );
}
