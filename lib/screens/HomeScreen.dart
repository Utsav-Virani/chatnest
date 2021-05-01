import 'package:chatnest/Helpers/HelperWidgets.dart';
import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/screens/SearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.amber,
        centerTitle: true,
        backgroundColor: ColorPalette['primary'],
        title: Text(
          "CHATNEST",
          style: TextStyle(
            fontSize: 26,
          ),
        ),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.person_add_alt_1_outlined),
            onPressed: () {
              Navigator.of(context).push(
                // MaterialPageRoute(
                //   builder: (context) {
                //     return SearchScreen();
                //   },
                // ),
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: homeScreenDrawer(context),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: ColorPalette['primary'],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chat",
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorPalette['white_3'],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Text("Home"),
            ),
          ],
        ),
      ),
    );
  }
}
