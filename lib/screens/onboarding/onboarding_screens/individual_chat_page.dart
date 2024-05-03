import 'package:flutter/material.dart';

class IndividualChatPage extends StatelessWidget {
  final String personName;

  IndividualChatPage({required this.personName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildCustomAppBar(context),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/container.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 64, 0, 0), // Adjust top padding as needed
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      ChatMessage(
                        message: 'Hi Jake, how are you? I saw on the app that we\'ve crossed paths several times this week 😊',
                        isMe: false,
                        time: '2:55 PM',
                      ),
                      ChatMessage(
                        message: 'Haha truly! Nice to meet you Grace! What about a cup of coffee today evening? ☕',
                        isMe: true,
                        time: '3:02 PM',
                      ),
                      ChatMessage(
                        message: 'Sure, let\'s do it! 😊',
                        isMe: false,
                        time: '3:10 PM',
                      ),
                      ChatMessage(
                        message: 'Great! I will write later the exact time and place. See you soon!',
                        isMe: true,
                        time: '3:12 PM',
                      ),
                    ],
                  ),
                ),
                _buildMessageInput(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildCustomAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        personName,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.more_vert, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.pink[300]),
            onPressed: () {
              // Implement sending message functionality
            },
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;

  ChatMessage({required this.message, required this.isMe, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Colors.pink[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message,
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                time,
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
