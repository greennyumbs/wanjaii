import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dating_app/screens/home/home_no_bloc.dart';

import 'package:flutter_dating_app/screens/onboarding/widgets/custom_image_container.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSetupScreen extends StatefulWidget {
  final TabController tabController;

  const ProfileSetupScreen({
    required this.tabController,
  });

  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  String _firstName = '';
  String _lastName = '';
  DateTime _selectedDate = DateTime.now();
  String? dropdownValue;
  File? _imageFile;

  // Function to show the date picker modal
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  String get fullName => '$_firstName $_lastName';
  int get age => DateTime.now().year - _selectedDate.year;

  Future<void> _uploadData() async {
    if (_imageFile == null || _firstName.isEmpty || _lastName.isEmpty) {
      return; // Show error message if data is missing
    }

    final storageRef =
        FirebaseStorage.instance.ref().child('user_images/$_imageFile!.path');
    await storageRef.putFile(_imageFile!);
    final imageUrls = await storageRef.getDownloadURL();

    final user = FirebaseAuth.instance.currentUser;
    final userData = {
      'name': fullName,
      'age': age,
      'imageUrls': imageUrls,
      'email': user?.email,
    };
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .update(userData);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: AppBar(
            leading: Container(
              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Color(0xFFE94057),
                onPressed: () {
                  widget.tabController
                      .animateTo(widget.tabController.index - 1);
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  widget.tabController
                      .animateTo(widget.tabController.index + 1);
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: Color(0xFFE94057),
                    fontSize: 18,
                    fontFamily: 'Sk-Modernist',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                width: 295,
                child: Text(
                  'Profile details',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 34,
                    fontFamily: 'Sk-Modernist',
                    fontWeight: FontWeight.w700,
                    height: 0.04,
                  ),
                ),
              ),
              const SizedBox(height: 80.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageContainer(
                    imageUrls: _imageFile?.path,
                    onPickImage: _pickImage,
                  ),

                  SizedBox(height: 60.0),
                  // First Name
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _firstName = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      labelStyle: TextStyle(
                        color: Colors.black45,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: Colors.black45)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  // Last Name
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _lastName = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      labelStyle: TextStyle(
                        color: Colors.black45,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: Colors.black45)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.light(
                                primary: const Color(
                                    0xFFBB254A), // Change the primary color as needed
                                onPrimary: Colors.white,
                              ),
                              buttonTheme: ButtonThemeData(
                                textTheme: ButtonTextTheme.primary,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null && picked != _selectedDate) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Color(0xFFf8e9ed),
                          filled: true,
                          prefixIcon: Icon(Icons.calendar_today),
                          prefixIconColor: Color(0xFFBB254A),
                          labelText: 'Choose birthday date',
                          labelStyle: TextStyle(
                            color: Color(0xFFBB254A),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                        controller: TextEditingController(
                          text:
                              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        ),
                        style: TextStyle(
                          color: Color(0xFFBB254A),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Sk-Modernist',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 110.0),
              ElevatedButton(
                  onPressed: _uploadData,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFBB254A)), // Change button color
                    minimumSize: MaterialStateProperty.all<Size>(
                        const Size(295, 56)), // Set button width and height
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15.0), // Set border radius here
                      ),
                    ),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Sk-Modernist',
                      color: Color(0xFFFFFFFF),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
