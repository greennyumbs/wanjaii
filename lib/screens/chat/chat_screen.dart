import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        toolbarHeight: 100,
        //backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
          child: Column(
            children: [
              Text('Messages',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Sk-Modernist',
                    fontWeight: FontWeight.w800,
                    fontSize: 32,
                  )),
            ],
          ),
        ),

        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
            child: Container(
              width: 52,
              height: 52,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFE8E6EA)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.tune,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(index: 2),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //const SizedBox(height: 16.0),
              Container(
                height: 55,
                child: const Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Sk-Modernist',
                            color: Color(0xFFB3B3B3),
                          ),
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Color(0xFFB3B3B3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                            borderSide: BorderSide(
                              color: Color(0xFFB3B3B3),
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                          user.imageUrls,
                          user.uid,
                          user.email, // Assuming you have an email field in the User model
                        ))
                    .toList(),
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
                      image: 'assets/images/girl1.png',
                      message: 'I\'m good, thanks!',
                    ),
                    ChatTile(
                      name: 'Ava',
                      image: 'assets/images/girl2.png',
                      message: 'What\'s up?',
                    ),
                    ChatTile(
                      name: 'Emelie',
                      image: 'assets/images/girl3.png',
                      message:
                          'Show a sticker image here', // Replace with sticker display logic
                    ),
                    ChatTile(
                      name: 'Elizabeth',
                      image: 'assets/images/girl4.jpg',
                      message: 'OK,see you then',
                    ),
                    // Add more ChatTile widgets for additional messages
                  ],
                ),
              ),
            ],
          ),
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
            radius: 35.0,
            backgroundImage: AssetImage(imagePath) ??
                AssetImage('assets/images/profile_placeholder.png'),
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
