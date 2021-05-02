import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  uploadUserInfo(userData, userId) {
    FirebaseFirestore.instance.collection("UserData").doc(userId).set(userData);
  }

  setConversionMessages(String _chatRoomId, _messageMap) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(_chatRoomId)
        .collection("Chats")
        .add(_messageMap)
        .catchError((onError) {
      print(onError.toString());
    });
  }

  getConversionMessages(String _chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(_chatRoomId)
        .collection("Chats")
        .orderBy("time", descending: true)
        .snapshots();
  }
}
