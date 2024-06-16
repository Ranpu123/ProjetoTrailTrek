import 'dart:convert';

class User {
  String? uid;
  final String username;
  final String email;
  final String password;
  final DateTime createdAt;
  String? profileImage;

  User({
    this.uid,
    required this.username,
    required this.email,
    required this.password,
    required this.createdAt,
    this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'password': '*',
      'createdAt': createdAt.millisecondsSinceEpoch,
      'profileImage': profileImage != null ? {'url': profileImage} : null,
    };
  }

  factory User.fromMap(Map<dynamic, dynamic> map) {
    return User(
        uid: map['uid'],
        username: map['username'],
        email: map['email'],
        password: map['password'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
        profileImage:
            map['profileImage'] != null ? map['profileImage']['url'] : null);
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  static bool validateEmail(String email) {
    if (email.isNotEmpty) {
      return RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
    }
    return false;
  }

  static bool validateUsername(String username) {
    if (username.isNotEmpty) {
      return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(username);
    }
    return false;
  }

  static bool validateNewPassword(String password1, String password2) {
    if (password1.length < 8) {
      return false;
    }
    if (password1.isNotEmpty && password2.isNotEmpty) {
      return password1 == password2 ? true : false;
    }
    return false;
  }
}
