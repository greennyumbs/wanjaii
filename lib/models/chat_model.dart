/* class Chat extends Equatable {
  final int id;
  final int userId;
  final int matchUserId;
  final List<Message> message;

  Chat(
      {required this.id,
      required this.userId,
      required this.matchUserId,
      required this.message});

  @override
  List<Object?> get props => [id, userId, matchUserId, message];
} */

import 'user.dart';

class Chat {
  final String id;
  final List<String> userIds;
  final List<User> users;
  final String matchedUserName;

  Chat({
    required this.id,
    required this.userIds,
    required this.users,
    required this.matchedUserName,
  });

  factory Chat.fromMap(Map<String, dynamic> data) {
    final users = (data['users'] as List<dynamic>)
        .map((user) => User.fromMap(user))
        .toList();

    return Chat(
      id: data['id'] ?? '',
      userIds: List<String>.from(data['userIds'] ?? []),
      users: users,
      matchedUserName: users.length > 1 ? users[1].name : '',
    );
  }

  Map<String, dynamic> toMap() {
    final userMaps = users.map((user) => user.toMap()).toList();

    return {
      'id': id,
      'userIds': userIds,
      'users': userMaps,
    };
  }
}
