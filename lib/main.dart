import 'package:flutter/material.dart';

import 'package:chatnest/screens/auth/AuthenticationCheck.dart';

void mian() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: AuthenticationCheck(),
    );
  }
}
