import 'package:flutter/material.dart';
// import 'package:flutter_dating_app/models/message_model.dart';
import 'package:flutter_dating_app/screens/chat/individual_chat_page.dart';
// import 'package:flutter_dating_app/screens/onboarding/widgets/chat_bubble.dart';
// import 'package:flutter_dating_app/services/chat_service.dart';
import 'package:flutter_dating_app/widgets/bottom_nav_bar.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat';

  final String chatId;
  const ChatScreen({super.key, required this.chatId});

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Wrap the content with Scaffold to use Material widgets
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(index: 2),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            const Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'New Matches',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildChatUser(context, 'Koontung', 'assets/images/person1.png',
                    "duzR4XhvrEWmLqV2xSLvKmygiZh1", "koontung0110@gmail.com"),
                _buildChatUser(context, 'Tungtung', 'assets/images/person2.png',
                    "CcLic9OlDnUaMFA0P6ZPfqzq0xI3", "tungtung309@gmail.com"),
                // _buildChatUser(context, 'Ava', 'assets/images/person3.png'),
                // _buildChatUser(context, 'Emelie', 'assets/images/person4.png'),
                // _buildChatUser(context, 'Elizabeth', 'assets/images/person5.png'),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Messages',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: [
                  ChatTile(
                    name: 'Emma',
                    image: 'assets/images/person2.png',
                    message: 'I\'m good, thanks!',
                  ),
                  ChatTile(
                    name: 'Ava',
                    image: 'assets/images/person3.png',
                    message: 'What\'s up?',
                  ),
                  ChatTile(
                    name: 'Emelie',
                    image: 'assets/images/person4.png',
                    message:
                        'Show a sticker image here', // Replace with sticker display logic
                  ),
                  ChatTile(
                    name: 'Elizabeth',
                    image: 'assets/images/person5.png',
                    message: 'OK,see you then',
                  ),
                  // Add more ChatTile widgets for additional messages
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatUser(BuildContext context, String name, String imagePath,
      String receiverId, String receiverEmail) {
    // const receiverId = "duzR4XhvrEWmLqV2xSLvKmygiZh1";
    // const receiverEmail = "koontung0110@gmail.com";
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualChatPage(
                receiverEmail: receiverEmail, receiverId: receiverId),
          ),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 40.0,
            backgroundImage: AssetImage(imagePath),
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String name;
  final String image;
  final String message;

  ChatTile({required this.name, required this.image, required this.message});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: AssetImage(image),
      ),
      title: Text(name),
      subtitle: Text(message),
      onTap: () {
        // Handle tapping on the chat tile
      },
    );
  }
}
