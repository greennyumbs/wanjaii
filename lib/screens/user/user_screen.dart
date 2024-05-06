import 'package:flutter/material.dart';
import 'package:flutter_dating_app/services/auth_service.dart';
import 'package:flutter_dating_app/services/firebase_auth_service.dart';
import 'package:flutter_dating_app/services/storage_service.dart';
import 'package:flutter_dating_app/services/user_service.dart';
import 'package:flutter_dating_app/widgets/bottom_nav_bar.dart';

// ignore: use_key_in_widget_constructors
class UserScreen extends StatefulWidget {
  static const String routeName = '/user';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => UserScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  //final _bioController = TextEditingController();
  String? _imageUrls;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final userData = await UserService().getUserData();
    //_bioController.text = userData.bio;
    _imageUrls = userData.imageUrls;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthService().logout();
              // Navigate to the login screen
            },
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(index: 3),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: _imageUrls != null
                  ? NetworkImage(_imageUrls!)
                  : AssetImage('assets/images/profile_placeholder.png')
                      as ImageProvider,
            ),
            /*  SizedBox(height: 16.0),
            TextFormField(
              controller: _bioController,
              decoration: InputDecoration(labelText: 'Bio'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Update user bio
                await UserService().updateUserBio(bio: _bioController.text);
              },
              child: Text('Update Bio'),
            ), */
            ElevatedButton(
              onPressed: () async {
                // Update user profile image
                final imagePath = await StorageService().pickImage();
                if (imagePath != null) {
                  final imageUrls =
                      await StorageService().uploadImage(imagePath);
                  await UserService().updateUserImage(imageUrls: imageUrls);
                  _imageUrls = imageUrls;
                  setState(() {});
                }
              },
              child: Text('Update Profile Image'),
            ),
          ],
        ),
      ),
    );
  }
}
