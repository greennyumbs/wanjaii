import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newwanjaii/homepage.dart';
import 'package:newwanjaii/user_verification.dart';

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
            child: CircularProgressIndicator(),
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailValue.text.trim(), password: passwordValue.text.trim());
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserVerification()),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      print(e.code);
      if (e.code == "invalid-credential") {
        errorMessagePopup("Incorrect email or password.");
      } else {
        errorMessagePopup(e.message.toString());
      }
      // if (e.code == 'user-not-found') {
      //   errorMessagePopup("user-not-found");
      //   print('No user found for that email.');
      // } else if (e.code == 'wrong-password') {
      //   errorMessagePopup("wrong-password");
      //   print('Wrong password provided for that user.');
      // } else {
      //   print('Sign in failed due to an error: ${e.code}');
      //   // Handle other errors (e.g., network issues) with a generic message
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(image: AssetImage('assets/logo.png')),
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
          const SizedBox(height: 100),
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
                    borderRadius:
                        BorderRadius.circular(15.0), // Set border radius here
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
    ));
  }

  // Future<void> loginUser(String email, String password) async {
  //   try {
  //     final response = await http.post(
  //       // Uri.parse('http://localhost:3000/register'),
  //       Uri.parse('http://localhost:3000/login'),

  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{
  //         'email': email,
  //         'password': password, // Consider hashing password before sending
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       // Registration successful
  //       // Handle success (e.g., navigate to login screen)
  //       Navigator.push(
  //         context, // Replace with context from your widget build method
  //         MaterialPageRoute(builder: (context) => const homepage()),
  //       );
  //       print('Login successful'); // Placeholder for now
  //     } else {
  //       // Registration failed
  //       // Handle error (e.g., display error message to user)
  //       print('Login failed: ${response.statusCode}'); // Placeholder for now
  //     }
  //   } catch (error) {
  //     // Handle network errors or other exceptions
  //     print('Error loggin in: $error'); // Placeholder for now
  //   }
  // }
}
