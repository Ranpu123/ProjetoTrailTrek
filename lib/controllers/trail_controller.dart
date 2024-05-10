import 'package:flutter/cupertino.dart';
import 'package:projeto_dev_disp_mob/models/coments_model.dart';
import 'package:projeto_dev_disp_mob/models/trail_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:projeto_dev_disp_mob/services/Trail/trails_repository.dart';

class TrailController extends ChangeNotifier {
  final TrailsRepository repository;
  List<Trail> trails = [];
  bool isLoading = true;

  TrailController(this.repository) {
    isLoading = true;
    load();
    isLoading = false;
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
      load();
      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<Trail?> getTrail(String id) async {
    final trail = await repository.getById(id);
    return trail;
  }

  Future<bool> updateTrail(
      String id,
      String uid,
      String username,
      String name,
      String? description,
      double distance,
      double elevation,
      double maxElevation,
      double duration,
      DateTime createdAt,
      List<LatLng> points,
      List<Coment> coments,
      List<String> images) async {
    final newtrail = Trail(
        id: id,
        uid: uid,
        username: username,
        name: name,
        description: description ?? '',
        distance: distance,
        elevation: elevation,
        maxElevation: maxElevation,
        duration: duration,
        createdAt: createdAt,
        points: points,
        coments: coments,
        images: images);

    final success = await repository.update(newtrail);

    if (success) {
      load();
      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }
}
