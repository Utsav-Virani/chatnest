import 'package:chatnest/Helpers/CountrySelecter.dart';
import 'package:chatnest/Helpers/HelperWidgets.dart';
import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/screens/auth/OTPScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _countryNameController =
      new TextEditingController(text: "India");
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _phoneCodeController =
      new TextEditingController(text: "+91");

  @override
  void dispose() {
    _countryNameController.dispose();
    _phoneCodeController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: appBar(context, title: "OTP Verification"),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: EdgeInsets.symmetric(vertical: 20),
          // color: Colors.amber,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "We'll send you an OTP.",
                style: TextStyle(
                  fontSize: 24,
                  color: ColorPalette['gray_0'],
                  shadows: [
                    Shadow(
                      color: Color(0xFF121212).withOpacity(0.3),
                      blurRadius: 6.0,
                      offset: Offset(
                        2.0,
                        2.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // color: Colors.amber,
                margin: EdgeInsets.only(top: 30),
                height: MediaQuery.of(context).size.height * 0.3,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorPalette['gray_3'],
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorPalette['gray_3']),
                          ),
                        ),
                        onTap: () async {
                          final dynamic selectedCountryData =
                              await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountrySelecter()),
                          );
                          _countryNameController.text =
                              selectedCountryData['name'];
                          _phoneCodeController.text =
                              selectedCountryData['code'];
                        },

                        textAlign: TextAlign.center,
                        // enabled: false,
                        controller: _countryNameController,
                        // decoration: InputDecoration(),
                      ),
                    ),
                    Form(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 50,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              enabled: false,
                              controller: _phoneCodeController,
                              cursorColor: ColorPalette['gray_4'],
                              decoration: InputDecoration(
                                hintText: "+91",
                                fillColor: ColorPalette['gray_4'],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                controller: _phoneNumberController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (mobilenum) {
                                  return RegExp(r"^[6-9]\d{9}$")
                                          .hasMatch(mobilenum)
                                      ? null
                                      : "Invalid Mobile Number";
                                },
                                decoration: InputDecoration(
                                  hintText: "Mobile Number",
                                  hintStyle:
                                      TextStyle(color: ColorPalette['gray_4']),
                                  focusColor: ColorPalette['gray_4'],
                                  hoverColor: ColorPalette['gray_4'],
                                  fillColor: ColorPalette['gray_4'],
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorPalette['gray_3'],
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorPalette['gray_4'],
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 160,
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: ColorPalette['primary'],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OTPScreen(
                                  phoneNumber: _phoneCodeController.text +
                                      _phoneNumberController.text,
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          child: Text(
                            "Send OTP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
