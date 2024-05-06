<<<<<<< Updated upstream
=======
<<<<<<< HEAD
>>>>>>> Stashed changes
// import 'dart:convert';
// import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dating_app/screens/chat/individual_chat_page.dart';
import 'package:flutter_dating_app/services/chat_service.dart';
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dating_app/models/user_model.dart';
// import 'package:flutter_dating_app/models/message_model.dart';
import 'package:flutter_dating_app/screens/chat/individual_chat_page.dart';
// import 'package:flutter_dating_app/screens/onboarding/widgets/chat_bubble.dart';
// import 'package:flutter_dating_app/services/chat_service.dart';
import 'package:flutter_dating_app/widgets/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_dating_app/services/firestore_service.dart';
// import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_dating_app/models/user_model.dart';
import 'package:flutter_dating_app/services/firestore_service.dart';
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
import 'package:flutter_dating_app/widgets/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_dating_app/services/firestore_service.dart';
// import 'package:http/http.dart' as http;

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
<<<<<<< Updated upstream
  final ChatServices _chatService = ChatServices();
  List<dynamic> _users = [];
  List<dynamic> _filteredMatches = [];
=======
<<<<<<< HEAD
  final ChatServices _chatService = ChatServices();
  List<dynamic> _users = [];
  List<dynamic> _filteredMatches = [];
=======
  List<dynamic> _users = [];

  // var userList;
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
>>>>>>> Stashed changes

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
>>>>>>> Stashed changes
  @override
  void didUpdateWidget(covariant ChatScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _fetchData();
  }

<<<<<<< Updated upstream
=======
=======
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream

        final List<String> matchedUserIds = [];

=======
<<<<<<< HEAD

        final List<String> matchedUserIds = [];

=======
        // final matchedUsers = [
        //   ...matchesSnapshot.docs,
        //   ...matchesSnapshot2.docs
        // ]
        // .where((match) =>
        //     match['user1'] != currentUserId &&
        //     match['user2'] != currentUserId)
        // .toList();

        final List<String> matchedUserIds = [];
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
>>>>>>> Stashed changes
        for (var match in matchesSnapshot.docs) {
          matchedUserIds.add(match['user1']);
        }
        for (var match in matchesSnapshot2.docs) {
          matchedUserIds.add(match['user2']);
        }
        final uniqueMatchedUserIds = matchedUserIds.toSet().toList();
<<<<<<< Updated upstream
        final List matchList = [];
=======
<<<<<<< HEAD
        final List matchList = [];
