import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dating_app/screens/home/home_no_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailValue = TextEditingController();
  final passwordValue = TextEditingController();

  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFBB254A),
            ),
          );
        });
    void errorMessagePopup(String message) {
      print('Sign In button pressed');
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: const Text(
                  "ERROR",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Sk-Modernist',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                content: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 19,
                    fontFamily: 'Sk-Modernist',
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 19,
                        fontFamily: 'Sk-Modernist',
                        color: Color(0xFFBB254A),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ]);
          });
      // Navigator.pop(context);
    }

    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailValue.text.trim(),
              password: passwordValue.text.trim());

      final loggedInUser = userCredential.user;
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      print(e.code);
      if (e.code == "invalid-credential") {
        errorMessagePopup("Incorrect email or password.");
      } else {
        errorMessagePopup(e.message.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/images/logo.png')),
              const SizedBox(height: 20),
              const Text(
                "Welcome back!",
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Sk-Modernist',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter your Email and Password",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Sk-Modernist',
                  color: Color(0xFF6C6C6C),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 295,
                height: 56,
                child: TextField(
                  controller: emailValue,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      hintText: "Enter Email",
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Sk-Modernist',
                        color: Color(0xFFB3B3B3),
                      ),
                      contentPadding: const EdgeInsets.all(20.0)),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 295,
                height: 56,
                child: TextField(
                  obscureText: true,
                  controller: passwordValue,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      hintText: "Password",
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Sk-Modernist',
                        color: Color(0xFFB3B3B3),
                      ),
                      contentPadding: const EdgeInsets.all(20.0)),
                ),
              ),
              const SizedBox(height: 180),
              ElevatedButton(
                  onPressed: () {
                    signUserIn();
                  },
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
                    'Sign In',
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
    ));
  }
}
