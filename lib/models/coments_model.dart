import 'dart:convert';

class Coment {
  final String? id;
  final String uid;
  final String username;
  final String? description;
  final double rating;
  final DateTime createdAt;

  Coment({
    this.id,
    required this.uid,
    required this.username,
    this.description,
    required this.rating,
    required this.createdAt,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'username': username,
      'description': description,
      'rating': rating,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Coment.fromMap(Map<dynamic, dynamic> map) {
    return Coment(
      id: map['id'],
      uid: map['uid'],
      username: map['username'],
      description: map['description'] ?? '',
      rating: map['rating'],
      createdAt: map['createdAt'] ?? 0,
    );
  }

  Coment.withId({
    required this.id,
    required this.uid,
    required this.username,
    this.description,
    required this.rating,
    required this.createdAt,
  });

  Coment copyWithId(String id) {
    return Coment.withId(
      id: id,
      uid: uid,
      username: username,
      description: description,
      rating: rating,
      createdAt: createdAt,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coment.fromJson(String source) => Coment.fromMap(json.decode(source));
}