=======

        for (var match in uniqueMatchedUserIds) {
          print(match);
        }
        // final List<User> userList = [];
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
>>>>>>> Stashed changes
        final List userList = [];
        for (var userId in uniqueMatchedUserIds) {
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();
          if (userDoc.exists) {
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
>>>>>>> Stashed changes
            final user = (
              uid: userId,
              name: userDoc['name'],
              imageUrls: userDoc['imageUrls'],
              email: userDoc['email'],
<<<<<<< Updated upstream
=======
=======
            // final userData = User.fromMap(userDoc.data());
            final user = (
              // Assuming 'User' class has a constructor that takes necessary parameters
              uid: userId,
              name: userDoc['name'],
              imageUrls: userDoc['imageUrls'],
              email: userDoc['email']

              // Add other fields as needed, e.g., userDoc['name'], userDoc['email'], etc.
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
>>>>>>> Stashed changes
            );
            userList.add(user);
          } else {
            print('User data not found for user ID: $userId');
          }
        }
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
>>>>>>> Stashed changes
        //Print
        // for (var user in matchList) {
        //   print('User ID: ${user.uid}');
        //   print('Name: ${user.name}');
        //   print('imageUrls: ${user.imageUrls}');
        //   print('email: ${user.email}');
        // }

        // print('current user: $currentUserId');
        setState(() {
          _users = userList;
        });
        setState(() {
          _filteredMatches = matchList;
        });
<<<<<<< Updated upstream
=======
=======
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
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
>>>>>>> Stashed changes
          ),
        ),

        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomNavBar(index: 2), // Removed const
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 16), // Removed const
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0), // Removed const
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 1),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search_rounded),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 183, 178, 179)),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 183, 178, 179)),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Sk-Modernist',
                      ),
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: 16.0), // Removed const
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                'New Matches',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sk-Modernist',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _users
                      .map((user) => Padding(
                            padding: const EdgeInsets.all(
                                8.0), // Adjust the padding as needed
                            child: _buildChatUser(
                              context,
                              user.name,
                              user.imageUrls, // Assuming imageUrls is a list, change this accordingly
                              user.uid,
                              user.email, // Assuming you have an email field in the User model
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            SizedBox(height: 16.0), // Removed const
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                'Messages',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sk-Modernist',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: _buildMessageList(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
<<<<<<< Updated upstream
        ),
      ),
    );
  }

  Widget _buildMessageList(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('matches').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display loading indicator while waiting for data
        }
        if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Display error message if there's an error
        }

        final currentUserId = FirebaseAuth.instance.currentUser?.uid;
        final matchedUserIds = <String>{};

        for (var doc in snapshot.data!.docs) {
          if (doc['user1'] == currentUserId) {
            matchedUserIds.add(doc['user2']);
          } else if (doc['user2'] == currentUserId) {
            matchedUserIds.add(doc['user1']);
          }
        }

        return ListView.builder(
          itemCount: matchedUserIds.length,
          itemBuilder: (context, index) {
            final userId = matchedUserIds.elementAt(index);
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Display loading indicator while waiting for user data
                }
                if (userSnapshot.hasError) {
                  return Text(
                      'Error: ${userSnapshot.error}'); // Display error message if there's an error
                }

                final userData =
                    userSnapshot.data!.data() as Map<String, dynamic>;
                final userName = userData['name'];
                final userImage = userData['imageUrls'] != null &&
                        userData['imageUrls'].isNotEmpty
                    ? userData['imageUrls']
                    : Icons.person;
// Null-aware access to imageUrls
                print("userImage: $userImage");

                // Define function to fetch latest message
                Stream<QuerySnapshot> getLatestMessageStream(
                    String currentUserId, String otherUserId) {
                  List<String> ids = [currentUserId, otherUserId];
                  ids.sort();
                  String chatRoomId = ids.join('_');
                  return FirebaseFirestore.instance
                      .collection("chat_room")
                      .doc(chatRoomId)
                      .collection("messages")
                      .orderBy("timestamp", descending: true)
                      .limit(1)
                      .snapshots();
                }

                // Fetch latest message
                var latestMessageStream =
                    getLatestMessageStream(currentUserId!, userId);

                return StreamBuilder<QuerySnapshot>(
                  stream: latestMessageStream,
                  builder: (context, messageSnapshot) {
                    if (messageSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Display loading indicator while waiting for message data
                    }
                    if (messageSnapshot.hasError) {
                      return Text(
                          'Error: ${messageSnapshot.error}'); // Display error message if there's an error
                    }

                    // Retrieve message
                    var messageDocs = messageSnapshot.data!.docs;
                    if (messageDocs.isEmpty) {
                      return SizedBox(); // Return an empty SizedBox if there's no message
                    }

                    var message = messageDocs.first['message'];
                    var type = messageDocs.first['type'];
                    var sender = messageDocs.first['senderId'];

                    print("type, $type");
                    print("message, $message");
                    // Check conditions
                    if (message == "" && type != 'image') {
                      return SizedBox(); // Return SizedBox if message is null and type is not image
                    } else if (message == "" &&
                        type == 'image' &&
                        sender == userId) {
                      message =
                          '$userName sent a photo'; // Set message to 'You sent a photo' if message is null and type is image
                    } else if (message == "" &&
                        type == 'image' &&
                        sender != userId) {
                      message = 'You sent a photo';
                    }
                    // print("type: $type");

                    return ChatTile(
                      name: userName,
                      message: message,
                      image: userImage,
                      receiverEmail: userData['email'],
                      receiverId: userId,
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

Widget _buildMessageItem(DocumentSnapshot doc) {
  final messageText =
      doc['text']; // Assuming 'text' is the field in your message document
  return ListTile(
    title: Text(messageText),
    // Customize the appearance of the message item as needed
  );
}

Widget _buildChatUser(BuildContext context, String name, String imagePath,
    String receiverId, String receiverEmail) {
  print("imagePath: ${imagePath}");
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
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Color(0xFFBB254A), // Set border color to red
              width: 2.0, // Set border width
=======
=======
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
>>>>>>> Stashed changes
            ),
          ),
          child: CircleAvatar(
            radius: 40.0,
            backgroundImage: NetworkImage(imagePath),
          ),
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 16.0, fontFamily: 'Sk-Modernist'),
        ),
      ],
    ),
  );
}

