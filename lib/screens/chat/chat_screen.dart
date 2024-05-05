import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dating_app/models/user_model.dart';
// import 'package:flutter_dating_app/models/message_model.dart';
import 'package:flutter_dating_app/screens/chat/individual_chat_page.dart';
// import 'package:flutter_dating_app/screens/onboarding/widgets/chat_bubble.dart';
// import 'package:flutter_dating_app/services/chat_service.dart';
import 'package:flutter_dating_app/widgets/bottom_nav_bar.dart';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_dating_app/models/user_model.dart';
import 'package:flutter_dating_app/services/firestore_service.dart';
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

// class ChatScreen extends StatefulWidget {
//   static const String routeName = '/chat';
//   final User matchedUser; // Change from String to User
//   const ChatScreen({Key? key, required this.matchedUser})
//       : super(key: key); // Change parameter type

//   static Route route({required User matchedUser}) {
//     // Modified route method to accept User
//     return MaterialPageRoute(
//       builder: (_) =>
//           ChatScreen(matchedUser: matchedUser), // Passing matchedUser
//       settings: const RouteSettings(name: routeName),
//     );
//   }

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

class _ChatScreenState extends State<ChatScreen> {
  final firestoreService = FirestoreService();
  List<dynamic> _users = [];

  // var userList;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // Future<void> _fetchData() async {
  //   try {
  //     final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  //     if (currentUserId != null) {
  //       final matchesSnapshot = await FirebaseFirestore.instance
  //           .collection('matches')
  //           .where('user2', isEqualTo: currentUserId)
  //           .get();
  //       final matchesSnapshot2 = await FirebaseFirestore.instance
  //           .collection('matches')
  //           .where('user1', isEqualTo: currentUserId)
  //           .get();
  //       final matchedUsers = matchesSnapshot.docs;

  //       // Print all matched users
  //       print('Matches:');
  //       for (var match in matchedUsers) {
  //         print(match.data()); // Assuming data is printed in JSON format
  //       }
  //       for (var match in matchesSnapshot2.docs) {
  //         print(match.data()); // Assuming data is printed in JSON format
  //       }

  //       setState(() {
  //         _users = matchedUsers.cast<User>();
  //       });
  //       print('current user: $currentUserId');
  //     } else {
  //       print('User not logged in.');
  //     }
  //   } catch (error) {
  //     print('Error fetching matched users: $error');
  //   }
  // }

  Future<void> _fetchData() async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId != null) {
        final matchesSnapshot = await FirebaseFirestore.instance
            .collection('matches')
            .where('user2', isEqualTo: currentUserId)
            .get();
        final matchesSnapshot2 = await FirebaseFirestore.instance
            .collection('matches')
            .where('user1', isEqualTo: currentUserId)
            .get();
        // final matchedUsers = [
        //   ...matchesSnapshot.docs,
        //   ...matchesSnapshot2.docs
        // ]
        // .where((match) =>
        //     match['user1'] != currentUserId &&
        //     match['user2'] != currentUserId)
        // .toList();

        final List<String> matchedUserIds = [];
        for (var match in matchesSnapshot.docs) {
          matchedUserIds.add(match['user1']);
        }
        for (var match in matchesSnapshot2.docs) {
          matchedUserIds.add(match['user2']);
        }
        final uniqueMatchedUserIds = matchedUserIds.toSet().toList();

        for (var match in uniqueMatchedUserIds) {
          print(match);
        }
        // final List<User> userList = [];
        final List userList = [];
        for (var userId in uniqueMatchedUserIds) {
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();
          if (userDoc.exists) {
            // final userData = User.fromMap(userDoc.data());
            final user = (
              // Assuming 'User' class has a constructor that takes necessary parameters
              uid: userId,
              name: userDoc['name'],
              imageUrls: userDoc['imageUrls'],
              email: userDoc['email']

              // Add other fields as needed, e.g., userDoc['name'], userDoc['email'], etc.
            );
            userList.add(user);
          } else {
            print('User data not found for user ID: $userId');
          }
        }
        for (var user in userList) {
          print('User ID: ${user.uid}');
          print('Name: ${user.name}');
          print('imageUrls: ${user.imageUrls}');
          print('email: ${user.email}');
        }

        print('current user: $currentUserId');
        setState(() {
          _users = userList;
        });
      } else {
        print('User not logged in.');
      }
    } catch (error) {
      print('Error fetching matched users: $error');
    }
  }

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: _users
                  .map((user) => _buildChatUser(
                        context,
                        user.name,
                        user.imageUrls[
                            0], // Assuming imageUrls is a list, change this accordingly
                        user.uid,
                        user.email, // Assuming you have an email field in the User model
                      ))
                  .toList(),
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              // children: [
              //   _buildChatUser(context, 'Koontung', 'assets/images/person1.png',
              //       "duzR4XhvrEWmLqV2xSLvKmygiZh1", "koontung0110@gmail.com"),
              //   _buildChatUser(context, 'Koontung', 'assets/images/person1.png',
              //       "duzR4XhvrEWmLqV2xSLvKmygiZh1", "koontung0110@gmail.com"),
              //   _buildChatUser(context, 'Tungtung', 'assets/images/person2.png',
              //       "CcLic9OlDnUaMFA0P6ZPfqzq0xI3", "tungtung309@gmail.com"),
              //   _buildChatUser(context, 'Lookbua', 'assets/images/person3.png',
              //       "GDD5qCCejsUqBWyIlHzgfCjaL1i2", "sshayathip@gmail.com"),
              //   // _buildChatUser(context, 'Emelie', 'assets/images/person4.png'),
              //   // _buildChatUser(context, 'Elizabeth', 'assets/images/person5.png'),
              // ],
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
