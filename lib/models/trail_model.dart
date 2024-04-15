import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:projeto_dev_disp_mob/models/coments_model.dart';

class Trail {
  final String? id;
  final String uid;
  final String username;
  final String name;
  String? description;
  final double distance;
  final double elevation;
  final double maxElevation;
  final double duration;
  final DateTime createdAt;
  final List<LatLng> points;
  List<Coment> coments;
  List<String> images;

  Trail(
      {this.id,
      required this.uid,
      required this.username,
      required this.name,
      this.description,
      required this.distance,
      required this.elevation,
      required this.maxElevation,
      required this.duration,
      required this.createdAt,
      required this.points,
      required this.coments,
      required this.images});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'username': username,
      'name': name,
      'description': description,
      'distance': distance,
      'elevation': elevation,
      'maxElevation': maxElevation,
      'duration': duration,
      'createdAt': createdAt,
      'points': points
          .map((point) =>
              {'latitude': point.latitude, 'longitude': point.longitude})
          .toList(),
      'coments': coments.map((coment) => coment.toMap()).toList(),
      'images': images.map((image) => {'url': image}),
    };
  }

  factory Trail.fromMap(Map<String, dynamic> map) {
    return Trail(
        id: map['id'],
        uid: map['uid'],
        username: map['username'],
        name: map['name'],
        description: map['description'] ?? '',
        distance: map['distance'],
        elevation: map['elevation'],
        maxElevation: map['maxElevation'],
        duration: map['duration'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
        points: (map['points'] as List<dynamic>)
            .map((point) => LatLng(point['latitude'], point['longitude']))
            .toList(),
        coments: (map['coments'] as List<dynamic>)
            .map((coment) => Coment.fromMap(coment))
            .toList(),
        images: (map['images'] as List<dynamic>)
            .map((image) => image['url'] as String)
            .toList());
  }

  String toJson() => json.encode(toMap());

  factory Trail.fromJson(String source) => Trail.fromMap(json.decode(source));

  double trailRating() {
    double meanRating = 0.0;
    for (Coment coment in coments) {
      meanRating += coment.rating;
    }

    return coments.isNotEmpty ? meanRating / coments.length : meanRating;
  }
}