class ChatTile extends StatefulWidget {
  final String name;
  final String image;
  final String message;
  final String receiverEmail;
  final String receiverId;

  const ChatTile({
    Key? key,
    required this.name,
    required this.image,
    required this.message,
    required this.receiverEmail,
    required this.receiverId,
  }) : super(key: key);

  @override
  _ChatTileState createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  late String _message;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _loadLatestMessage();

    // Set up a timer to fetch new messages periodically
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _loadLatestMessage();
    });
  }

  void _loadLatestMessage() {
    // Assign the latest message text to the _message variable
    _message = widget.message;
    setState(() {}); // Trigger a rebuild to update the message in the UI
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("widget.image: ${widget.image}");
    // print("widget.name: ${widget.name}");
    return ListTile(
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(widget.image),
      ),
      title: Text(
        widget.name,
        style: TextStyle(
          fontFamily: 'Sk-Modernist',
        ),
      ),
      subtitle: Text(
        _message,
        style: TextStyle(
          fontFamily: 'Sk-Modernist',
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualChatPage(
              receiverEmail: widget.receiverEmail,
              receiverId: widget.receiverId,
            ),
          ),
        );
      },
      // Add the Divider widget as the trailing property
      trailing: Container(
        height: 50, // Adjust the height of the line as needed
        width: 2, // Adjust the width of the line as needed
        color: Color(0xFFBB254A), // Set the color of the line to red
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
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildMessageList(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('matches').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display loading indicator while waiting for data
        }
        if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Display error message if there's an error
        }

        final currentUserId = FirebaseAuth.instance.currentUser?.uid;
        final matchedUserIds = <String>{};

        for (var doc in snapshot.data!.docs) {
          if (doc['user1'] == currentUserId) {
            matchedUserIds.add(doc['user2']);
          } else if (doc['user2'] == currentUserId) {
            matchedUserIds.add(doc['user1']);
          }
        }

        return ListView.builder(
          itemCount: matchedUserIds.length,
          itemBuilder: (context, index) {
            final userId = matchedUserIds.elementAt(index);
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Display loading indicator while waiting for user data
                }
                if (userSnapshot.hasError) {
                  return Text(
                      'Error: ${userSnapshot.error}'); // Display error message if there's an error
                }

                final userData =
                    userSnapshot.data!.data() as Map<String, dynamic>;
                final userName = userData['name'];
                final userImage = userData['imageUrls'] != null &&
                        userData['imageUrls'].isNotEmpty
                    ? userData['imageUrls']
                    : Icons.person;
// Null-aware access to imageUrls
                print("userImage: $userImage");

                // Define function to fetch latest message
                Stream<QuerySnapshot> getLatestMessageStream(
                    String currentUserId, String otherUserId) {
                  List<String> ids = [currentUserId, otherUserId];
                  ids.sort();
                  String chatRoomId = ids.join('_');
                  return FirebaseFirestore.instance
                      .collection("chat_room")
                      .doc(chatRoomId)
                      .collection("messages")
                      .orderBy("timestamp", descending: true)
                      .limit(1)
                      .snapshots();
                }

                // Fetch latest message
                var latestMessageStream =
                    getLatestMessageStream(currentUserId!, userId);

                return StreamBuilder<QuerySnapshot>(
                  stream: latestMessageStream,
                  builder: (context, messageSnapshot) {
                    if (messageSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Display loading indicator while waiting for message data
                    }
                    if (messageSnapshot.hasError) {
                      return Text(
                          'Error: ${messageSnapshot.error}'); // Display error message if there's an error
                    }

                    // Retrieve message
                    var messageDocs = messageSnapshot.data!.docs;
                    if (messageDocs.isEmpty) {
                      return SizedBox(); // Return an empty SizedBox if there's no message
                    }

                    var message = messageDocs.first['message'];
                    var type = messageDocs.first['type'];
                    var sender = messageDocs.first['senderId'];

                    print("type, $type");
                    print("message, $message");
                    // Check conditions
                    if (message == "" && type != 'image') {
                      return SizedBox(); // Return SizedBox if message is null and type is not image
                    } else if (message == "" &&
                        type == 'image' &&
                        sender == userId) {
                      message =
                          '$userName sent a photo'; // Set message to 'You sent a photo' if message is null and type is image
                    } else if (message == "" &&
                        type == 'image' &&
                        sender != userId) {
                      message = 'You sent a photo';
                    }
                    // print("type: $type");

                    return ChatTile(
                      name: userName,
                      message: message,
                      image: userImage,
                      receiverEmail: userData['email'],
                      receiverId: userId,
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

Widget _buildMessageItem(DocumentSnapshot doc) {
  final messageText =
      doc['text']; // Assuming 'text' is the field in your message document
  return ListTile(
    title: Text(messageText),
    // Customize the appearance of the message item as needed
  );
}

Widget _buildChatUser(BuildContext context, String name, String imagePath,
    String receiverId, String receiverEmail) {
  print("imagePath: ${imagePath}");
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
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Color(0xFFBB254A), // Set border color to red
              width: 2.0, // Set border width
            ),
=======
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
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
          ),
          child: CircleAvatar(
            radius: 40.0,
            backgroundImage: NetworkImage(imagePath),
          ),
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 16.0, fontFamily: 'Sk-Modernist'),
        ),
      ],
    ),
  );
}

