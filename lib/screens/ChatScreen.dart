import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/config/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends StatefulWidget {
  final String chatRoomId;
  final String chatUserName;

  ChatScreen({this.chatRoomId, this.chatUserName});

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
      appBar: AppBar(
        title: Text(widget.chatUserName),
        centerTitle: true,
        elevation: 0,
        actions: [],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        // color: Colors.amber,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ChatMessageList(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: ColorPalette['gray_0'].withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: TextFormField(
                        controller: _chatMessgaeController,
                        textAlignVertical: TextAlignVertical.center,
                        autovalidateMode: AutovalidateMode.disabled,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'Write Somthing...',
                          hintStyle: TextStyle(
                            color: ColorPalette['gray_2'],
                          ),
                          border: InputBorder.none,
                        ),
                        cursorColor: ColorPalette['gray_1'],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _sendMessage();
                      },
                      child: Container(
                        child: SvgPicture.asset(
                          "assets/svgs/send-letter.svg",
                          height: 45,
                          width: 45,
                          color: ColorPalette['gray_0'].withOpacity(0.7),
                        ),
                      ),
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
            : EdgeInsets.symmetric(vertical: 5, horizontal: 6),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        // height: 40,
        decoration: _isSendByMe
            ? BoxDecoration(
                color: ColorPalette['secondary'].withOpacity(0.5),
                border: Border.all(width: 1, color: ColorPalette['secondary']),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ))
            : BoxDecoration(
                color: ColorPalette['gray_0'].withOpacity(0.3),
                border: Border.all(width: 1, color: ColorPalette['gray_0']),
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
