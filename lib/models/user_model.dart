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
  final List<String> interests;
  final String city;
  final String country;
  final String state;
  final String profileAbout;
  final List<String> likedUsers;

  const User({
    required this.uid,
    required this.name,
    required this.age,
    required this.gender,
    required this.imageUrls,
    required this.bio,
    required this.jobTitle,
    required this.interests,
    required this.city,
    required this.country,
    required this.state,
    required this.profileAbout,
    this.likedUsers = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "age": age,
      "gender": gender,
      "imageUrls": imageUrls,
      "city": city,
      "country": country,
      "state": state,
      "profileAbout": profileAbout,
      "bio": bio,
      "jobTitle": jobTitle,
      "interests": interests,
      "likedUsers": likedUsers,
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
    List<String>? interests,
    String? city,
    String? country,
    String? state,
    String? profileAbout,
    List<String>? likedUsers,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      imageUrls: imageUrls ?? this.imageUrls,
      bio: bio ?? this.bio,
      jobTitle: jobTitle ?? this.jobTitle,
      interests: interests ?? this.interests,
      city: city ?? this.city,
      country: country ?? this.country,
      state: state ?? this.state,
      profileAbout: profileAbout ?? this.profileAbout,
      likedUsers: likedUsers ?? this.likedUsers,
    );
  }

  factory User.fromFirestore(Map<String, dynamic> data) {
    return User(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      age: data['age'] ?? 0,
      gender: data['gender'] ?? '',
      imageUrls: data['imageUrls'] ?? '',
      bio: data['bio'] ?? '',
      jobTitle: data['jobTitle'] ?? '',
      interests: List<String>.from(data['interests'] ?? []),
      city: data['city'] ?? '',
      country: data['country'] ?? '',
      state: data['state'] ?? '',
      profileAbout: data['profileAbout'] ?? '',
      likedUsers: List<String>.from(data['likedUsers'] ?? []),
    );
  }

  @override
  List<Object?> get props => [
        uid,
        name,
        age,
        imageUrls,
        gender,
        city,
        country,
        state,
        profileAbout,
        bio,
        jobTitle,
        interests,
        likedUsers,
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
      likedUsers: snap['likedUsers'],
      interests: snap['interests'],
      city: snap['city'],
      country: snap['country'],
      state: snap['state'],
      profileAbout: snap['profileAbout'],
    );
    return users;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      imageUrls: json['imageUrls'] ?? '',
      bio: json['bio'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
      interests: List<String>.from(json['interests'] ?? []),
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      state: json['state'] ?? '',
      profileAbout: json['profileAbout'] ?? '',
      likedUsers: List<String>.from(json['likedUsers'] ?? []),
    );
  }
}
