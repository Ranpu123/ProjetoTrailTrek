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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'username': username,
      'description': description,
      'rating': rating,
      'createdAt': createdAt,
    };
  }

  factory Coment.fromMap(Map<String, dynamic> map) {
    return Coment(
      id: map['id'],
      uid: map['uid'],
      username: map['username'],
      description: map['description'] ?? '',
      rating: map['rating'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }
  String toJson() => json.encode(toMap());

  factory Coment.fromJson(String source) => Coment.fromMap(json.decode(source));
}
