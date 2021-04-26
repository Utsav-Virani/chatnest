import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/screens/HomeScreen.dart';
import 'package:chatnest/screens/auth/SignInScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              // color: ColorPalette['primary'],
              // child: Image.asset(
              //   "assets/images/ChatNest.png",
              //   height: 200,
              //   width: 100,
              // ),
              child: SvgPicture.asset(
                'assets/svgs/ChatNest_logo_white.svg',
                width: MediaQuery.of(context).size.width * 0.6,
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome To ",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.07,
                        fontFamily: "OpenSans",
                        color: ColorPalette['gray_4'],
                      ),
                    ),
                    Text(
                      "ChetNest",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                        fontFamily: 'OpenSans',
                        color: ColorPalette['primary'],
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Text(
                        "Simple and secure way for",
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          color: ColorPalette['gray_3'],
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Connecting People.",
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          color: ColorPalette['gray_3'],
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return SignInScreen();
                    },
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: ColorPalette['primary'],
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF000000).withOpacity(0.3),
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                      offset: Offset(
                        4.0,
                        4.0,
                      ),
                    ),
                  ],
                ),
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    color: ColorPalette['white_2'],
                    // fontWeight: FontWeight.bold,
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
