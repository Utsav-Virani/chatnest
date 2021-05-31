import 'dart:io';

import 'package:adobe_xd/adobe_xd.dart';
import 'package:chatnest/Helpers/HelperWidgets.dart';
import 'package:chatnest/Helpers/XDBottomNavBar.dart';
import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/screens/ChatScreen.dart';
import 'package:chatnest/screens/MyProfileScreen.dart';
import 'package:chatnest/screens/SearchScreen.dart';
import 'package:chatnest/screens/UserProfileCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:polygon_clipper/polygon_border.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class HomeScreen extends StatefulWidget {
  final int selectedIndx;
  HomeScreen({this.selectedIndx});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream _availableChatRoomsStream;
  bool isSearchVisible = false;
  QuerySnapshot _searchResult;

  TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    // print();

    // _selectedIndex = widget.selectedIndx is Null ? 0 : widget.selectedIndx;
    _getChatRooms();
    super.initState();
  }

  // @override
  // void dispose() {
  //   setState(() {});
  //   super.dispose();
  // }

  _getChatRooms() {
    setState(() {
      _availableChatRoomsStream = FirebaseFirestore.instance
          .collection("chatRoom")
          .where("users", arrayContains: FirebaseAuth.instance.currentUser.uid)
          .snapshots();
    });
  }

  _getUserName(userId) async {
    // print(userId);
    FirebaseFirestore.instance
        .collection("UserData")
        .doc(userId)
        .get()
        .then((value) {
      return value.data()['name'];
    });
  }

  Widget ChatRoomList() {
    return StreamBuilder(
      stream: _availableChatRoomsStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? snapshot != null
                ? ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      // print("-----");
                      // print(snapshot.data.docs[index]
                      //     .data()["chatRoomId"]
                      //     .toString()
                      //     .replaceAll("_", "")
                      //     .replaceAll(
                      //         FirebaseAuth.instance.currentUser.uid, ""));
                      // print(snapshot.data.docs[index].data()["chatRoomId"]);
                      // print(snapshot.data.docs[index].data()["chatRoomId"]);
                      return ChatRoomListTile(
                        userId: snapshot.data.docs[index]
                            .data()["chatRoomId"]
                            .toString()
                            .replaceAll("_", "")
                            .replaceAll(
                                FirebaseAuth.instance.currentUser.uid, ""),
                        chatRoomId:
                            snapshot.data.docs[index].data()["chatRoomId"],
                      );
                    },
                  )
                : Container(
                    width: double.infinity,
                    child: Center(child: CircularProgressIndicator()),
                  )
            : Container(
                width: double.infinity,
                child: Center(child: CircularProgressIndicator()),
              );
      },
    );
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     // '',
  //     'Home',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     // '',
  //     'Search',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     // '',
  //     'Request',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     // '',
  //     'Profile',
  //     style: optionStyle,
  //   ),
  // ];

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 1000),
    ));
  }

  _searchUser(userName) async {
    // print(userName);
    FirebaseFirestore.instance
        .collection("UserData")
        .where("name", isEqualTo: userName)
        .get()
        .then((value) {
      setState(() {
        _searchResult = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhitePalette['white_4'],
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 36),
                // color: Colors.black12,
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: !isSearchVisible
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.start,
                  children: [
                    !isSearchVisible
                        ? Container(
                            // height: 90,
                            // width: 90,
                            // color: Colors.amber,
                            margin: EdgeInsets.only(left: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 90,
                                  width: 90,
                                  decoration: ShapeDecoration(
                                    shape: PolygonBorder(
                                      sides: 5,
                                      borderRadius: 30.0,
                                      border: BorderSide(
                                        color: Color(0xff171c26),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: ClipPolygon(
                                    sides: 5,
                                    borderRadius: 30.0,
                                    boxShadows: [
                                      PolygonBoxShadow(
                                        color: Color(0xff121212),
                                        elevation: 6.0,
                                      )
                                    ],
                                    child: Container(
                                      child: FirebaseAuth.instance.currentUser
                                                  .photoURL !=
                                              null
                                          ? Image.network(
                                              FirebaseAuth.instance.currentUser
                                                  .photoURL,
                                            )
                                          : Image.asset(
                                              "assets/images/default_profile_photo.jpg",
                                              // fit: BoxFit.scaleDown,
                                            ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hello, ",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat_M',
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        FirebaseAuth
                                            .instance.currentUser.displayName,
                                        style: TextStyle(
                                          fontFamily: 'Montserrat_M',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSearchVisible = !isSearchVisible;
                                    });
                                  },
                                  child: Container(
                                    height: 44,
                                    width: 50,
                                    padding: EdgeInsets.all(5.0),
                                    child: SvgPicture.asset(
                                        "assets/svgs/backButton.svg"),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  height: 45,
                                  child: TextFormField(
                                    controller: _searchTextController,
                                    onChanged: (val) {
                                      _searchUser(val);
                                      setState(() {});
                                    },
                                    style: TextStyle(
                                      color: Color(0xff171c26),
                                    ),
                                    textAlignVertical: TextAlignVertical.bottom,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    keyboardType: TextInputType.emailAddress,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    decoration: InputDecoration(
                                      hintText: 'Search',
                                      prefix: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                      ),
                                      // hintStyle: TextStyle(
                                      //   color: ColorPalette['white_1'],
                                      // ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xff171c26),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xff171c26),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                      ),
                                      focusColor: Color(0xff171c26),
                                      // contentPadding:
                                      //     EdgeInsets.only(left: 16, right: 16),
                                    ),
                                    cursorColor: Color(0xff171c26),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSearchVisible = !isSearchVisible;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.only(right: 20),
                        padding: EdgeInsets.all(10.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(startFraction: 0.0, endFraction: 0.0),
                              Pin(startFraction: 0.0, endFraction: 0.0),
                              child:
                                  // Adobe XD layer: 'Search' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(startFraction: 0.0, endFraction: 0.0),
                                    Pin(startFraction: 0.0, endFraction: 0.0),
                                    child:
                                        // Adobe XD layer: 'Combined Shape' (shape)
                                        SvgPicture.string(
                                      '<svg viewBox="0.0 0.0 29.3 30.0" ><path transform="translate(0.0, 0.0)" d="M 27.48523330688477 29.68337440490723 L 22.8973388671875 25.10836791992188 C 20.48419380187988 27.04070281982422 17.42420959472656 28.19796752929688 14.09963512420654 28.19796752929688 C 6.324704647064209 28.19796752929688 0 21.87326240539551 0 14.09833145141602 C 0 6.324704647064209 6.324704647064209 0 14.09963512420654 0 C 21.87326240539551 0 28.19796752929688 6.324704647064209 28.19796752929688 14.09833145141602 C 28.19796752929688 17.76703262329102 26.79007911682129 21.11238861083984 24.48589515686035 23.62316703796387 L 29.0201530456543 28.14584922790527 C 29.44362640380859 28.5693187713623 29.44492530822754 29.25599479675293 29.02145576477051 29.6807689666748 C 28.80906867980957 29.89445877075195 28.53022956848145 30 28.25269317626953 30 C 27.97515678405762 30 27.6976203918457 29.89445877075195 27.48523330688477 29.68337440490723 Z M 2.172081470489502 14.09833145141602 C 2.172081470489502 20.67581748962402 7.522150993347168 26.02588653564453 14.09963512420654 26.02588653564453 C 20.67581748962402 26.02588653564453 26.02588653564453 20.67581748962402 26.02588653564453 14.09833145141602 C 26.02588653564453 7.522150993347168 20.67581748962402 2.172081470489502 14.09963512420654 2.172081470489502 C 7.522150993347168 2.172081470489502 2.172081470489502 7.522150993347168 2.172081470489502 14.09833145141602 Z" fill="#574d51" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>',
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
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
              Container(
                height: 40,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Color(0xff171c26),
                ),
                child: !isSearchVisible
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: const Color(0xffff7847),
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Text(
                              "Chat",
                              style: TextStyle(
                                fontSize: 20,
                                color: const Color(0xffff7847),
                                fontFamily: 'Montserrat_M',
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        // decoration: BoxDecoration(
                        //   border: Border(
                        //     bottom: BorderSide(
                        //       color: const Color(0xffff7847),
                        //       width: 2,
                        //     ),
                        //   ),
                        // ),
                        child: Text(
                          "Add Friends",
                          style: TextStyle(
                            fontSize: 20,
                            color: const Color(0xffff7847),
                            fontFamily: 'Montserrat_M',
                          ),
                        ),
                      ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.01,
              // ),
              !isSearchVisible
                  ? Expanded(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned.fill(
                            bottom: 80,
                            child: ChatRoomList(),
                          ),
                          Container(
                            // alignment: Alignment.bottomCenter,
                            height: 200,
                            child: XDBottomNavBar(),
                          )
                        ],
                      ),
                    )
                  : Expanded(
                      // height: MediaQuery.of(context).size.height,
                      // width: MediaQuery.of(context).size.width,
                      child: SearchScreen(
                        searchResult: _searchResult,
                      ),
                    ),
              // Expanded(
              //   child: ChatRoomList(),
              // ),
              // Container(
              //   height: 200,
              //   child: XDBottomNavBar(),
              // )
            ],
          ),
        ),
        // : Container(
        //     height: MediaQuery.of(context).size.height,
        //     width: MediaQuery.of(context).size.width,
        //     child: SearchScreen(),
        //   ),
      ),
    );
  }
}

class ChatRoomListTile extends StatefulWidget {
  final String userId;
  final String chatRoomId;
  ChatRoomListTile({this.userId, this.chatRoomId});

  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _profilePhotoController = TextEditingController();

  @override
  void initState() {
    _getUserData(widget.userId);
    // TODO: implement initState
    super.initState();
  }

  _getUserData(String _uid) async {
    if (FirebaseAuth.instance.currentUser != null) {
      // _emailController.text = FirebaseAuth.instance.currentUser.email;
      // _userNameController.text = FirebaseAuth.instance.currentUser.displayName;
      // _phoneController.text = FirebaseAuth.instance.currentUser.phoneNumber;
      FirebaseFirestore.instance.collection("UserData").doc(_uid).get().then(
        (value) {
          setState(() {
            _userNameController.text = value.data()['name'];
            _emailController.text = value.data()['email'];
            _phoneController.text = value.data()['phonenumber'];
            _statusController.text = value.data()['status'];
            _profilePhotoController.text = value.data()['profilePhoto'];
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(_chatRoomId);
    // print(userName);
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: Duration(seconds: 0),
              pageBuilder: (context, animation1, animation2) => ChatScreen(
                chatRoomId: widget.chatRoomId,
                chatUserName: _userNameController.text,
                chatUserEmail: _emailController.text,
                chatUserPhoneNumber: _phoneController.text,
                chatUserProfilePhoto: _profilePhotoController.text,
                chatUserStatus: _statusController.text,
              ),
            ),
          );

          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return ChatScreen(
          //         chatRoomId: _chatRoomId,
          //         chatUserName: userName,
          //       );
          //     },
          //   ),
          // );
        },
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          // color: Colors.amber,
          alignment: Alignment.center,
          // margin: EdgeInsets.symmetric(horizontal: 1),
          // decoration: BoxDecoration(
          //   border: Border.all(
          //     width: 1,
          //     color: ColorPalette['gray_0'],
          //   ),
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(10),
          //   ),
          // ),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 85,
                  width: 85,
                  decoration: ShapeDecoration(
                    shape: PolygonBorder(
                      sides: 5,
                      borderRadius: 30.0,
                      border: BorderSide(
                        color: Color(0xff171c26),
                        width: 2,
                      ),
                    ),
                  ),
                  child: ClipPolygon(
                    sides: 5,
                    borderRadius: 30.0,
                    boxShadows: [
                      PolygonBoxShadow(
                        color: Color(0xff121212),
                        elevation: 6.0,
                      )
                    ],
                    child: Container(
                      child: _profilePhotoController != null
                          ? Image.network(
                              _profilePhotoController.text,
                            )
                          : Image.asset(
                              "assets/images/default_profile_photo.jpg",
                              // fit: BoxFit.scaleDown,
                            ),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userNameController.text,
                        style: TextStyle(
                          fontFamily: 'Montserrat_M',
                          fontSize: 20,
                          color: Color(0xff171c26),
                        ),
                      ),
                      Text(
                        _statusController.text,
                        style: TextStyle(
                          fontFamily: 'Montserrat_M',
                          fontSize: 12,
                          color: Color(0xff7e8086),
                          // letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                // Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
