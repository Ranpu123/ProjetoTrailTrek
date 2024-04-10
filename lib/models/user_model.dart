import 'dart:convert';

class User{
  String? uid;
  final String username;
  final String email;
  final String password;
  final DateTime createdAt;

  User({
    this.uid,
    required this.username,
    required this.email,
    required this.password,
    required this.createdAt,
  });

  Map<String, dynamic> toMap(){
    return{
      'uid': uid,
      'username': username,
      'email': email,
      'password': password,
      'createdAt': createdAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  bool validateEmail(String email){
    if (email.isNotEmpty){
      return RegExp(r'/^[a-zA-Z0-9. _%+-]+@[a-zA-Z0-9. -]+\\. [a-zA-Z]{2,}$/').hasMatch(email);
    }
    return false;
  }

  bool validatePassword(String password1, String password2){
    if(password1.length < 8){
      return false;
    }
    if (password1.isNotEmpty && password2.isNotEmpty){
      return password1 == password2 ? true : false;
    }
    return false;
  }
}