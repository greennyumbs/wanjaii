import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_dating_app/models/user_model.dart';
import 'package:flutter_dating_app/services/firestore_service.dart';
import 'package:flutter_dating_app/widgets/bottom_nav_bar.dart';

import 'package:http/http.dart' as http;

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

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
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

  Widget _buildUserCard(User user) {
    return Card(
      //margin: EdgeInsets.all(10),
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
                                onPressed: () {},
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
                  Icons.swap_vert,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(index: 1),
      body: SingleChildScrollView(
        child: Container(
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
          ),
        ),
      ),
    );
  }
}
