import 'package:flutter/cupertino.dart';
import 'package:projeto_dev_disp_mob/models/coments_model.dart';
import 'package:projeto_dev_disp_mob/models/trail_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:projeto_dev_disp_mob/services/Trail/trails_repository.dart';

class TrailController extends ChangeNotifier {
  final TrailsRepository repository;
  List<Trail> trails = [];

  TrailController(this.repository) {
    load();
  }

  Future<List<Trail>> load() async {
    trails = await repository.fetchAll();
    notifyListeners();

    return trails;
  }

  Future<bool> createTrail(
      String uid,
      String username,
      String name,
      String? description,
      double distance,
      double elevation,
      double maxElevation,
      double duration,
      List<LatLng> points) async {
    final newtrail = Trail(
        id: UniqueKey().toString(),
        uid: uid,
        username: username,
        name: name,
        description: description ?? '',
        distance: distance,
        elevation: elevation,
        maxElevation: maxElevation,
        duration: duration,
        createdAt: DateTime.now(),
        points: points,
        coments: [],
        images: ['https://i.imgur.com/0AlwvzW.png']);

    final success = await repository.create(newtrail);

    if (success) {
      trails = await repository.fetchAll();
      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<Trail?> getTrail(String id) {
    for (Trail trail in trails) {
      if (trail.id == id) {
        return Future.value(trail);
      }
    }
    return Future.value(null);
  }
}
