import 'dart:io';

import 'package:adobe_xd/adobe_xd.dart';
import 'package:chatnest/Helpers/HelperWidgets.dart';
import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/config/database.dart';
import 'package:chatnest/data/UserdataCollection.dart';
import 'package:chatnest/screens/HomeScreen.dart';
import 'package:chatnest/screens/SearchScreen.dart';
import 'package:chatnest/screens/WelcomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class MyProfile extends StatefulWidget {
  final int selectedIndx;
  MyProfile({this.selectedIndx});

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final _formKey = GlobalKey<FormState>();

  bool isLogginIn = false;
  QuerySnapshot userInfo;

  DataBaseMethods databaseMethods = new DataBaseMethods();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _profilePhotoController = TextEditingController();

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  PickedFile _image;
  File imageFile;
  String _uploadedFileURL;

  @override
  void initState() {
    _getUserData();
    _getProfilePhoto();
    super.initState();
    // _page = widget.selectedIndx;
  }

  updateData() async {
    Map<String, String> userData = {
      "name": _userNameController.text,
      "email": _emailController.text,
      "phonenumber": FirebaseAuth.instance.currentUser.phoneNumber,
      "profilePhoto": _uploadedFileURL,
      "status": _statusController.text,
    };

    try {
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
      // DataStorage.setUserNamePreference(_statusController.text);
      // DataStorage.setUserNamePreference(_uploadedFileURL);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Updated!")));

      // Navigator.of(context).pushReplacement(
      //   PageRouteBuilder(
      //     transitionDuration: Duration(seconds: 0),
      //     pageBuilder: (context, animation1, animation2) => HomeScreen(),
      //     // null
      //   ),
      // );
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          width: MediaQuery.of(context).size.width,
          elevation: 50,
          duration: Duration(seconds: 3),
          content: Container(
            child: Text(errorMsg),
          ),
        ),
      );
    }
  }

  _getUserData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      // _emailController.text = FirebaseAuth.instance.currentUser.email;
      // _userNameController.text = FirebaseAuth.instance.currentUser.displayName;
      // _phoneController.text = FirebaseAuth.instance.currentUser.phoneNumber;
      FirebaseFirestore.instance
          .collection("UserData")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then(
        (value) {
          setState(() {
            _userNameController.text = value.data()['name'];
            _emailController.text = value.data()['email'];
            _phoneController.text = value.data()['phonenumber'];
            _statusController.text = value.data()['status'];
            _uploadedFileURL = value.data()['profilePhoto'];
          });
        },
      );
    }
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

  // @override
  // void dispose() {
  //   setState(() {});
  //   super.dispose();
  // }

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
      uploadFile();
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
  Widget build(BuildContext context) {
    // print(FirebaseAuth.instance.currentUser.photoURL);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.42,
              // padding: EdgeInsets.only(top: 20),
              // height: MediaQuery.of(context).size.height,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.only(
              //     bottomRight: Radius.circular(25.0),
              //     bottomLeft: Radius.circular(25.0),
              //   ),
              //   color: const Color(0xff171c26),
              // ),
              child: Stack(
                children: <Widget>[
                  Pinned.fromPins(
                    Pin(start: 0.0, end: 0.0),
                    Pin(start: 0.0, end: 93.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25.0),
                          bottomLeft: Radius.circular(25.0),
                        ),
                        color: const Color(0xff171c26),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x80171c26),
                            offset: Offset(0, 3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: MediaQuery.of(context).size.width),
                    Pin(size: 32.0, start: 48.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                transitionDuration: Duration(seconds: 0),
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        HomeScreen(),
                                // null
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 16),
                            child:
                                SvgPicture.asset("assets/svgs/backButton.svg"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            'Profile',
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
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                transitionDuration: Duration(seconds: 0),
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        WelcomeScreen(),
                                // null
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 24),
                            child: SvgPicture.asset(
                              "assets/svgs/exit.svg",
                              height: 28,
                              width: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 220, middle: 0.5),
                    Pin(size: 220, end: 0.0),
                    child: Container(
                      child: GestureDetector(
                        onTap: () {
                          chooseFile();
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 250,
                              width: 250,
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
                                  color: Color(0xff171c26),
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
                                            Radius.elliptical(9999.0, 9999.0)),
                                        color: const Color(0xffff7847),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0x80171c26),
                                            offset: Offset(0, 3),
                                            blurRadius: 10,
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
                                          child: Stack(
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
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: const Color(0xffffcab7),
                      ),
                      padding: EdgeInsets.only(left: 16),
                      width: MediaQuery.of(context).size.width * 0.8,
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
                            width: MediaQuery.of(context).size.width * 0.65,
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
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: const Color(0xffffcab7),
                      ),
                      padding: EdgeInsets.only(left: 16),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        children: [
                          Container(
                            child: SvgPicture.asset(
                              "assets/svgs/status.svg",
                              height: 22,
                              width: 22,
                            ),
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: TextFormField(
                              controller: _statusController,
                              // maxLines: 2,
                              maxLength: 50,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Status :',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(left: 16, right: 16),
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
                      width: MediaQuery.of(context).size.width * 0.8,
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
                            width: MediaQuery.of(context).size.width * 0.65,
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
                                    EdgeInsets.only(left: 16, right: 16),
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
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        children: [
                          Container(
                            child: SvgPicture.asset(
                              "assets/svgs/call.svg",
                              height: 22,
                              width: 22,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: TextFormField(
                              validator: (mobilenum) {
                                return RegExp(r"^[6-9]\d{9}$")
                                        .hasMatch(mobilenum)
                                    ? null
                                    : "Invalid Mobile Number";
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: _phoneController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Mobile Number:',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(left: 16, right: 16),
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
                updateData();
                // print("SignIn Clicked!");
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                ),
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color(0xff171c26),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x80171c26),
                      offset: Offset(3, 3),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Text(
                  "Update",
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

const String _svg_pwvnwt =
    '<svg viewBox="114.0 806.6 200.0 198.8" ><defs><linearGradient id="gradient" x1="0.0" y1="1.0" x2="1.0" y2="0.0"><stop offset="0.0" stop-color="#ff171c26"  /><stop offset="1.0" stop-color="#ff171c26"  /></linearGradient></defs><path transform="translate(154.7, 840.55)" d="M 122.9761047363281 -9.454475402832031 C 137.3768005371094 0.7921867370605469 148.4542846679688 16.02370452880859 154.2699432373047 33.47071075439453 C 160.0856018066406 50.917724609375 160.6394958496094 70.02635192871094 157.039306640625 89.41192626953125 C 153.1622009277344 109.0744247436523 145.1310424804688 129.2908020019531 130.1764526367188 143.4145812988281 C 115.2218780517578 157.5383453369141 93.62081146240234 165.846435546875 72.85056304931641 164.7386932373047 C 52.08031463623047 163.6309509277344 32.14087295532227 153.1073608398438 11.37062072753906 140.9221496582031 C -9.399627685546875 128.4599914550781 -30.72374725341797 114.6131591796875 -37.92411041259766 95.22758483886719 C -44.84752655029297 75.84202575683594 -37.64716339111328 51.19466018676758 -29.33906555175781 27.65504455566406 C -21.03096771240234 3.838489532470703 -11.61512756347656 -19.14725494384766 5.554954528808594 -28.28616333007813 C 22.72502517700195 -37.70201110839844 47.37239074707031 -33.54795837402344 68.69651031494141 -28.84003448486328 C 90.29757690429688 -24.40904998779297 108.2984619140625 -19.70112609863281 122.9761047363281 -9.454475402832031 Z" fill="url(#gradient)" stroke="#707070" stroke-width="0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
