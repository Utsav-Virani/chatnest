import 'package:chatnest/Helpers/HelperWidgets.dart';
import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/screens/auth/CredentialsScreen.dart';
import 'package:chatnest/screens/auth/SignInScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

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
      color: ColorPalette['secondary'].withOpacity(0.3),
      border: Border.all(
        color: ColorPalette['secondary'],
        width: 2.5,
      ),
      borderRadius: BorderRadius.circular(18.0),
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CredentialsScreen(),
              ),
            );
          }
        });
      },
      verificationFailed: (FirebaseAuthException error) {
        print('----------');
        print(error.message);
        print('==========');
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
      },
      timeout: Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: appBar(
          context,
          title: "Enter Verification Code",
        ),
      ),
      key: _scaffoldKey,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.39,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // color: ColorPalette['secondary'],
                child: Column(
                  children: [
                    Text(
                      "We have sent OTP on your number",
                      style: TextStyle(
                        fontSize: 20,
                        color: ColorPalette['gray_4'],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                      width: 0,
                    ),
                    Text(
                      // widget.phoneNumber.length.toString(),
                      widget.phoneNumber.replaceRange(
                          widget.phoneNumber.length - 10,
                          widget.phoneNumber.length - 4,
                          "******"),
                      style: TextStyle(
                        fontSize: 18,
                        // color: ColorPalette['secondary'],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 90,
                // color: Colors.white,
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(20.0),
                child: PinPut(
                  fieldsCount: 6,
                  onSubmit: (pin) async {
                    try {
                      // FirebaseAuth auth = FirebaseAuth.instance;

                      // ConfirmationResult confirmationResult =
                      //     await auth.signInWithPhoneNumber(
                      //         widget.phoneNumber,
                      //         RecaptchaVerifier(
                      //           container: 'recaptcha',
                      //           size: RecaptchaVerifierSize.compact,
                      //           theme: RecaptchaVerifierTheme.light,
                      //         ));
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CredentialsScreen(),
                            ),
                          );
                        }
                      });
                    } catch (e) {
                      FocusScope.of(context).unfocus();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Invalid OTP")));
                    }
                  },
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: _pinPutDecoration.copyWith(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  selectedFieldDecoration: _pinPutDecoration,
                  followingFieldDecoration: _pinPutDecoration.copyWith(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                        color: ColorPalette['secondary'].withOpacity(.7),
                        width: 2),
                  ),
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ),
                    );
                  },
                  child: Container(
                    child: Text(
                      "Go Back",
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
      ),
    );
  }
}
