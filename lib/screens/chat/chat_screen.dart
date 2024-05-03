import 'package:flutter/material.dart';
import 'package:flutter_dating_app/models/message_model.dart';
import 'package:flutter_dating_app/screens/onboarding/widgets/chat_bubble.dart';
import 'package:flutter_dating_app/services/chat_service.dart';
import 'package:flutter_dating_app/widgets/bottom_nav_bar.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat';

  final String chatId;
  const ChatScreen({Key? key, required this.chatId}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ChatScreen(
        chatId: '',
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _messages = [];
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  Future<void> _fetchMessages() async {
    _messages = await ChatService().getMessages(widget.chatId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      bottomNavigationBar: const BottomNavBar(index: 2),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(
                  message: message.text,
                  isCurrentUser:
                      message.senderId == ChatService().currentUserId,
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    final messageText = _messageController.text.trim();
                    if (messageText.isNotEmpty) {
                      await ChatService().sendMessage(
                        chatId: widget.chatId,
                        text: messageText,
                      );
                      _messageController.clear();
                      _fetchMessages();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
