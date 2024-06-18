import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:projeto_dev_disp_mob/models/coments_model.dart';

class Trail {
  String? id;
  final String uid;
  final String username;
  final String name;
  String description;
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
      required this.description,
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
      'createdAt': createdAt.millisecondsSinceEpoch,
      'points': points
          .map((point) =>
              {'latitude': point.latitude, 'longitude': point.longitude})
          .toList(),
      'coments': coments.map((coment) => {coment.id: coment.toMap()}).toList(),
      /*'coments': Map.fromIterable(coments,
          key: (comment) => comment.id,
          value: (comment) => (comment as Coment).toMap()),*/
      'images': images.map((image) => {'url': image}),
    };
  }

  factory Trail.fromMap(Map<dynamic, dynamic> map) {
    final List<Coment> comments = [];
    /*if (map['coments'] != null) {
      final comentsMap = map['coments'] as Map<dynamic, dynamic>;
      comentsMap.forEach((key, value) {
        comments.add(Coment.fromMap(value as Map<dynamic, dynamic>));
      });
    }*/
    if (map['coments'] != null && map['coments'] is Map) {
      final comentsMap = map['coments'] as Map<dynamic, dynamic>;
      comentsMap.forEach((key, value) {
        if (value is Map) {
          comments.add(Coment.fromMap(value));
        }
      });
    }

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
        points: (map['points'] != null && (map['points'] as List).isNotEmpty)
            ? (map['points'] as List<dynamic>)
                .map((point) => LatLng(point['latitude'], point['longitude']))
                .toList()
            : [],
        coments: comments,
        images: (map['images'] != null && (map['images'] as List).isNotEmpty)
            ? (map['images'] as List<dynamic>)
                .map((image) => image['url'] as String)
                .toList()
            : []);
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

  LatLng averageLatLng() {
    if (points.isEmpty) {
      return const LatLng(0, 0);
    }

    double sumLat = 0.0;
    double sumLng = 0.0;

    for (LatLng point in points) {
      sumLat += point.latitude;
      sumLng += point.longitude;
    }

    double avgLat = sumLat / points.length;
    double avgLng = sumLng / points.length;

    return LatLng(avgLat, avgLng);
  }

  String getHoursAndMinutes() {
    int hours = duration ~/ 60;
    int remainingMinutes = (duration % 60).round();

    String hoursAndMinutes =
        '$hours h ${remainingMinutes.toString().padLeft(2, '0')} m';

    return hoursAndMinutes;
  }
}
