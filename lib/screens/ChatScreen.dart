import 'package:chatnest/Helpers/colorpanel.dart';
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
  TextEditingController _chatMessgae = TextEditingController();
  Stream _chatMessageStream;
  _sendMessage() {}

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _chatMessgae.dispose();
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
              child: Container(
                  // color: Colors.yellow,
                  ),
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
                        controller: _chatMessgae,
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
