<<<<<<< Updated upstream
=======
<<<<<<< HEAD
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_dating_app/models/user_model.dart';
import 'package:flutter_dating_app/screens/home/match.dart';
<<<<<<< Updated upstream
=======
=======
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_dating_app/models/user_model.dart';
import 'package:flutter_dating_app/services/firestore_service.dart';
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
>>>>>>> Stashed changes
import 'package:flutter_dating_app/widgets/bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
<<<<<<< Updated upstream
=======

import 'package:http/http.dart' as http;
>>>>>>> Stashed changes

class MatchesScreen extends StatefulWidget {
  static const String routeName = '/Matches';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => MatchesScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  final firestoreService = FirestoreService();
  List<User> _users = [];
  User? _currentUser;
  List<User> _swipedUsers = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
<<<<<<< HEAD
      final users = await firestoreService.fetchUsers();
      final uid = FirebaseAuth.instance.currentUser?.uid;
      setState(() {
        _users = users
            .where((user) => user.uid != uid && user.likedUsers.contains(uid))
            .toList();
        _currentUser = users.firstWhere((user) => user.uid == uid);
      });
      print('login user uid: $uid');
      print('Fetching user: $_users');
<<<<<<< Updated upstream
=======
=======
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      final response =
          await http.get(Uri.parse('http://192.168.1.39:3000/users'));
      if (response.statusCode == 200) {
        final usersJson = json.decode(response.body);
        setState(() {
          _users = usersJson
              .map<User>((userJson) => User.fromJson(userJson))
              .where((user) =>
                  user.uid != currentUserId &&
                  user.likedUsers.contains(currentUserId))
              .toList();
        });
      } else {
        print('Failed to fetch users: ${response.statusCode}');
      }
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
>>>>>>> Stashed changes
    } catch (error) {
      print('Error fetching users: $error');
    }
  }

  void _sortData() {
    setState(() {
      _users = _users.reversed.toList();
    });
  }

  void _removeUser(User user) {
    setState(() {
      _users.remove(user);
    });
  }

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
>>>>>>> Stashed changes
  void _onKeepSwiping(List<User> swipedUsers) {
    setState(() {
      _swipedUsers = swipedUsers;
      _users.removeWhere((user) => swipedUsers.contains(user));
    });
  }

  Future<void> _matchUsers(User swipedUser) async {
    if (_users.isNotEmpty) {
      try {
        final response = await http
            .get(Uri.parse('http://192.168.1.39:3000/users/${swipedUser.uid}'));
        if (response.statusCode == 200) {
          final updatedSwipedUser = User.fromJson(jsonDecode(response.body));
          print('match: $updatedSwipedUser');
          print('current user: $_currentUser');
          if (updatedSwipedUser.likedUsers.contains(_currentUser!.uid)) {
            // Both users have liked each other, show the MatchScreen and update Firestore
            await firestoreService.updateLikedUsers(
                _currentUser!, updatedSwipedUser);
            await FirebaseFirestore.instance.collection('matches').add({
              'user1': _currentUser!.uid,
              'user2': updatedSwipedUser.uid,
            });
            setState(() {
              _users.remove(swipedUser);
              _users.remove(updatedSwipedUser);
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MatchScreen(
                  currentUser: _currentUser!,
                  matchedUser: updatedSwipedUser,
                  swipedUsers: _swipedUsers,
                  onKeepSwiping: _onKeepSwiping,
                ),
              ),
            );
          } else {
            setState(() {
              _users.remove(swipedUser);
            });
            print(
                'swiped user:${swipedUser.uid}, current user:${_currentUser!.uid}');
            print('Swiped right');
          }
        } else {
          print('Failed to fetch updated swiped user: ${response.statusCode}');
        }
      } catch (error) {
        print('Error matching users: $error');
      }
    }
  }

  Widget _buildUserCard(User user) {
    return Card(
      margin: EdgeInsets.all(10),
<<<<<<< Updated upstream
=======
=======
  Widget _buildUserCard(User user) {
    return Card(
      //margin: EdgeInsets.all(10),
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
>>>>>>> Stashed changes
      elevation: 2,
      child: SizedBox(
        height: 200,
        width: 80,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(user.imageUrls),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 2,
              left: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.name}, ${user.age}',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Sk-Modernist',
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: GestureDetector(
                          onTap: () => _removeUser(user),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                              child: Container(
                                height: 40,
                                width: 40,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: Container(
                              height: 40,
                              width: 40,
                              child: IconButton(
                                icon: Icon(Icons.favorite),
                                color: Colors.white,
<<<<<<< Updated upstream
                                onPressed: () {
                                  _matchUsers(user);
                                },
=======
<<<<<<< HEAD
                                onPressed: () {
                                  _matchUsers(user);
                                },
=======
                                onPressed: () {},
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
>>>>>>> Stashed changes
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList() {
    if (_users.isNotEmpty) {
      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: _users.length,
        itemBuilder: (context, index) {
          return _buildUserCard(_users[index]);
        },
      );
    } else {
      return Center(
        child: Text('No matches found.'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Text('Matches',
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
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
>>>>>>> Stashed changes
                  Icons.sort,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                onPressed: _sortData,
<<<<<<< Updated upstream
=======
=======
                  Icons.swap_vert,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                onPressed: () {},
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
>>>>>>> Stashed changes
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(index: 1),
      body: SingleChildScrollView(
        child: Container(
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
>>>>>>> Stashed changes
          padding: EdgeInsets.fromLTRB(35, 0, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "This is a list of people who have liked you and your matches.",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Sk-Modernist',
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
              SizedBox(height: 20),
              _buildUserList(),
            ],
=======
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "This is a list of people who have liked you and your matches.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Sk-Modernist',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      )),
                  SizedBox(height: 20),
                  _buildUserList(),
                ],
              ),
            ),
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
          ),
        ),
      ),
    );
  }
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> updateLikedUsers(User currentUser, User matchedUser) async {
    try {
      // Update likedUsers of the current user
      await _db.collection('users').doc(currentUser.uid).update({
        'likedUsers': FieldValue.arrayUnion([matchedUser.uid])
      });

      // Update likedUsers of the matched user
      await _db.collection('users').doc(matchedUser.uid).update({
        'likedUsers': FieldValue.arrayUnion([currentUser.uid])
      });
    } catch (error) {
      print('Error updating likedUsers: $error');
      throw error;
    }
  }

  Future<List<User>> fetchUsers() async {
    try {
      final usersSnapshot = await _db.collection('users').get();
      return usersSnapshot.docs
          .map((doc) => User.fromFirestore(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (error) {
      print('Error fetching users: $error');
      throw error;
    }
  }

  Future<User> fetchUser(String? uid) async {
    try {
      final userSnapshot = await _db.collection('users').doc(uid).get();
      return User.fromFirestore(userSnapshot.data() as Map<String, dynamic>);
    } catch (error) {
      print('Error fetching user: $error');
      throw error;
    }
  }
}
