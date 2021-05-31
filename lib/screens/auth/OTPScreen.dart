import 'package:adobe_xd/adobe_xd.dart';
import 'package:chatnest/Helpers/HelperWidgets.dart';
import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/screens/auth/CredentialsScreen.dart';
import 'package:chatnest/screens/auth/SignInScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:circular_countdown/circular_countdown.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  OTPScreen({this.phoneNumber});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String verificationCode;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: const Color(0xffffcab7),
      // color: ColorPalette['secondary'].withOpacity(0.3),
      // border: Border.all(
      //   color: ColorPalette['secondary'],
      //   width: 2.5,
      // ),
      // borderRadius: BorderRadius.circular(18.0),
    );
  }

  @override
  void initState() {
    _verifyPhone();
    super.initState();
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {
          if (value != null) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                transitionDuration: Duration(seconds: 0),
                pageBuilder: (context, animation1, animation2) =>
                    CredentialsScreen(),
              ),
            );
          }
        });
      },
      verificationFailed: (FirebaseAuthException error) {
        print('----------error----------');
        print(error.message);
        print('==========error==========');
      },
      codeSent: (String verificationId, int resendToken) {
        print('----------sent----------');

        setState(() {
          verificationCode = verificationId;
        });
        print('==========sent==========');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('----------timeout----------');

        setState(() {
          verificationCode = verificationId;
        });
        print('==========timeout==========');
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: Duration(seconds: 0),
            pageBuilder: (context, animation1, animation2) => SignInScreen(),
          ),
        );
      },
      timeout: Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(70),
      //   child: appBar(
      //     context,
      //     title: "Enter Verification Code",
      //   ),
      // ),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              // padding: EdgeInsets.only(top: 50),
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25.0),
                  bottomLeft: Radius.circular(25.0),
                ),
                color: const Color(0xff171c26),
              ),

              // color: ColorPalette['secondary'],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 0),
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
                                        SignInScreen(),
                              ),
                            );
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => SignInScreen(),
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
                          'Confirmation',
                          style: TextStyle(
                            fontFamily: 'Montserrat_B',
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
                  Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      gradient: RadialGradient(
                        center: Alignment(0.0, 0.0),
                        radius: 0.5,
                        colors: [
                          const Color(0x1aff7847),
                          const Color(0x2aff7847)
                        ],
                        stops: [0.0, 1.0],
                        transform: GradientXDTransform(
                            1.0, 0.0, 0.0, 1.0, 0.0, 0.0, Alignment(0.0, 0.0)),
                      ),
                    ),
                    child: TimeCircularCountdown(
                      unit: CountdownUnit.second,
                      countdownTotal: 75,
                      countdownTotalColor: Colors.transparent,
                      countdownRemainingColor: Color(0xffff7847),
                      repeat: false,
                      strokeWidth: 5,
                      diameter: 180,
                      textStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 48,
                        color: const Color(0xffff7847),
                        letterSpacing: 2.4,
                        fontWeight: FontWeight.w700,
                        // height: 0.3541666666666667,
                      ),
                      // onUpdated: (unit, remainingTime) => print('Updated'),
                      onFinished: () {
                        // Navigator.of(context).pushReplacement(
                        //   PageRouteBuilder(
                        //     transitionDuration: Duration(seconds: 0),
                        //     pageBuilder: (context, animation1, animation2) =>
                        //         SignInScreen(),
                        //   ),
                        // );
                      },
                    ),
                  ),
                  // SizedBox(
                  //   height: 20,
                  //   width: 0,
                  // ),
                  Container(
                    height: 55,
                    child: Column(
                      children: [
                        Text(
                          "We have sent OTP on your number",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: ColorPalette['gray_4'],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // SizedBox(
                        //   height: 10,
                        //   width: 0,
                        // ),
                        Text(
                          // widget.phoneNumber.length.toString(),
                          widget.phoneNumber.replaceRange(
                              widget.phoneNumber.length - 10,
                              widget.phoneNumber.length - 4,
                              "******"),
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorPalette['gray_3'],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 90,
              // width: ,
              // color: Colors.white,
              margin:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
              child: PinPut(
                fieldsCount: 6,
                eachFieldWidth: 50,
                eachFieldHeight: 60,
                onSubmit: (pin) async {
                  try {
                    // FirebaseAuth auth = FirebaseAuth.instance;

                    // ConfirmationResult confirmationResult =
                    //     await auth.signInWithPhoneNumber(
                    //   widget.phoneNumber,
                    //   RecaptchaVerifier(
                    //     onSuccess: () => print('reCAPTCHA Completed!'),
                    //     onError: (FirebaseAuthException error) =>
                    //         print(error),
                    //     onExpired: () => print('reCAPTCHA Expired!'),
                    //     container: 'recaptcha',
                    //     size: RecaptchaVerifierSize.compact,
                    //     theme: RecaptchaVerifierTheme.dark,
                    //   ),
                    // );
                    // UserCredential userCredential =
                    //     await confirmationResult.confirm(pin).then((value) {
                    //   if (value != null) {
                    //     Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => CredentialsScreen(),
                    //       ),
                    //     );
                    //   }
                    // });

                    await FirebaseAuth.instance
                        .signInWithCredential(
                      PhoneAuthProvider.credential(
                        verificationId: verificationCode,
                        smsCode: pin,
                      ),
                    )
                        .then((value) {
                      if (value != null) {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            transitionDuration: Duration(seconds: 0),
                            pageBuilder: (context, animation1, animation2) =>
                                CredentialsScreen(),
                          ),
                        );
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => CredentialsScreen(),
                        //   ),
                        // );
                      }
                    });
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Invalid OTP")));
                  }
                },
                textStyle: TextStyle(
                  color: const Color(0xff171c26),
                  fontFamily: 'Montserrat',
                ),
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                submittedFieldDecoration: _pinPutDecoration.copyWith(
                    // borderRadius: BorderRadius.circular(20.0),
                    ),
                selectedFieldDecoration: _pinPutDecoration,
                followingFieldDecoration: _pinPutDecoration.copyWith(
                    // borderRadius: BorderRadius.circular(5.0),
                    // border: Border.all(
                    //   color: ColorPalette['secondary'].withOpacity(.7),
                    //   width: 2,
                    // ),
                    ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Do not got your number ? ',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    color: const Color(0xff656566),
                    letterSpacing: 0.36,
                    height: 0.94,
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        transitionDuration: Duration(seconds: 0),
                        pageBuilder: (context, animation1, animation2) =>
                            SignInScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Click Hear',
                    style: TextStyle(
                      color: const Color(0xffff7847),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat_B',
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      letterSpacing: 0.36,
                      height: 0.94,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            // Text.rich(
            //   TextSpan(
            //     style: TextStyle(
            //       fontFamily: 'Montserrat',
            //       fontSize: 14,
            //       color: const Color(0xff656566),
            //       letterSpacing: 0.36,
            //       height: 0.94,
            //     ),
            //     children: [
            //       TextSpan(
            //         text: 'Do not got your number ? ',
            //         style: TextStyle(
            //           fontWeight: FontWeight.w700,
            //         ),
            //       ),
            //       TextSpan(
            //         text: 'Click Hear',
            //         style: TextStyle(
            //           color: const Color(0xffff7847),
            //           fontWeight: FontWeight.bold,
            //           fontFamily: 'Montserrat_B',
            //           decoration: TextDecoration.underline,
            //         ),
            //       ),
            //     ],
            //   ),
            //   textHeightBehavior:
            //       TextHeightBehavior(applyHeightToFirstAscent: false),
            //   textAlign: TextAlign.center,
            // ),
            // Container(
            //   width: 160,
            //   margin: EdgeInsets.only(top: 30),
            //   padding: EdgeInsets.symmetric(vertical: 14),
            //   decoration: BoxDecoration(
            //     color: ColorPalette['primary'],
            //     borderRadius: BorderRadius.all(
            //       Radius.circular(10),
            //     ),
            //   ),
            //   alignment: Alignment.bottomCenter,
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => SignInScreen(),
            //         ),
            //       );
            //     },
            //     child: Container(
            //       child: Text(
            //         "Go Back",
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 18,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

const String _svg_8s8yfm =
    '<svg viewBox="0.0 0.0 30.0 30.0" ><path  d="M 0 15 C 0 6.728467464447021 6.728467464447021 0 15 0 C 23.27153396606445 0 30 6.728467464447021 30 15 C 30 23.27153396606445 23.27153396606445 30 15 30 C 6.728467464447021 30 0 23.27153396606445 0 15 Z M 2.250472545623779 15 C 2.250472545623779 22.03087043762207 7.970479965209961 27.75087928771973 15 27.75087928771973 C 22.03087043762207 27.75087928771973 27.75087928771973 22.03087043762207 27.75087928771973 15 C 27.75087928771973 7.970479965209961 22.03087043762207 2.250472545623779 15 2.250472545623779 C 7.970479965209961 2.250472545623779 2.250472545623779 7.970479965209961 2.250472545623779 15 Z M 16.37026405334473 21.00216102600098 L 11.14031219482422 15.79785823822021 C 10.92835903167725 15.58590602874756 10.8095588684082 15.29970359802246 10.8095588684082 15 C 10.8095588684082 14.70164775848389 10.92835903167725 14.41409492492676 11.14031219482422 14.20349311828613 L 16.37026405334473 8.996490478515625 C 16.81036949157715 8.559085845947266 17.52047538757324 8.559085845947266 17.96058082580566 8.999190330505371 C 18.39933395385742 9.440645217895508 18.39663505554199 10.15345191955566 17.9578800201416 10.59085655212402 L 13.52983570098877 15 L 17.9578800201416 19.40914535522461 C 18.39663505554199 19.84789848327637 18.39933395385742 20.55935668945313 17.96058082580566 20.99946022033691 C 17.74187850952148 21.22221374511719 17.45162582397461 21.33156394958496 17.16407203674316 21.33156394958496 C 16.87787055969238 21.33156394958496 16.58896636962891 21.22221374511719 16.37026405334473 21.00216102600098 Z" fill="#ff7847" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
