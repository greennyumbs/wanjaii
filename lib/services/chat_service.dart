import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dating_app/models/chat_model.dart';
import 'package:flutter_dating_app/models/message_model.dart';

class ChatService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String get currentUserId => _auth.currentUser?.uid ?? '';

  Future<List<Chat>> getChats() async {
    final chatsQuery = await _firestore
        .collection('chats')
        .where('userIds', arrayContains: currentUserId)
        .get();

    return chatsQuery.docs.map((doc) => Chat.fromMap(doc.data())).toList();
  }

  Future<List<Message>> getMessages(String chatId) async {
    final messagesQuery = await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .get();

    return messagesQuery.docs
        .map((doc) => Message.fromMap(doc.data()))
        .toList();
  }

  Future<void> sendMessage({
    required String chatId,
    required String text,
  }) async {
    final message = Message(
      senderId: currentUserId,
      text: text,
      timestamp: Timestamp.now(),
    );

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toMap());
  }
}
