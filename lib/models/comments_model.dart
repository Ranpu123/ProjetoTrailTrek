import 'dart:convert';

class Comment {
  final String? id;
  final String uid;
  final String username;
  final String? description;
  final double rating;
  final DateTime createdAt;

  Comment({
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
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Comment.fromMap(Map<dynamic, dynamic> map) {
    print(map);
    return Comment(
      id: map['id'],
      uid: map['uid'],
      username: map['username'],
      description: map['description'] ?? '',
      rating: map['rating'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }
  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));
}
