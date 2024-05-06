import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
<<<<<<< Updated upstream
  final String type;
  final String message;
  final String imageUrls;
=======
<<<<<<< HEAD
  final String type;
  final String message;
  final String imageUrls;
=======
  final String message;
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
>>>>>>> Stashed changes
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
<<<<<<< Updated upstream
    required this.type,
    required this.message,
    required this.imageUrls,
=======
<<<<<<< HEAD
    required this.type,
    required this.message,
    required this.imageUrls,
=======
    required this.message,
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
>>>>>>> Stashed changes
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
<<<<<<< Updated upstream
      'type': type,
      'message': message,
      'imageUrls': imageUrls,
=======
<<<<<<< HEAD
      'type': type,
      'message': message,
      'imageUrls': imageUrls,
=======
      'message': message,
>>>>>>> 080bdedd2e19e3dfc3647eb13ff7832da745d7ba
>>>>>>> Stashed changes
      'timestamp': timestamp,
    };
  }
}
