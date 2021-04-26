import 'package:chatnest/Helpers/HelperWidgets.dart';
import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/config/database.dart';
import 'package:chatnest/data/UserdataCollection.dart';
import 'package:chatnest/screens/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CredentialsScreen extends StatefulWidget {
  @override
  _CredentialsScreenState createState() => _CredentialsScreenState();
}

class _CredentialsScreenState extends State<CredentialsScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isLogginIn = false;
  QuerySnapshot userInfo;

  DataBaseMethods databaseMethods = new DataBaseMethods();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  userSignUp() async {
    Map<String, String> userData = {
      "name": _userNameController.text,
      "email": _emailController.text,
      "phonenumber": FirebaseAuth.instance.currentUser.phoneNumber,
    };

    try {
      // User authResult = await _authMethod.signUpWithEmail(
      // _emailController.text, .text);
      // print("-----");
      // print(authResult.uid);
      // print("-----");

      databaseMethods.uploadUserInfo(
          userData, FirebaseAuth.instance.currentUser.uid);

      await FirebaseAuth.instance.currentUser.updateProfile(
        displayName: _userNameController.text,
      );
      await FirebaseAuth.instance.currentUser
          .updateEmail(_emailController.text);

      DataStorage.setUserSignInPreference(true);
      DataStorage.setUserEmailPreference(_emailController.text);
      DataStorage.setUserNamePreference(_userNameController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLogginIn = false;
      });

      var errorMsg = "Invalid Credentials. Please enter valid information.";
      if (e.message != null) {
        errorMsg = e.message;
      }
      setState(() {
        // isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMsg)));
    }
  }

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  _getUserData() async {
    if (FirebaseAuth.instance.currentUser.email != null ||
        FirebaseAuth.instance.currentUser.displayName != null) {
      _emailController.text = FirebaseAuth.instance.currentUser.email;
      _userNameController.text = FirebaseAuth.instance.currentUser.displayName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLogginIn
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: appBar(
                context,
                title: "Credentials",
              ),
            ),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "We need bellow details",
                          style: TextStyle(
                            fontSize: 24,
                            color: ColorPalette['gray_4'],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "To prepair your Dashboard",
                          style: TextStyle(
                            fontSize: 24,
                            color: ColorPalette['gray_4'],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          color: ColorPalette['gray_0'],
                          height: 2,
                          width: 200,
                        )
                      ],
                    ),
                  ),
                  Container(
                    // height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.8,
                    // color: Colors.blueAccent,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 70,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
                              validator: (value) {
                                return value.isEmpty || value.length < 3
                                    ? "Invalid UserName"
                                    : null;
                              },
                              controller: _userNameController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'UserName:',
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: ColorPalette['gray_4'],
                                  width: 2,
                                )),
                                focusedBorder: UnderlineInputBorder(
                                  // borderRadius:
                                  //     BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(
                                    color: ColorPalette['gray_4'],
                                    width: 2,
                                  ),
                                ),
                                focusColor: ColorPalette['gray_4'],
                              ),
                              cursorColor: ColorPalette['gray_4'],
                            ),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          SizedBox(
                            height: 70,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)
                                    ? null
                                    : "Enter correct email";
                              },
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Email ID:',
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: ColorPalette['gray_4'],
                                )),
                                focusedBorder: UnderlineInputBorder(
                                  // borderRadius:
                                  //     BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(
                                    color: ColorPalette['gray_4'],
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLogginIn = true;
                      });
                      userSignUp();
                    },
                    child: Container(
                      // onPressed: _saveForm,
                      width: MediaQuery.of(context).size.width * 0.45,
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorPalette['primary'],
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF000000).withOpacity(0.2),
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                            offset: Offset(
                              4.0,
                              4.0,
                            ),
                          ),
                        ],
                        // gradient: LinearGradient(
                        //   colors: [
                        //     ColorPalette['swatch_5'],
                        //   ],
                        // ),
                      ),
                      child: Text(
                        "Go To Dashboard",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
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
