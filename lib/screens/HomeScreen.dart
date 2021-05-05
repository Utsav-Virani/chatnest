import 'package:chatnest/Helpers/HelperWidgets.dart';
import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/screens/ChatScreen.dart';
import 'package:chatnest/screens/SearchScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream _availableChatRoomsStream;
  String _userName;
  @override
  void initState() {
    _getChatRooms();
    super.initState();
  }

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
                      // print(snapshot.data.docs[index].data()["usersName"][
                      //     snapshot.data.docs[index]
                      //         .data()["chatRoomId"]
                      //         .toString()
                      //         .replaceAll("_", "")
                      //         .replaceAll(
                      //             FirebaseAuth.instance.currentUser.uid, "")]);
                      // print(snapshot.data.docs[index].data()["chatRoomId"]);
                      // print(snapshot.data.docs[index].data()["chatRoomId"]);
                      return ChatRoomListTile(
                          snapshot.data.docs[index].data()["usersName"][snapshot
                              .data.docs[index]
                              .data()["chatRoomId"]
                              .toString()
                              .replaceAll("_", "")
                              .replaceAll(
                                  FirebaseAuth.instance.currentUser.uid, "")],
                          snapshot.data.docs[index].data()["chatRoomId"]);
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

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Likes',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhitePalette['white_6'],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          // backgroundColor: Colors.amber,
          iconTheme: IconThemeData(
            color: WhitePalette['white_6'],
            // color: ColorPalette['primary'],
            // size: 35,
          ),
          centerTitle: true,
          // backgroundColor: WhitePalette['white_6'],
          backgroundColor: ColorPalette['primary'],
          title: Text(
            "CHATNEST",
            style: TextStyle(
              fontSize: 30,
              color: WhitePalette['white_6'],
              // color: ColorPalette['primary'],
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.person_add_alt_1_outlined,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  // MaterialPageRoute(
                  //   builder: (context) {
                  //     return SearchScreen();
                  //   },
                  // ),
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: SearchScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      drawer: homeScreenDrawer(context),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300],
              hoverColor: Colors.grey[100],
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 500),
              tabBackgroundColor: ColorPalette['primary'].withOpacity(0.7),
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Likes',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 30,
              decoration: BoxDecoration(
                // color: ColorPalette['primary'],
                color: WhitePalette['white_6'],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   "Chat",
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     color: ColorPalette['white_3'],
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Expanded(
              child: ChatRoomList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatRoomListTile extends StatelessWidget {
  final String _userName;
  final String _chatRoomId;
  ChatRoomListTile(this._userName, this._chatRoomId);
  @override
  Widget build(BuildContext context) {
    // print(_chatRoomId);
    // print(_userName);
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ChatScreen(
                  chatRoomId: _chatRoomId,
                  chatUserName: _userName,
                );
              },
            ),
          );
        },
        child: Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: WhitePalette['white_4'],
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(
                width: 1,
                color: WhitePalette['white_4'],
              ),
              boxShadow: [
                BoxShadow(
                  color: WhitePalette['white_6'],
                  blurRadius: 1,
                  spreadRadius: 2,
                  offset: Offset(2.0, 2.0),
                ),
              ]),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: ColorPalette['gray_0'].withOpacity(0.8),
              radius: 24,
              child: Text(
                _userName[0],
                style: TextStyle(
                  color: ColorPalette['white_3'],
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            title: Text(
              _userName,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
