import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/config/database.dart';
import 'package:chatnest/screens/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polygon_clipper/polygon_border.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class ChatScreen extends StatefulWidget {
  final String chatRoomId;
  final String chatUserName;
  final String chatUserEmail;
  final String chatUserPhoneNumber;
  final String chatUserStatus;
  final String chatUserProfilePhoto;

  ChatScreen({
    this.chatRoomId,
    this.chatUserName,
    this.chatUserEmail,
    this.chatUserPhoneNumber,
    this.chatUserProfilePhoto,
    this.chatUserStatus,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _chatMessgaeController = TextEditingController();
  Stream _chatMessageStream;

  DataBaseMethods _dataBaseMethods = new DataBaseMethods();

  _sendMessage() {
    // print(DateTime.now());
    if (_chatMessgaeController.text.isNotEmpty) {
      Map<String, dynamic> _messageMap = {
        "message": _chatMessgaeController.text,
        "sentBy": FirebaseAuth.instance.currentUser.displayName,
        "time": DateTime.now(),
      };

      _dataBaseMethods.setConversionMessages(widget.chatRoomId, _messageMap);
      _chatMessgaeController.text = "";
    }
  }

  @override
  void initState() {
    _dataBaseMethods.getConversionMessages(widget.chatRoomId).then((value) {
      setState(() {
        _chatMessageStream = value;
      });
    });
    super.initState();
  }

  Widget ChatMessageList() {
    return StreamBuilder(
      stream: _chatMessageStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
          reverse: true,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            // print(snapshot.data.docs[index].data()["sentBy"]);
            return MessageTile(
                snapshot.data.docs[index].data()["message"],
                snapshot.data.docs[index].data()["sentBy"] ==
                    FirebaseAuth.instance.currentUser.displayName);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _chatMessgaeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.chatRoomId);
    return Scaffold(
      backgroundColor: Color(0xff171c26),
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // color: Colors.amber,
        // width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              height: 90,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  // color: WhitePalette['white_4'],
                  ),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            transitionDuration: Duration(seconds: 0),
                            pageBuilder: (context, animation1, animation2) =>
                                HomeScreen(),
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
                        child: SvgPicture.asset(
                          "assets/svgs/backButton.svg",
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                        // width: 24,
                        ),
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
                          child: widget.chatUserProfilePhoto != null
                              ? Image.network(
                                  widget.chatUserProfilePhoto,
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
                            widget.chatUserName,
                            style: TextStyle(
                              fontFamily: 'Montserrat_M',
                              fontSize: 20,
                              color: WhitePalette['white_4'],
                            ),
                          ),
                          Text(
                            widget.chatUserStatus,
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
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: WhitePalette['white_4'],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ChatMessageList(),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xff171c26),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10, top: 10),
                        // padding: ,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                // border: Border.all(
                                //   width: 2,
                                //   color: Color(0xff171c26),
                                // ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Color(0xff30353E),
                              ),
                              width: MediaQuery.of(context).size.width * 0.78,
                              height: 50,
                              child: TextFormField(
                                controller: _chatMessgaeController,
                                textAlignVertical: TextAlignVertical.bottom,
                                autovalidateMode: AutovalidateMode.disabled,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  hintText: 'Write Somthing...',
                                  hintStyle: TextStyle(
                                    color: ColorPalette['gray_2'],
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: const Color(0xffff7847),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: const Color(0xffff7847),
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: const Color(0xffff7847),
                                    ),
                                  ),

                                  // contentPadding:
                                  // EdgeInsets.only(left: 10),
                                ),
                                cursorColor: const Color(0xffff7847),
                                style: TextStyle(
                                  color: const Color(0xffFAFAFA),
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _sendMessage();
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffff7847),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 4, top: 2),
                                    child: SvgPicture.asset(
                                      "assets/svgs/send-letter.svg",
                                      height: 28,
                                      width: 28,
                                      color: ColorPalette['gray_0']
                                          .withOpacity(0.7),
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
            )
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String _message;
  final bool _isSendByMe;

  MessageTile(this._message, this._isSendByMe);

  @override
  Widget build(BuildContext context) {
    // print(_isSendByMe);.
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: _isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: _isSendByMe
            ? EdgeInsets.symmetric(vertical: 2, horizontal: 6)
            : EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        // height: 40,
        decoration: _isSendByMe
            ? BoxDecoration(
                color: const Color(0xffffd2c1),
                border: Border.all(
                  width: 1,
                  color: const Color(0xffff7847),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ))
            : BoxDecoration(
                color: const Color(0xffe5e5e6),
                border: Border.all(
                  width: 1,
                  color: Color(0xff171c26),
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
        child: Text(
          _message,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
