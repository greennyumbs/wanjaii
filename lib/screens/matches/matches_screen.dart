import 'package:flutter_dating_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dating_app/models/user_model.dart';
import 'package:flutter_dating_app/widgets/bottom_nav_bar.dart';

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
    _fetchData(); // Call the fetch function in initState
  }

  /* Future<List<User>> fetchData() async {
    final url = 'http://localhost:3000/users';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
      print('user data: $userData');

      user = userData
          .map((data) => User.fromSnapshot(data))
          .toList(); // Assuming User model has a fromJson constructor
    } else {
      print('Failed to fetch user data: ${response.statusCode}');
    }
    return user;
  } */

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

  @override
  Widget build(BuildContext context) {
    final user = _users;
    /* if (user.isNotEmpty) {
      // Access user.first and other elements here (safe)
      final firstUser = user.first;
      print('First User Name: ${firstUser.name}');
    } else {
      // Handle the case where there are no users
      print('No users found in the list');
    } */
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 8, bottom: 2, right: 175),
          child: Text(
            'Matches',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              // Handle help button press
            },
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(index: 1),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 11),
              Text(
                "This is a list of people who have liked you and your matches.",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 19),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 6, bottom: 7),
                    child: SizedBox(
                      width: 121,
                      child: Divider(
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                  Text(
                    "Today",
                    style: TextStyle(fontSize: 16),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6, bottom: 7),
                    child: SizedBox(
                      width: 121,
                      child: Divider(
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 9),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(user.first
                              .imageUrls), // Using the first user's first image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.first.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Age: ${user.first.name}',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Location: New York',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Add functionality for button
                            },
                            child: Text('View Profile'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(user.first
                              .imageUrls), // Using the second user's first image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.first.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Age: ${user.first.age}',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Location: Los Angeles',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              // Add functionality for button
                            },
                            child: Text('View Profile'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 6, bottom: 7),
                    child: SizedBox(
                      width: 110,
                      child: Divider(
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                  Text(
                    "Yesterday",
                    style: TextStyle(fontSize: 16),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6, bottom: 7),
                    child: SizedBox(
                      width: 110,
                      child: Divider(
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 9),
              // Vertical box for matches
            ],
          ),
        ),
      ),
    );
  }
}
