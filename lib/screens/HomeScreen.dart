import 'package:chatnest/Helpers/HelperWidgets.dart';
import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/screens/WelcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, title: "CHATNEST"),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: MaterialButton(
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
            ),
          ],
        ),
      ),
      body: Container(
        child: Text("Home"),
      ),
    );
  }
}
