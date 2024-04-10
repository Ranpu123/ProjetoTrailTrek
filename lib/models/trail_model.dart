import 'dart:convert';
import 'package:latlong2/latlong.dart';

class Trail{
  String? id;
  final String uid;
  String? description;
  final double distance;
  final double elevation;
  final double maxElevation;
  final double duration;
  final DateTime createdAt;
  final List<LatLng> points;

  Trail({
    this.id,
    required this.uid,
    this.description,
    required this.distance,
    required this.elevation,
    required this.maxElevation,
    required this.duration,
    required this.createdAt,
    required this.points,
  });

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'uid': uid,
      'description': description,
      'distance': distance,
      'elevation': elevation,
      'maxElevation': maxElevation,
      'duration': duration,
      'createdAt': createdAt,
      'points': points.map((point) => {'latitude': point.latitude, 'longitude': point.longitude}).toList()
    };
  }

  factory Trail.fromMap(Map<String, dynamic> map) {
    return Trail(
      id: map['id'],
      uid: map['uid'],
      description: map['description'] ?? '',
      distance: map['distance'],
      elevation: map['elevation'],
      maxElevation: map['maxElevation'],
      duration: map['duration'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      points: (map['points'] as List<dynamic>).map((point) => LatLng(point['latitude'], point['longitude'])).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Trail.fromJson(String source) => Trail.fromMap(json.decode(source));
}