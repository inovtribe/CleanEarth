import 'package:flutter/foundation.dart';

@immutable
class User {
  final String uid;
  final String fullName;
  final String email;
  final String photoUrl;

  User({
    @required this.uid,
    this.fullName,
    this.email,
    this.photoUrl,
  });

  User.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        fullName = data['fullName'],
        email = data['email'],
        photoUrl = data['photoUrl'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }
}
