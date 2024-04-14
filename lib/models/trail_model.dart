import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:projeto_dev_disp_mob/models/coments_model.dart';

class Trail {
  final String? id;
  final String uid;
  final String username;
  String? description;
  final double distance;
  final double elevation;
  final double maxElevation;
  final double duration;
  final DateTime createdAt;
  final List<LatLng> points;
  List<Coment> coments;

  Trail({
    this.id,
    required this.uid,
    required this.username,
    this.description,
    required this.distance,
    required this.elevation,
    required this.maxElevation,
    required this.duration,
    required this.createdAt,
    required this.points,
    required this.coments,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'username': username,
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
      'coments': coments.map((coment) => coment.toMap()).toList()
    };
  }

  factory Trail.fromMap(Map<String, dynamic> map) {
    return Trail(
      id: map['id'],
      uid: map['uid'],
      username: map['username'],
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
    );
  }

  String toJson() => json.encode(toMap());

  factory Trail.fromJson(String source) => Trail.fromMap(json.decode(source));
}
