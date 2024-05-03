import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter_dating_app/screens/home/match.dart';
import 'package:flutter_dating_app/services/firestore_service.dart';
import 'package:flutter_dating_app/widgets/app_bar.dart';
import 'package:flutter_dating_app/widgets/bottom_nav_bar.dart';
import 'package:flutter_dating_app/widgets/choice_button.dart';
import 'package:flutter_dating_app/widgets/user_card.dart';
import 'package:http/http.dart' as http;

import '../../models/user_model.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  const HomeScreen({
    Key? key,
  }) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => HomeScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserCard _userCard;
  final firestoreService = FirestoreService();
  List<User> _users = [];
  List<User> _swipedUsers = [];
  List<User> _likedUsers = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
    //_fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      final url = 'http://localhost:3000/users?uid=$uid';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        print('user data: $userData');
        // Update the UI with the fetched user data
        setState(() {
          _users = userData;
        });
      } else {
        print('Failed to fetch user data: ${response.statusCode}');
      }
    }
  }

  Future<void> _fetchData() async {
    try {
      final users = await firestoreService.fetchUsers();
      final uid = FirebaseAuth.instance.currentUser?.uid;
      setState(() {
        _users = users;
      });
      print('login user uid: $uid');
      print('Fetching user: $users');
    } catch (error) {
      print('Error fetching users: $error');
    }
  }

  void _swipeLeft() {
    setState(() {
      if (_users.isNotEmpty) {
        _swipedUsers.add(_users.removeAt(0));
      }
    });
    print('Swiped left');
  }

  void _swipeRight() {
    if (_users.isNotEmpty) {
      final currentUser = _users.removeAt(0);
      _swipedUsers.add(currentUser);
      print('Swiped right');
      _checkMatch(currentUser);
    }
  }

  void _checkMatch(User currentUser) {
    // Check if the current user is liked by any other user
    for (var likedUser in _swipedUsers) {
      print('liked user: $likedUser \n current user: $currentUser');
      if (likedUser.uid == currentUser.uid) {
        _showMatchScreen(currentUser, likedUser);
        break;
      }
    }
  }

  void _showMatchScreen(User currentUser, User matchedUser) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MatchScreen(
          currentUser: currentUser,
          matchedUser: matchedUser,
          swipedUsers: _swipedUsers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers =
        _users.where((user) => !_swipedUsers.contains(user)).toList();
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Discover',
        location: '(Location)',
      ),
      bottomNavigationBar: const BottomNavBar(index: 0),
      body: _users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                filteredUsers.isNotEmpty
                    ? Draggable(
                        child: _userCard = UserCard(user: filteredUsers[0]),
                        feedback: UserCard(user: filteredUsers[0]),
                        childWhenDragging: filteredUsers.length > 1
                            ? UserCard(user: filteredUsers[1])
                            : Container(),
                        onDragEnd: (drag) {
                          if (drag.velocity.pixelsPerSecond.dx < 0) {
                            _swipeLeft();
                          } else {
                            _swipeRight();
                          }
                        },
                      )
                    : const Center(
                        child: Text('No more users available.'),
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: _swipeLeft,
                        child: const ChoiceButton(
                          width: 80,
                          height: 80,
                          size: 30,
                          hasGradient: false,
                          color: Color.fromRGBO(242, 113, 33, 1),
                          icon: Icons.clear_rounded,
                        ),
                      ),
                      InkWell(
                        onTap: _swipeRight,
                        child: const ChoiceButton(
                          width: 105,
                          height: 105,
                          size: 54,
                          hasGradient: true,
                          color: Colors.white,
                          icon: Icons.favorite,
                        ),
                      ),
                      const ChoiceButton(
                        width: 80,
                        height: 80,
                        size: 30,
                        hasGradient: false,
                        color: Color.fromRGBO(138, 35, 135, 1),
                        icon: Icons.star,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
