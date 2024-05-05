import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dating_app/screens/chat/chat_bubbles.dart';
// import 'package:flutter_dating_app/models/chatModel/message.dart';
import 'package:flutter_dating_app/screens/chat/chat_service.dart';
// import 'package:flutter_dating_app/services/chat_service.dart';

class IndividualChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverId;
  IndividualChatPage(
      {super.key, required this.receiverEmail, required this.receiverId});

  final ChatServices _chatService = ChatServices();

  final messageController = TextEditingController();

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      // print("sendButton Pressed");

      await _chatService.sendMessage(receiverId, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          receiverEmail,
          style: const TextStyle(
              color: Color(
                  0xFFFFFFFF)), // Assuming you want the text color to be 0xFFBB254A
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFBB254A),
        leading: const BackButton(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0), // Adjust padding as needed
              child: _buildMessageList(),
            ),
          ),
          Container(
              height: 80,
              decoration: const BoxDecoration(color: Color(0xFFBB254A)),
              child: _buildUserInput()),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(currentUserID, receiverId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("ERROR");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Color(0xFFBB254A),
            );
          }

          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser =
        data['senderId'] == FirebaseAuth.instance.currentUser!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    final Timestamp timestamp = data["timestamp"];
    String date = DateFormat.yMMMEd().format(
        timestamp.toDate()); // Use 'yMMMEd' for date with month name and year
    String time = DateFormat.Hm().format(timestamp.toDate());

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubbles(
              message: data["message"],
              isCurrentUser: isCurrentUser,
              timestamp: data["timestamp"]),
          Container(
            // padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
            child: Text(
              date + " " + "on" + " " + time,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Sk-Modernist',
                fontWeight: FontWeight.w700,
                color: Color(0xFFBB254A),
              ),
            ),
          ),
          const SizedBox(height: 3.0), // Spacing after the date
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Sk-Modernist',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFBB254A),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
              ),
            ),
          ),
          IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.send, color: Colors.white)),
        ],
      ),
    );
  }
}
