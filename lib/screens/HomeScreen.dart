import 'package:chatnest/Helpers/HelperWidgets.dart';
import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/screens/SearchScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.amber,
        centerTitle: true,
        backgroundColor: ColorPalette['primary'],
        title: Text(
          "CHATNEST",
          style: TextStyle(
            fontSize: 26,
          ),
        ),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.person_add_alt_1_outlined),
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
      drawer: homeScreenDrawer(context),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: ColorPalette['primary'],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chat",
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorPalette['white_3'],
                    ),
                  ),
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
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: ColorPalette['gray_0'],
            ),
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: ColorPalette['gray_0'].withOpacity(0.8),
            radius: 22,
            child: Text(
              _userName[0],
              style: TextStyle(
                color: ColorPalette['white_3'],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(_userName),
        ),
      ),
    );
  }
}
