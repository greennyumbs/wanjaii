import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_dating_app/services/user_service.dart';

import 'package:flutter_dating_app/services/storage_service.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = '/EditProfile';
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => EditProfileScreen(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _imageUrls;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _languageController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final userData = await UserService().getUserData();
    print(userData);
    _imageUrls = userData.imageUrls;

    setState(() {});
  }

  Future<void> _getCurrentUser() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();
        setState(() {
          _nameController.text = userData['name'] ?? '';
          _cityController.text = userData['city'] ?? '';
          _stateController.text = userData['state'] ?? '';
          _countryController.text = userData['country'] ?? '';
          _languageController.text = userData['language'] ?? '';
          _genderController.text = userData['gender'] ?? '';
          _phoneNumberController.text = userData['phoneNumber'] ?? '';
        });
      }
    } catch (error) {
      print('Error fetching current user: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          ('Edit Profile'),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Sk-Modernist',
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20), // 1 column  many form
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageUrls != null
                          ? NetworkImage(_imageUrls!)
                          : AssetImage('assets/images/profile_placeholder.png')
                              as ImageProvider,
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        // Update user profile image
                        final imagePath = await StorageService().pickImage();
                        if (imagePath != null) {
                          final imageUrls =
                              await StorageService().uploadImage(imagePath);
                          await UserService()
                              .updateUserImage(imageUrls: imageUrls);
                          _imageUrls = imageUrls;
                          setState(() {});
                        }
                      },
                      child: Text(
                        'Update Profile Image',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sk-Modernist',
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: _buildNameField(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: _buildPhoneNumberField(),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Discovery Setting',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sk-Modernist',
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: _buildCityField(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: _buildStateField(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: _buildCountryField(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: _buildLanguageField(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: _buildGenderField(),
                    ),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, send data to the backend
                      updateUserData();
                    }
                  },
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return SizedBox(
      height: 71, // Specify the height of the container
      width: 350, // Specify the width of the container
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' Name',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sk-Modernist',
              ),
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                contentPadding: EdgeInsets.all(10),
                border: InputBorder.none,
              ),
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sk-Modernist',
                  color: Colors.grey),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ' Phone Number',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sk-Modernist',
            ),
          ),
          TextFormField(
            controller: _phoneNumberController,
            decoration: InputDecoration(
              hintText: 'Enter your phone number',
              contentPadding: EdgeInsets.all(10),
              border: InputBorder.none,
            ),
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sk-Modernist',
                color: Colors.grey),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCityField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ' City',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sk-Modernist',
            ),
          ),
          TextFormField(
            controller: _cityController,
            decoration: InputDecoration(
              hintText: 'Enter your city',
              contentPadding: EdgeInsets.all(10),
              border: InputBorder.none,
            ),
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sk-Modernist',
                color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildStateField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ' State',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sk-Modernist',
            ),
          ),
          TextFormField(
            controller: _stateController,
            decoration: InputDecoration(
              hintText: 'Enter your state',
              contentPadding: EdgeInsets.all(10),
              border: InputBorder.none,
            ),
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sk-Modernist',
                color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCountryField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ' Country',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sk-Modernist',
            ),
          ),
          TextFormField(
            controller: _countryController,
            decoration: InputDecoration(
              hintText: 'Enter your country',
              contentPadding: EdgeInsets.all(10),
              border: InputBorder.none,
            ),
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sk-Modernist',
                color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ' Preferred Languages',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sk-Modernist',
            ),
          ),
          TextFormField(
            controller: _languageController,
            decoration: InputDecoration(
              hintText: 'Enter your Preferred Languages',
              contentPadding: EdgeInsets.all(10),
              border: InputBorder.none,
            ),
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sk-Modernist',
                color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ' Show Me',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sk-Modernist',
            ),
          ),
          TextFormField(
            controller: _genderController,
            decoration: InputDecoration(
              hintText: 'Enter you gender',
              contentPadding: EdgeInsets.all(10),
              border: InputBorder.none,
            ),
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sk-Modernist',
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void updateUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .update({
          'name': _nameController.text,
          'city': _cityController.text,
          'state': _stateController.text,
          'country': _countryController.text,
          'language': _languageController.text,
          'gender': _genderController.text,
          'phoneNumber': _phoneNumberController.text,
        });
        // Data updated successfully
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('User data updated successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      // Handle errors
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to update user data: $error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}



//   // Function to send form data to the backend
//   void sendDataToBackend() async {
//     // Get form data from text controllers
//     String name = _nameController.text;
//     String dateOfBirth = _dateOfBirthController.text;
//     String phoneNumber = _phoneNumberController.text;
//     String email = _emailController.text;
//     String location = _locationController.text;
//     String language = _languageController.text;
//     String gender = _genderController.text;

//     // Create a map containing the form data
//     Map<String, String> formData = {
//       'name': name,
//       'dateOfBirth': dateOfBirth,
//       'phoneNumber': phoneNumber,
//       'email': email,
//       'location': location,
//       'language': language,
//       'gender': gender,
//     };
//     String jsonData = jsonEncode(formData);
//     print(jsonData);

//     // Backend API URL
//     String backendUrl = 'http://192.168.1.85:3000/api/users';

//     try {
//       print(jsonData);
//       // Send POST request to the backend
//       final res = await http.post(Uri.parse(backendUrl),
//           headers: {'Content-Type': 'application/json'}, body: jsonData);

//       // Check if request was successful
//       if (res.statusCode == 201) {
//         print("success");
//       } else {
//         print("fail");
//       }
//     } catch (error) {
//       // Handle error
//       print('Error sending data to backend: $error');
//       // You can add further error handling logic here, such as showing an error message to the user.
//     }
//   }
// }