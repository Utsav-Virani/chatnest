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

class SearchScreen extends StatefulWidget {
  final int selectedIndx;
  SearchScreen({this.selectedIndx});
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchTextController = new TextEditingController();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  QuerySnapshot _searchResult;

  GlobalKey _bottomNavigationKey = GlobalKey();
  int _page = 0;
  bool isAdded = false;
  int _selectedIndex;

  @override
  void initState() {
    _page = widget.selectedIndx is Null ? 2 : widget.selectedIndx;
    super.initState();
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

  Widget SearchResultList() {
    return ListView.builder(
        padding: EdgeInsets.only(top: 30),
        shrinkWrap: true,
        itemCount: _searchResult.docs.length,
        itemBuilder: (context, index) {
          return _searchResult != null
              ? SearchResultCard(
                  name: _searchResult.docs[index].data()["name"],
                  email: _searchResult.docs[index].data()["email"],
                  phone: _searchResult.docs[index].data()["phonenumber"],
                  id: _searchResult.docs[index].id,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Lottie.asset("assets/Animation/sad.json"),
                    ),
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
      {String name, final String email, final String phone, final String id}) {
    getUserInfo(userId: id);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Container(
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: ColorPalette['gray_0'],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: ListTile(
          // tileColor: ColorPalette['yellow_2'],
          leading: CircleAvatar(
            backgroundColor: ColorPalette['gray_0'].withOpacity(0.8),
            radius: 22,
            child: Text(
              name[0],
              style: TextStyle(
                color: ColorPalette['white_3'],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(name),
          subtitle: Text(phone),
          trailing: GestureDetector(
            onTap: () {
              _createChatRoom(userId: id, name: name);
              // setState(() {
              //   isAdded = !isAdded;
              // });
            },
            child: isAdded
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.04,
                    decoration: BoxDecoration(
                      color: ColorPalette['green_1'].withOpacity(0.3),
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
                        // Icon(
                        //   Icons.add,
                        //   size: 18,
                        //   color: ColorPalette['gray_0'].withOpacity(0.7),
                        // ),
                        // SizedBox(
                        //   width: 5,
                        // ),
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
    return Scaffold(
      appBar: appBar(context, title: "Add Friends"),
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         blurRadius: 20,
      //         color: Colors.black.withOpacity(.1),
      //       )
      //     ],
      //   ),
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      //       child: GNav(
      //         rippleColor: Colors.grey[300],
      //         hoverColor: Colors.grey[100],
      //         gap: 8,
      //         activeColor: Colors.black,
      //         iconSize: 24,
      //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      //         duration: Duration(milliseconds: 500),
      //         tabBackgroundColor: ColorPalette['primary'].withOpacity(0.7),
      //         color: Colors.black,
      //         // textStyle: TextStyle(),
      //         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         tabs: [
      //           GButton(
      //             icon: LineIcons.home,
      //             // text: '',
      //             // text: 'Home',
      //             onPressed: () {
      //               Navigator.of(context).pushReplacement(
      //                 PageRouteBuilder(
      //                   transitionDuration: Duration(seconds: 0),
      //                   pageBuilder: (context, animation1, animation2) =>
      //                       HomeScreen(
      //                     selectedIndx: _selectedIndex,
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //           GButton(
      //             icon: LineIcons.search,
      //             // text: '',
      //             // text: 'Search',
      //           ),
      //           GButton(
      //             icon: Ionicons.person_add_outline,
      //             // text: '',
      //             // text: 'Request',
      //           ),
      //           GButton(
      //             icon: LineIcons.user,
      //             // text: '',
      //             // text: 'Profile',
      //             onPressed: () {
      //               Navigator.of(context).pushReplacement(
      //                 PageRouteBuilder(
      //                   transitionDuration: Duration(seconds: 0),
      //                   pageBuilder: (context, animation1, animation2) =>
      //                       MyProfile(
      //                     selectedIndx: _selectedIndex,
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //         ],
      //         selectedIndex: _selectedIndex,
      //         onTabChange: (index) {
      //           setState(() {
      //             _selectedIndex = index;
      //           });
      //         },
      //       ),
      //     ),
      //   ),
      // ),

      bottomNavigationBar: BottomNavigator(
        selectedIndx: _page,
      ),


      // bottomNavigationBar: CurvedNavigationBar(
      //   key: _bottomNavigationKey,
      //   index: _page,
      //   height: 60.0,
      //   items: <Widget>[
      //     Padding(
      //       padding: const EdgeInsets.all(4.0),
      //       child: Icon(
      //         LineIcons.home,
      //         size: _page == 0 ? 33 : 30,
      //         // color: _page == 0 ? WhitePalette['white_4'] : Colors.black,
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(4.0),
      //       child: Icon(
      //         LineIcons.search,
      //         size: _page == 1 ? 33 : 30,
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(4.0),
      //       child: Icon(
      //         Ionicons.person_add_outline,
      //         size: _page == 2 ? 33 : 30,
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(4.0),
      //       child: Icon(
      //         LineIcons.user,
      //         size: _page == 3 ? 33 : 30,
      //       ),
      //     ),
      //   ],
      //   color: ColorPalette['primary'].withOpacity(0.67),
      //   buttonBackgroundColor: ColorPalette['primary'].withOpacity(0.67),
      //   backgroundColor: WhitePalette['white_4'],
      //   animationCurve: Curves.easeInOut,
      //   animationDuration: Duration(milliseconds: 400),
      //   onTap: (index) {
      //     switch (index) {
      //       case 0:
      //         Navigator.of(context).pushReplacement(PageRouteBuilder(
      //             transitionDuration: Duration(milliseconds: 400),
      //             pageBuilder: (context, animation1, animation2) {
      //               return HomeScreen(
      //                 selectedIndx: index,
      //               );
      //             }));
      //         break;
      //       case 1:
      //         Navigator.of(context).pushReplacement(PageRouteBuilder(
      //             transitionDuration: Duration(milliseconds: 400),
      //             pageBuilder: (context, animation1, animation2) {
      //               return SearchScreen(
      //                 selectedIndx: index,
      //               );
      //             }));
      //         break;
      //       case 2:
      //         Navigator.of(context).pushReplacement(PageRouteBuilder(
      //             transitionDuration: Duration(milliseconds: 400),
      //             pageBuilder: (context, animation1, animation2) {
      //               return SearchScreen(
      //                 selectedIndx: index,
      //               );
      //             }));
      //         break;
      //       case 3:
      //         Navigator.of(context).pushReplacement(PageRouteBuilder(
      //             transitionDuration: Duration(milliseconds: 400),
      //             pageBuilder: (context, animation1, animation2) {
      //               return MyProfile(
      //                 selectedIndx: index,
      //               );
      //             }));
      //         break;
      //       default:
      //     }
      //     setState(() {
      //       _page = index;
      //     });
      //   },
      //   letIndexChange: (index) => true,
      // ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorPalette['primary'],
              ),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 45,
                      child: TextFormField(
                        controller: _searchTextController,
                        onChanged: (val) {
                          _searchUser(val);
                        },
                        style: TextStyle(
                          color: ColorPalette['white_3'],
                        ),
                        textAlignVertical: TextAlignVertical.bottom,
                        autovalidateMode: AutovalidateMode.disabled,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefix: Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.02),
                          ),
                          hintStyle: TextStyle(
                            color: ColorPalette['white_1'],
                          ),
                          suffix: SvgPicture.asset(
                            'assets/svgs/search.svg',
                            width: 24,
                            alignment: Alignment.center,
                            height: 24,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorPalette['white_3'],
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorPalette['white_3'],
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          focusColor: ColorPalette['white_2'],
                        ),
                        cursorColor: ColorPalette['white_2'],
                      ),
                    ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.05,
                    //   child: SvgPicture.asset(
                    //     'assets/svgs/search.svg',
                    //     width: 20,
                    //     height: 20,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: _searchResult != null
                    ? SearchResultList()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Lottie.asset("assets/Animation/sad.json"),
                          ),
                          Text(
                            "No Userfound",
                            style: TextStyle(fontSize: 20),
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
