import 'package:chatnest/Helpers/HelperWidgets.dart';
import 'package:chatnest/Helpers/colorpanel.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      drawer: HomeScreenDrawer(context),
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
