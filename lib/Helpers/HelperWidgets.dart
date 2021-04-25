import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:flutter/material.dart';

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
