import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? uid;
  final String name;
  final int age;
  final String gender;
  final String imageUrls;
  final String bio;
  final String jobTitle;
  final List<String> interest;
  final String location;
  final List<String> likedUserIds;

  const User({
    required this.uid,
    required this.name,
    required this.age,
    required this.gender,
    required this.imageUrls,
    required this.bio,
    required this.jobTitle,
    required this.interest,
    required this.location,
    this.likedUserIds = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "age": age,
      "gender": gender,
      "imageUrls": imageUrls,
      "location": location,
      "bio": bio,
      "jobTitle": jobTitle,
      "interest": interest,
    };
  }

  User copyWith({
    String? uid,
    String? name,
    int? age,
    String? gender,
    String? imageUrls,
    String? bio,
    String? jobTitle,
    List<String>? interest,
    String? location,
    List<String>? likedUserIds,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      imageUrls: imageUrls ?? this.imageUrls,
      bio: bio ?? this.bio,
      jobTitle: jobTitle ?? this.jobTitle,
      interest: interest ?? this.interest,
      location: location ?? this.location,
      likedUserIds: likedUserIds ?? this.likedUserIds,
    );
  }

  factory User.fromFirestore(Map<String, dynamic> data) {
    final uid = data['uid'] as String?;
    final name = data['name'] as String?;
    final age = data['age'] as int?;
    final gender = data['gender'] as String?;
    final imageUrls = data['imageUrls'] as String?;
    final bio = data['bio'] as String?;
    final jobTitle = data['jobTitle'] as String?;
    final interest = (data['interest'] as List?)?.cast<String>();
    final location = data['location'] as String?;
    final likedUserIds = (data['likedUserIds'] as List?)?.cast<String>();

    return User(
      uid: uid,
      name: name ?? '',
      age: age ?? 0,
      gender: gender ?? '',
      imageUrls: imageUrls ?? '',
      bio: bio ?? '',
      jobTitle: jobTitle ?? '',
      interest: interest ?? [],
      location: location ?? '',
      likedUserIds: likedUserIds ?? [],
    );
  }

  @override
  List<Object?> get props => [
        uid,
        name,
        age,
        imageUrls,
        gender,
        location,
        bio,
        jobTitle,
        interest,
        likedUserIds,
      ];

  static User fromSnapshot(DocumentSnapshot snap) {
    User users = User(
        uid: snap['uid'],
        name: snap['name'],
        age: snap['age'],
        imageUrls: snap['imageUrls'],
        gender: snap['gender'],
        bio: snap['bio'],
        jobTitle: snap['jobTitle'],
        interest: snap['interest'],
        location: 'location');
    return users;
  }
}