class ChatTile extends StatefulWidget {
  final String name;
  final String image;
  final String message;
  final String receiverEmail;
  final String receiverId;

  const ChatTile({
    Key? key,
    required this.name,
    required this.image,
    required this.message,
    required this.receiverEmail,
    required this.receiverId,
  }) : super(key: key);

  @override
  _ChatTileState createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  late String _message;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _loadLatestMessage();

    // Set up a timer to fetch new messages periodically
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _loadLatestMessage();
    });
  }

  void _loadLatestMessage() {
    // Assign the latest message text to the _message variable
    _message = widget.message;
    setState(() {}); // Trigger a rebuild to update the message in the UI
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("widget.image: ${widget.image}");
    // print("widget.name: ${widget.name}");
    return ListTile(
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(widget.image),
      ),
      title: Text(
        widget.name,
        style: TextStyle(
          fontFamily: 'Sk-Modernist',
        ),
      ),
      subtitle: Text(
        _message,
        style: TextStyle(
          fontFamily: 'Sk-Modernist',
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualChatPage(
              receiverEmail: widget.receiverEmail,
              receiverId: widget.receiverId,
            ),
          ),
        );
      },
      // Add the Divider widget as the trailing property
      trailing: Container(
        height: 50, // Adjust the height of the line as needed
        width: 2, // Adjust the width of the line as needed
        color: Color(0xFFBB254A), // Set the color of the line to red
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
