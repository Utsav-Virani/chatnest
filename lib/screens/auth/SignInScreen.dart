import 'package:adobe_xd/adobe_xd.dart';
import 'package:chatnest/Helpers/CountrySelecter.dart';
import 'package:chatnest/Helpers/HelperWidgets.dart';
import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/screens/WelcomeScreen.dart';
import 'package:chatnest/screens/auth/OTPScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  bool isMobileInvalid = false;

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
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(80),
      //   child: appBar(context, title: "OTP Verification"),
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // padding: EdgeInsets.symmetric(vertical: 20),
        // color: Colors.amber,
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25.0),
                  bottomLeft: Radius.circular(25.0),
                ),
                color: const Color(0xff171c26),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                transitionDuration: Duration(seconds: 0),
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        WelcomeScreen(),
                              ),
                            );
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => WelcomeScreen(),
                            //   ),
                            // );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SvgPicture.string(
                              _svg_8s8yfm,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        Text(
                          'Verification',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 26,
                            color: const Color(0xfffefefe),
                            letterSpacing: 2.262,
                            fontWeight: FontWeight.w700,
                            height: 0.6538461538461539,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 95,
                  ),
                  Container(
                    height: 55,
                    // color: Colors.amber,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'We will send you an OTP.',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 24,
                        color: const Color(0xfffff0ea),
                        letterSpacing: 0.48,
                        height: 0.7083333333333334,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Expanded(
              // color: Colors.amber,
              // margin: EdgeInsets.only(top: 30),
              // // height: MediaQuery.of(context).size.height * 0.3,
              // padding: EdgeInsets.symmetric(vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: const Color(0xffe5e5e6),
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          // enabledBorder: UnderlineInputBorder(
                          //   borderSide: BorderSide(
                          //     color: ColorPalette['gray_3'],
                          //   ),
                          // ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 16, right: 16),
                          // focusedBorder: UnderlineInputBorder(
                          //   borderSide: BorderSide(color: ColorPalette['gray_3']),
                          // ),
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
                    SizedBox(
                      height: 32,
                    ),
                    Form(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color(0xffe5e5e6),
                            ),
                            width: 60,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              enabled: false,
                              controller: _phoneCodeController,
                              cursorColor: ColorPalette['gray_4'],
                              decoration: InputDecoration(
                                hintText: "+91",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(left: 16, right: 16),
                                fillColor: ColorPalette['gray_4'],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color(0xffe5e5e6),
                            ),
                            // height: 60,
                            // width: MediaQuery.of(context).size.width * 0.5,
                            width: MediaQuery.of(context).size.width * 0.65,
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
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 16, right: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // isMobileInvalid
                    //     ? Container(
                    //         height: 20,
                    //         child: Text(
                    //           "Invalid Mobile Number",
                    //           style: TextStyle(color: Colors.red),
                    //         ),
                    //       )
                    //     : Container(
                    //         height: 20,
                    //       ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.7,
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xffff7847),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x80ff7847),
                            offset: Offset(
                              4,
                              4,
                            ),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          // if (!_formKey.currentState.validate()) {
                          //   setState(() {
                          //     isMobileInvalid = true;
                          //   });
                          // }
                          if (_formKey.currentState.validate()) {
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                transitionDuration: Duration(seconds: 0),
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        OTPScreen(
                                  phoneNumber: _phoneCodeController.text +
                                      _phoneNumberController.text,
                                ),
                              ),
                            );
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => OTPScreen(
                            //       phoneNumber: _phoneCodeController.text +
                            //           _phoneNumberController.text,
                            //     ),
                            //   ),
                            // );
                          }
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            'Send OTP',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 24,
                              // backgroundColor: Colors.amber,
                              color: const Color(0xfffefefe),
                              letterSpacing: 1.4000000000000001,
                              fontWeight: FontWeight.w700,
                              height: 0.6071428571428571,
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const String _svg_8s8yfm =
    '<svg viewBox="0.0 0.0 30.0 30.0" ><path  d="M 0 15 C 0 6.728467464447021 6.728467464447021 0 15 0 C 23.27153396606445 0 30 6.728467464447021 30 15 C 30 23.27153396606445 23.27153396606445 30 15 30 C 6.728467464447021 30 0 23.27153396606445 0 15 Z M 2.250472545623779 15 C 2.250472545623779 22.03087043762207 7.970479965209961 27.75087928771973 15 27.75087928771973 C 22.03087043762207 27.75087928771973 27.75087928771973 22.03087043762207 27.75087928771973 15 C 27.75087928771973 7.970479965209961 22.03087043762207 2.250472545623779 15 2.250472545623779 C 7.970479965209961 2.250472545623779 2.250472545623779 7.970479965209961 2.250472545623779 15 Z M 16.37026405334473 21.00216102600098 L 11.14031219482422 15.79785823822021 C 10.92835903167725 15.58590602874756 10.8095588684082 15.29970359802246 10.8095588684082 15 C 10.8095588684082 14.70164775848389 10.92835903167725 14.41409492492676 11.14031219482422 14.20349311828613 L 16.37026405334473 8.996490478515625 C 16.81036949157715 8.559085845947266 17.52047538757324 8.559085845947266 17.96058082580566 8.999190330505371 C 18.39933395385742 9.440645217895508 18.39663505554199 10.15345191955566 17.9578800201416 10.59085655212402 L 13.52983570098877 15 L 17.9578800201416 19.40914535522461 C 18.39663505554199 19.84789848327637 18.39933395385742 20.55935668945313 17.96058082580566 20.99946022033691 C 17.74187850952148 21.22221374511719 17.45162582397461 21.33156394958496 17.16407203674316 21.33156394958496 C 16.87787055969238 21.33156394958496 16.58896636962891 21.22221374511719 16.37026405334473 21.00216102600098 Z" fill="#ff7847" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
