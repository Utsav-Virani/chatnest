import 'package:chatnest/Helpers/HelperWidgets.dart';
import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/screens/HomeScreen.dart';
import 'package:chatnest/screens/MyProfileScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:polygon_clipper/polygon_border.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class SearchScreen extends StatefulWidget {
  QuerySnapshot searchResult;
  SearchScreen({this.searchResult});
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchTextController = new TextEditingController();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  bool isAdded = false;

  @override
  void initState() {
    super.initState();
  }

  Widget SearchResultList() {
    return ListView.builder(
        // padding: EdgeInsets.only(top: 30),
        shrinkWrap: true,
        itemCount: widget.searchResult.docs.length,
        itemBuilder: (context, index) {
          return widget.searchResult != null
              ? SearchResultCard(
                  name: widget.searchResult.docs[index].data()["name"],
                  email: widget.searchResult.docs[index].data()["email"],
                  phone: widget.searchResult.docs[index].data()["phonenumber"],
                  id: widget.searchResult.docs[index].id,
                  profilePhoto:
                      widget.searchResult.docs[index].data()["profilePhoto"],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Container(
                    //   child: Lottie.asset("assets/Animation/sad.json"),
                    // ),
                    Text(
                      "No Userfound",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                );
        });
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  _createChatRoom({userId, name}) {
    if (userId != FirebaseAuth.instance.currentUser.uid) {
      String _charRoomId =
          getChatRoomId(userId, FirebaseAuth.instance.currentUser.uid);
      List<String> users = [userId, FirebaseAuth.instance.currentUser.uid];
      Map<String, String> usersName = {
        userId: name,
        FirebaseAuth.instance.currentUser.uid:
            FirebaseAuth.instance.currentUser.displayName
      };
      Map<String, dynamic> _chatRoomMap = {
        "users": users,
        "chatRoomId": _charRoomId,
        "usersName": usersName,
      };

      FirebaseFirestore.instance
          .collection("chatRoom")
          .doc(_charRoomId)
          .set(_chatRoomMap)
          .catchError((e) {
        print(e);
      });

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ChatRoomScreen(chatRoomId: _charRoomId),
      //   ),
      // );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("You can not send message to your self.")));
    }
  }

  getUserInfo({userId}) async {
    String _chatRoomId =
        getChatRoomId(userId, FirebaseAuth.instance.currentUser.uid);
    // print(_chatRoomId);
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(_chatRoomId)
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          isAdded = true;
        });
      } else {
        setState(() {
          isAdded = false;
        });
      }
    });
  }

  Widget SearchResultCard(
      {String name,
      final String email,
      final String phone,
      final String id,
      final String profilePhoto}) {
    getUserInfo(userId: id);
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width * 0.5,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 16),
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
        // height: 90,
        // width: 90,
        // color: Colors.amber,
        // margin: EdgeInsets.only(left: 16),
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
                  child: profilePhoto != null
                      ? Image.network(
                          profilePhoto,
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
                    name,
                    style: TextStyle(
                      fontFamily: 'Montserrat_M',
                      fontSize: 20,
                      color: Color(0xff171c26),
                    ),
                  ),
                  Text(
                    phone,
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
            Spacer(),
            GestureDetector(
              onTap: () {
                _createChatRoom(userId: id, name: name);
                // setState(() {
                //   isAdded = !isAdded;
                // });
              },
              child: Container(
                margin: EdgeInsets.only(right: 24),
                child: isAdded
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.04,
                        decoration: BoxDecoration(
                          color: Color(0xffffd2c1),
                          border: Border.all(
                              color: ColorPalette['gray_0'].withOpacity(0.5),
                              width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              50,
                            ),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ADDED",
                              style: TextStyle(
                                color: ColorPalette['gray_0'].withOpacity(0.8),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.04,
                        decoration: BoxDecoration(
                          color: ColorPalette['primary'].withOpacity(0.3),
                          border: Border.all(
                              color: ColorPalette['gray_0'].withOpacity(0.5),
                              width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              50,
                            ),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 18,
                              color: ColorPalette['gray_0'].withOpacity(0.7),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "ADD",
                              style: TextStyle(
                                color: ColorPalette['gray_0'].withOpacity(0.8),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
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
    );
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: widget.searchResult != null
                  ? SearchResultList()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "No Userfound",
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
