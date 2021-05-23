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

class HomeScreen extends StatefulWidget {
  final int selectedIndx;
  HomeScreen({this.selectedIndx});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream _availableChatRoomsStream;

  String _userName;

  int _selectedIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  int _page = 0;

  @override
  void initState() {
    // print();
    _page = widget.selectedIndx is Null ? 0 : widget.selectedIndx;

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

  bool isSearchVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhitePalette['white_4'],
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(70),
      //   child: AppBar(
      //     // backgroundColor: Colors.amber,
      //     iconTheme: IconThemeData(
      //       // color: WhitePalette['white_4'],
      //       color: ColorPalette['primary'],
      //       // size: 35,
      //     ),
      //     centerTitle: true,
      //     backgroundColor: WhitePalette['white_4'],
      //     // backgroundColor: ColorPalette['primary'].withOpacity(0.9),
      //     // title: Text(
      //     //   "CHATNEST",
      //     //   style: TextStyle(
      //     //     letterSpacing: 3,
      //     //     fontSize: 30,
      //     //     // color: WhitePalette['white_4'],
      //     //     color: ColorPalette['primary'],
      //     //     fontWeight: FontWeight.bold,
      //     //   ),
      //     // ),
      //     elevation: 0.0,
      //     // actions: [
      //     //   IconButton(
      //     //     icon: Icon(
      //     //       Icons.person_add_alt_1_outlined,
      //     //     ),
      //     //     onPressed: () {
      //     //       Navigator.of(context).push(
      //     //         // MaterialPageRoute(
      //     //         //   builder: (context) {
      //     //         //     return SearchScreen();
      //     //         //   },
      //     //         // ),
      //     //         PageTransition(
      //     //           type: PageTransitionType.rightToLeft,
      //     //           child: SearchScreen(),
      //     //         ),
      //     //       );
      //     //     },
      //     //   ),
      //     // ],
      //   ),
      // ),
      // drawer: homeScreenDrawer(context),

      //! BOTTOM NAV
      // bottomNavigationBar: BottomNavigator(
      //   selectedIndx: _page,
      // ),

      // bottomNavigationBar: Container(
      //   height: 200,
      //   child: XDBottomNavBar(),
      // ),

      // floatingActionButton: FabCircularMenu(
      //   alignment: Alignment.bottomRight,
      //   // ringColor: Colors.white.withAlpha(25),
      //   ringDiameter: 420.0,
      //   ringWidth: 100.0,
      //   fabSize: 70.0,
      //   fabElevation: 8.0,
      //   fabOpenIcon: SvgPicture.asset(
      //     "assets/svgs/ChatNest_outline.svg",
      //     height: 30,
      //   ),
      //   fabCloseIcon: Icon(
      //     Icons.close,
      //   ),
      //   // fabColor: Colors.transparent,
      //   fabColor: ColorPalette['nav_bar'],
      //   children: <Widget>[
      //     RawMaterialButton(
      //       onPressed: () {},
      //       shape: CircleBorder(),
      //       padding: const EdgeInsets.all(24.0),
      //       child: Icon(
      //         LineIcons.home,
      //         size: _page == 1 ? 26 : 24,
      //         color: _page == 1 ? ColorPalette['nav_bar'] : Colors.black,
      //       ),
      //     ),
      //     RawMaterialButton(
      //       onPressed: () {},
      //       shape: CircleBorder(),
      //       padding: const EdgeInsets.all(24.0),
      //       child: Icon(
      //         LineIcons.phone,
      //         size: _page == 1 ? 26 : 24,
      //         color: _page == 1 ? ColorPalette['nav_bar'] : Colors.black,
      //       ),
      //     ),
      //     RawMaterialButton(
      //       onPressed: () {},
      //       shape: CircleBorder(),
      //       padding: const EdgeInsets.all(24.0),
      //       child: Icon(
      //         LineIcons.search,
      //         size: _page == 2 ? 26 : 24,
      //         color: _page == 2 ? ColorPalette['nav_bar'] : Colors.black,
      //       ),
      //     ),
      //     RawMaterialButton(
      //       onPressed: () {},
      //       shape: CircleBorder(),
      //       padding: const EdgeInsets.all(24.0),
      //       child: Icon(
      //         Ionicons.person_add_outline,
      //         size: _page == 3 ? 26 : 24,
      //         color: _page == 3 ? ColorPalette['nav_bar'] : Colors.black,
      //       ),
      //     ),
      //     RawMaterialButton(
      //       onPressed: () {},
      //       shape: CircleBorder(),
      //       padding: const EdgeInsets.all(24.0),
      //       child: Icon(
      //         LineIcons.user,
      //         size: _page == 4 ? 26 : 24,
      //         color: _page == 4 ? ColorPalette['nav_bar'] : Colors.black,
      //       ),
      //     ),
      //   ],
      // ),

      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            top: 20,
          ),
          child: Column(
            children: [
              Container(
                // color: Colors.black12,
                height: 74,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: !isSearchVisible
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.spaceEvenly,
                  children: [
                    !isSearchVisible
                        ? Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: 'SegoeScript',
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4,
                                color: const Color(0xffff7847),
                                shadows: [
                                  Shadow(
                                    color: const Color(0x33121212),
                                    offset: Offset(3, 3),
                                    blurRadius: 6,
                                  )
                                ],
                              ),
                              children: [
                                TextSpan(
                                  text: 'C',
                                ),
                                TextSpan(
                                  text: 'hat',
                                  style: TextStyle(
                                    fontSize: 45,
                                  ),
                                ),
                                TextSpan(
                                  text: 'N',
                                  style: TextStyle(
                                    fontSize: 52,
                                  ),
                                ),
                                TextSpan(
                                  text: 'est',
                                  style: TextStyle(
                                    fontSize: 45,
                                  ),
                                ),
                              ],
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.center,
                          )
                        : Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    padding: EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                        "assets/svgs/backButton.svg"),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height: 45,
                                  child: TextFormField(
                                    // controller: _searchTextController,
                                    onChanged: (val) {
                                      // _searchUser(val);
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
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02),
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
                                    ),
                                    cursorColor: Color(0xff171c26),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSearchVisible = !isSearchVisible;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 50,
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
              // Container(
              //   height: 30,
              //   decoration: BoxDecoration(
              //     // color: ColorPalette['primary'],
              //     color: WhitePalette['white_4'],
              //   ),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       // Text(
              //       //   "Chat",
              //       //   style: TextStyle(
              //       //     fontSize: 18,
              //       //     color: ColorPalette['white_3'],
              //       //   ),
              //       // ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Expanded(
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
              // color: ColorPalette['primary'].withOpacity(0.15),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              border: Border.all(
                width: 1,
                color: WhitePalette['white_4'],
              ),
              boxShadow: [
                // BoxShadow(
                //   color: WhitePalette['white_6'],
                //   blurRadius: 5,
                //   spreadRadius: 2,
                //   offset: Offset(2.0, 2.0),
                // ),
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
