import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:flutter/material.dart';

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
              color: ColorPalette['primary'],
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
                      ),
                    ),
                    Text(
                      "ChetNest",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                        fontFamily: 'OpenSans',
                        color: ColorPalette['primary'],
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
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Connecting People.",
                        style: TextStyle(
                          fontFamily: "OpenSans_Light",
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 24,
                      color: ColorPalette['primary'],
                      fontWeight: FontWeight.bold,
                    ),
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
