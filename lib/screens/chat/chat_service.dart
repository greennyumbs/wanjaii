// import 'dart:html';
// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dating_app/models/chatModel/message.dart';
// import 'package:image_picker/image_picker.dart';

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
        type: "text",
        message: message,
        imageUrls: "",
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

  Future<void> sendImage(String receiverId, imageUrls) async {
    final String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    final String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    //Construct a chat room id
    List<String> ids = [currentUserID, receiverId];
    ids.sort(); //ensure chatroomid contain only 2 people
    String chatRoomId = ids.join('_');

    Message newMessage = Message(
        senderId: currentUserID,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        type: "image",
        message: "",
        imageUrls: imageUrls,
        timestamp: timestamp);

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception('Current user is null');
    }

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
