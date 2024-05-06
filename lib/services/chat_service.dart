import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dating_app/models/message_model.dart';

class ChatServices {
  //Send Message
  Future<void> sendMessage(String receiverId, message) async {
    final String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    final String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: currentUserID,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    //Construct a chat room id
    List<String> ids = [currentUserID, receiverId];
    ids.sort(); //ensure chatroomid contain only 2 people
    String chatRoomId = ids.join('_');

    await FirebaseFirestore.instance
        .collection("chat_room")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //Get Message
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return FirebaseFirestore.instance
        .collection("chat_room")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
