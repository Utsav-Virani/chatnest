import 'dart:io';

import 'package:adobe_xd/adobe_xd.dart';
import 'package:chatnest/Helpers/HelperWidgets.dart';
import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/config/database.dart';
import 'package:chatnest/data/UserdataCollection.dart';
import 'package:chatnest/screens/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polygon_clipper/polygon_border.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

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

  PickedFile _image;
  File imageFile;
  String _uploadedFileURL;
  String _status = "";

  userSignUp() async {
    Map<String, String> userData = {
      "name": _userNameController.text,
      "email": _emailController.text,
      "phonenumber": FirebaseAuth.instance.currentUser.phoneNumber,
      "profilePhoto": _uploadedFileURL,
      "status": _status,
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
        photoURL: _uploadedFileURL,
      );
      await FirebaseAuth.instance.currentUser
          .updateEmail(_emailController.text);

      uploadFile();

      DataStorage.setUserSignInPreference(true);
      DataStorage.setUserEmailPreference(_emailController.text);
      DataStorage.setUserNamePreference(_userNameController.text);

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: Duration(seconds: 0),
          pageBuilder: (context, animation1, animation2) => HomeScreen(),
          // null
        ),
      );
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HomeScreen(),
      //   ),
      // );
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

  Future chooseFile() async {
    _image = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 1800,
      maxWidth: 1800,
    );
    _cropImage(_image.path);
  }

  Future<Null> _cropImage(filePath) async {
    File _croppedImage = await ImageCropper.cropImage(
        sourcePath: filePath,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
    if (_croppedImage != null) {
      imageFile = _croppedImage;
      setState(() {});
    }
  }

  Future uploadFile() async {
    FirebaseStorage.instance
        .ref()
        .child(FirebaseAuth.instance.currentUser.uid +
            '/Profile Picture/' +
            FirebaseAuth.instance.currentUser.uid +
            '.jpg')
        .putFile(imageFile);
  }

  @override
  void initState() {
    _getUserData();
    _getProfilePhoto();
    super.initState();
  }

  _getProfilePhoto() async {
    _uploadedFileURL = await FirebaseStorage.instance
        .ref()
        .child(FirebaseAuth.instance.currentUser.uid +
            '/Profile Picture/' +
            FirebaseAuth.instance.currentUser.uid +
            '.jpg')
        .getDownloadURL();
    FirebaseAuth.instance.currentUser.updateProfile(photoURL: _uploadedFileURL);
    setState(() {});
  }

  _getUserData() async {
    FirebaseFirestore.instance
        .collection("UserData")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then(
      (value) {
        setState(() {
          _userNameController.text = value.data()['name'];
          _emailController.text = value.data()['email'];
          _uploadedFileURL = value.data()['profilePhoto'];
          _status = value.data()['status'];
        });
      },
    );
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
            // appBar: PreferredSize(
            //   preferredSize: Size.fromHeight(70),
            //   child: appBar(
            //     context,
            //     title: "Credentials",
            //   ),
            // ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25.0),
                        bottomLeft: Radius.circular(25.0),
                      ),
                      color: const Color(0xff171c26),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Credentials',
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
                        ),
                        Container(
                          width: 180,
                          height: 180,
                          child: GestureDetector(
                            onTap: () {
                              chooseFile();
                            },
                            child: Stack(
                              children: <Widget>[
                                // Pinned.fromPins(
                                //   Pin(start: 0.0, end: 0.0),
                                //   Pin(start: 0.0, end: 15.0),
                                //   child: SvgPicture.string(
                                //     '<svg viewBox="135.1 138.0 157.7 150.0" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(135.14, 138.0)" d="M 55.3489990234375 17.08182144165039 C 69.36844635009766 6.896174430847168 88.35213470458984 6.89617395401001 102.37158203125 17.08181953430176 L 134.2089538574219 40.21284484863281 C 148.2285614013672 50.39860534667969 154.0949401855469 68.45339965820313 148.7398986816406 84.93437957763672 L 136.5792236328125 122.3607711791992 C 131.2242279052734 138.8416442871094 115.8660125732422 150 98.53701019287109 150 L 59.18357086181641 150 C 41.85456466674805 150 26.49635696411133 138.8416442871094 21.14135551452637 122.3607788085938 L 8.980684280395508 84.93438720703125 C 3.625644445419312 68.45339965820313 9.49201488494873 50.39860534667969 23.51162147521973 40.21284484863281 Z" fill="#ffd2c1" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>',
                                //     allowDrawingOutsideViewBox: true,
                                //     fit: BoxFit.fill,
                                //   ),
                                // ),
                                Container(
                                  child: ClipPolygon(
                                    sides: 5,
                                    borderRadius: 30.0,
                                    // rotate: 90.0,
                                    boxShadows: [
                                      // PolygonBoxShadow(
                                      //   color: Color(0x36ffd2c1),
                                      //   elevation: 1.0,
                                      // ),
                                      PolygonBoxShadow(
                                        color: Color(0xff121212),
                                        elevation: 6.0,
                                      )
                                    ],
                                    child: Container(
                                      // decoration: ShapeDecoration(
                                      // color: Colors.black,
                                      // shape: PolygonBorder(
                                      //   sides: 5
                                      // ),
                                      // ),
                                      child: _uploadedFileURL != null
                                          ? Image.network(
                                              _uploadedFileURL,
                                              fit: BoxFit.scaleDown,
                                              // height: 100,
                                              // width: 100,
                                            )
                                          : _image == null
                                              ? Image.asset(
                                                  "assets/images/default_profile_photo.jpg",
                                                  fit: BoxFit.scaleDown,
                                                  // height: 100,
                                                  // width: 100,
                                                )
                                              : Image.file(
                                                  File(_image.path),
                                                  fit: BoxFit.scaleDown,
                                                  // height: 50,
                                                  // width: 50,
                                                ),
                                      // child: Image.network(
                                      //   "https://images.unsplash.com/photo-1560495070-4c178920c950",
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                  ),
                                ),
                                Pinned.fromPins(
                                  Pin(size: 38.0, middle: 0.5),
                                  Pin(size: 38.0, end: 0.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Pinned.fromPins(
                                        Pin(start: 0.0, end: 0.0),
                                        Pin(start: 0.0, end: 0.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.elliptical(
                                                    9999.0, 9999.0)),
                                            color: const Color(0xffff7847),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0x36ff7847),
                                                offset: Offset(0, 3),
                                                blurRadius: 6,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Pinned.fromPins(
                                        Pin(size: 19.0, middle: 0.5),
                                        Pin(size: 17.4, middle: 0.5),
                                        child:
                                            // Adobe XD layer: 'Iconly/Light-Outlin…' (group)
                                            Stack(
                                          children: <Widget>[
                                            Pinned.fromPins(
                                              Pin(
                                                  startFraction: 0.0,
                                                  endFraction: 0.0),
                                              Pin(
                                                  startFraction: 0.0,
                                                  endFraction: 0.0),
                                              child:
                                                  // Adobe XD layer: 'Camera' (group)
                                                  Stack(
                                                children: <Widget>[
                                                  Pinned.fromPins(
                                                    Pin(
                                                        startFraction: 0.0,
                                                        endFraction: 0.0),
                                                    Pin(
                                                        startFraction: 0.0,
                                                        endFraction: 0.0),
                                                    child:
                                                        // Adobe XD layer: 'Combined Shape' (shape)
                                                        SvgPicture.string(
                                                      '<svg viewBox="0.0 0.0 15.0 13.4" ><path transform="translate(0.0, 0.0)" d="M 3.727387428283691 13.36311054229736 C 1.67199182510376 13.36311054229736 0 11.69111919403076 0 9.635721206665039 L 0 5.289353847503662 C 0 3.678112030029297 1.310863137245178 2.36724853515625 2.92277979850769 2.36724853515625 C 3.085456371307373 2.36724853515625 3.345333814620972 2.272747993469238 3.506660461425781 2.097246170043945 C 3.509360313415527 2.094546318054199 3.511385440826416 2.091845989227295 3.514760971069336 2.087796211242676 L 3.518810510635376 2.082396030426025 L 3.557285785675049 2.022995471954346 L 3.895464181900024 1.373638868331909 C 4.22419261932373 0.7776078581809998 4.557646751403809 0.4468545615673065 5.011250495910645 0.2659527361392975 C 5.423679828643799 0.1019260436296463 6.377464771270752 1.596553111937737e-08 7.5 1.596553111937737e-08 C 8.622535705566406 1.596553111937737e-08 9.575648307800293 0.1019260436296463 9.988077163696289 0.2659527361392975 C 10.44302940368652 0.4468545615673065 10.77648258209229 0.7782828211784363 11.10453796386719 1.373638868331909 L 11.44338893890381 2.023670434951782 C 11.45149040222168 2.037170648574829 11.4582405090332 2.047970771789551 11.46498966217041 2.058095693588257 L 11.49334049224854 2.097246170043945 C 11.65399360656738 2.272747993469238 11.91386985778809 2.36724853515625 12.07722091674805 2.36724853515625 C 13.68913841247559 2.36724853515625 15 3.678112030029297 15 5.289353847503662 L 15 9.635721206665039 C 15 11.69111919403076 13.3280086517334 13.36311054229736 11.27261352539063 13.36311054229736 L 3.727387428283691 13.36311054229736 Z M 5.427054405212402 1.311538338661194 C 5.239402770996094 1.385788917541504 5.070651531219482 1.572090864181519 4.880974292755127 1.916344285011292 L 4.592746257781982 2.473899841308594 L 4.521195411682129 2.602826118469238 C 4.45774507522583 2.70812726020813 4.39834451675415 2.789128065109253 4.334894180297852 2.858653783798218 C 3.979840278625488 3.243407726287842 3.425659656524658 3.492485284805298 2.92277979850769 3.492485284805298 L 2.799928188323975 3.496535301208496 C 1.860993981361389 3.559985876083374 1.125236392021179 4.347719192504883 1.125236392021179 5.289353847503662 L 1.125236392021179 9.635721206665039 C 1.125236392021179 11.07078647613525 2.292323112487793 12.23854827880859 3.727387428283691 12.23854827880859 L 11.27261352539063 12.23854827880859 C 12.70767879486084 12.23854827880859 13.87544059753418 11.07078647613525 13.87544059753418 9.635721206665039 L 13.87544059753418 5.289353847503662 C 13.87544059753418 4.298442840576172 13.06880664825439 3.492485284805298 12.07722091674805 3.492485284805298 L 11.946946144104 3.487085342407227 C 11.46903896331787 3.44793438911438 10.98978614807129 3.212357521057129 10.66443252563477 2.857978820800781 C 10.60030651092529 2.788453340530396 10.54158115386963 2.707452297210693 10.4801549911499 2.604851245880127 C 10.47138023376465 2.590676069259644 10.46057987213135 2.572450876235962 10.44910526275635 2.550175666809082 L 10.36203002929688 2.386824369430542 L 10.11902713775635 1.916344285011292 C 9.930024147033691 1.57344114780426 9.761272430419922 1.387138962745667 9.572271347045898 1.311538338661194 L 9.482494354248047 1.281837821006775 C 9.14094352722168 1.185311794281006 8.381559371948242 1.125236392021179 7.5 1.125236392021179 C 6.525290966033936 1.125236392021179 5.711907386779785 1.198137164115906 5.427054405212402 1.311538338661194 Z M 4.552921295166016 7.596526622772217 C 4.552921295166016 5.971786022186279 5.875258445739746 4.649446964263916 7.5 4.649446964263916 C 9.124741554260254 4.649446964263916 10.4464054107666 5.971786022186279 10.4464054107666 7.596526622772217 C 10.4464054107666 9.221268653869629 9.124741554260254 10.54293155670166 7.5 10.54293155670166 C 5.875258445739746 10.54293155670166 4.552921295166016 9.221268653869629 4.552921295166016 7.596526622772217 Z M 5.678156852722168 7.596526622772217 C 5.678156852722168 8.600935935974121 6.495590686798096 9.417695045471191 7.5 9.417695045471191 C 8.504410743713379 9.417695045471191 9.321169853210449 8.600935935974121 9.321169853210449 7.596526622772217 C 9.321169853210449 6.592116832733154 8.504410743713379 5.774683475494385 7.5 5.774683475494385 C 6.495590686798096 5.774683475494385 5.678156852722168 6.592116832733154 5.678156852722168 7.596526622772217 Z M 10.87165927886963 4.874899864196777 C 10.87165927886963 4.490820407867432 11.1612377166748 4.173567295074463 11.53384113311768 4.130366325378418 L 11.628342628479 4.124966621398926 C 12.04279708862305 4.124966621398926 12.37827491760254 4.46112060546875 12.37827491760254 4.874899864196777 C 12.37827491760254 5.259653091430664 12.08869743347168 5.576906681060791 11.71609497070313 5.620106220245361 L 11.628342628479 5.625506401062012 C 11.20713806152344 5.625506401062012 10.87165927886963 5.289353847503662 10.87165927886963 4.874899864196777 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>',
                                                      allowDrawingOutsideViewBox:
                                                          true,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'We need this information so that\nothers can find you on this platform.',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        color: const Color(0xff171c26),
                        letterSpacing: 0.36,
                        height: 1.3333333333333333,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    // height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.blueAccent,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color(0xffffcab7),
                            ),
                            padding: EdgeInsets.only(left: 16),
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: SvgPicture.asset(
                                    "assets/svgs/ProfileIcon.svg",
                                    height: 22,
                                    width: 22,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: TextFormField(
                                    validator: (value) {
                                      return RegExp(
                                                  r"^(?=.{3,8}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$")
                                              .hasMatch(value)
                                          ? null
                                          : "Invalid UserName";
                                    },
                                    controller: _userNameController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: 'UserName:',
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(left: 16, right: 16),
                                      focusColor: ColorPalette['gray_4'],
                                    ),
                                    cursorColor: Color(0xff171c26),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color(0xffffcab7),
                            ),
                            padding: EdgeInsets.only(left: 16),
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Row(
                              children: [
                                Container(
                                  child: SvgPicture.asset(
                                    "assets/svgs/Email.svg",
                                    height: 22,
                                    width: 22,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: TextFormField(
                                    validator: (val) {
                                      return RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(val)
                                          ? null
                                          : "Invalid email";
                                    },
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: 'Email ID:',
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(left: 10, right: 16),
                                    ),
                                    cursorColor: Color(0xff171c26),
                                  ),
                                ),
                              ],
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
                      // print("SignIn Clicked!");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xffff7847),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x80ff7847),
                            offset: Offset(3, 3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat_M',
                          color: Color(0xfffefefe),
                          letterSpacing: 1.4000000000000001,
                          // fontWeight: FontWeight.w700,
                          // height: 0.6071428571428571,
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
