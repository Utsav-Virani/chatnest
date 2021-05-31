import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/screens/HomeScreen.dart';
import 'package:chatnest/screens/SearchScreen.dart';
import 'package:chatnest/screens/WelcomeScreen.dart';
import 'package:chatnest/screens/WelcomeScreen.dart';
import 'package:chatnest/screens/auth/CredentialsScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ChatNest",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        brightness: Brightness.light,
        primaryColor: ColorPalette['primary'],
        primarySwatch: Colors.orange,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapsort) {
          if (userSnapsort.hasData) {
            if (FirebaseAuth.instance.currentUser.email != null) {
              return HomeScreen();
              // return CredentialsScreen();
            } else {
              return CredentialsScreen();
            }
          } else {
            return SafeArea(
              child: WelcomeScreen(),
            );
          }
        },
      ),
    );
  }
}
