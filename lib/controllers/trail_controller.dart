import 'dart:async';
import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:projeto_dev_disp_mob/models/coments_model.dart';
import 'package:projeto_dev_disp_mob/models/trail_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:projeto_dev_disp_mob/services/Trail/trails_repository.dart';
import 'package:image_picker/image_picker.dart';

class TrailController extends ChangeNotifier {
  final TrailsRepository repository;
  List<Trail> trails = [];
  bool isLoading = true;
  int loadCalls = 0;

  late StreamSubscription<DatabaseEvent> onchange;
  late StreamSubscription<DatabaseEvent> onadd;
  late StreamSubscription<DatabaseEvent> ondelete;

  TrailController(this.repository) {
    isLoading = true;
    setupListeners();
    load().then((value) => isLoading = false);
  }

  Future<List<Trail>> load() async {
    trails = await repository.fetchAll();
    loadCalls++;
    print("Load Calls: $loadCalls");
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
      List<LatLng> points,
      List<XFile> images) async {
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
        images: []);

    final success = await repository.create(newtrail, images);

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

  Future<bool> deleteTrail(String id) async {
    Trail? trail = await repository.getById(id);
    if (trail != null) {
      final success = await repository.delete(trail);
      if (success) {
        load();
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } else {
      print("Error 404, iten not found!");
      return false;
    }
  }

/*
  Future<bool> addComment(Trail trail, Coment comment) async {
    try {
      await repository.addComment(trail, comment);
      load();
      return true;
    } catch (e) {
      return false;
    }
  }*/ /*
  Future<bool> addComment(Trail trail, Coment comment) async {
    try {
      await repository.addComment(trail, comment);
      Trail? updatedTrail = await repository.getById(trail.id!);
      if (updatedTrail != null) {
        trail = updatedTrail;
      }
      load();
      return true;
    } catch (e) {
      return false;
    }
  }*/
  Future<bool> addComment(Trail trail, Coment coment) async {
    try {
      //trail.coments.add(coment);
      await repository.addComent(trail, coment);

      load();
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      print('Erro ao adicionar comentário: $e');
      return Future.value(false);
    }
  }

  void setupListeners() {
    onadd = repository.onTrailAdded.listen((event) {
      load();
    });

    onchange = repository.onTrailChanged.listen((event) {
      load();
    });

    ondelete = repository.onTrailRemoved.listen((event) {
      load();
    });
  }
}
