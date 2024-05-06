import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:insta_image_viewer/insta_image_viewer.dart';
=======
<<<<<<< HEAD
import 'package:insta_image_viewer/insta_image_viewer.dart';
=======
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
>>>>>>> Stashed changes

class ChatBubbles extends StatelessWidget {
  final Timestamp timestamp;
  final String message;
  final bool isCurrentUser;
<<<<<<< Updated upstream
  final String type;
  final String imageUrls;
=======
<<<<<<< HEAD
  final String type;
  final String imageUrls;
=======
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
>>>>>>> Stashed changes

  const ChatBubbles(
      {super.key,
      required this.message,
      required this.isCurrentUser,
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
>>>>>>> Stashed changes
      required this.timestamp,
      required this.type,
      required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    if (type == "text") {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isCurrentUser
                  ? const Color(0xFFF3F3F3)
                  : const Color(0xFFFFDADF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isCurrentUser ? 16 : 0),
                topRight: Radius.circular(isCurrentUser ? 0 : 16),
                bottomLeft: const Radius.circular(16),
                bottomRight: const Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Sk-Modernist',
                fontWeight: FontWeight.w700,
                color: Color(0xFFBB254A),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: isCurrentUser
                  ? const Color(0xFFF3F3F3)
                  : const Color(0xFFFFDADF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isCurrentUser ? 16 : 0),
                topRight: Radius.circular(isCurrentUser ? 0 : 16),
                bottomLeft: const Radius.circular(16),
                bottomRight: const Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
            child: InstaImageViewer(
              child: Image(
                image: NetworkImage(imageUrls),
                // Adjust the fit as per your requirement
              ),
            ),
          ),
        ],
      );
    }
<<<<<<< Updated upstream
=======
=======
      required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isCurrentUser
                ? const Color(0xFFF3F3F3)
                : const Color(0xFFFFDADF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isCurrentUser ? 16 : 0),
              topRight: Radius.circular(isCurrentUser ? 0 : 16),
              bottomLeft: const Radius.circular(16),
              bottomRight: const Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Sk-Modernist',
              fontWeight: FontWeight.w700,
              color: Color(0xFFBB254A),
            ),
          ),
        ),
      ],
    );
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
>>>>>>> Stashed changes
  }
}
