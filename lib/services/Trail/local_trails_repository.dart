import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:projeto_dev_disp_mob/models/coments_model.dart';
import 'package:projeto_dev_disp_mob/models/trail_model.dart';
import 'package:projeto_dev_disp_mob/services/Trail/trails_repository.dart';

class LocalTrailRepository extends TrailsRepository {
  List<Trail> _trails = [];

  LocalTrailRepository() {
    load();
  }

  void load() {
    _trails.addAll([
      Trail(
          id: UniqueKey().toString(),
          uid: UniqueKey().toString(),
          username: 'username',
          name: 'Trilha do morro da santa - Alagados Ponta Grossa',
          description: 'Trilha do morro da santa - Alagados Ponta Grossa',
          distance: 7.19,
          elevation: 308.0,
          maxElevation: 500.0,
          duration: 60,
          createdAt: DateTime.now(),
          points: const [
            LatLng(-25.02095165946743, -50.060495950131404),
            LatLng(-25.020004932573844, -50.06153520675037),
            LatLng(-25.01989070603476, -50.0626116730901),
            LatLng(-25.016612033444382, -50.064359654031634),
            LatLng(-25.015100274658174, -50.061776307357114),
            LatLng(-25.015430836906418, -50.06051030475191),
            LatLng(-25.014137750102453, -50.060810712149745),
            LatLng(-25.00853127629199, -50.06106123111519),
            LatLng(-25.013747450868873, -50.05436702588947),
            LatLng(-25.017688050213025, -50.04301755157397),
            LatLng(-25.014663120094298, -50.04050948002432),
            LatLng(-25.01569323979217, -50.04327016288908),
          ],
          coments: [],
          images: [
            'https://i.imgur.com/0AlwvzW.png'
          ]),
      Trail(
          id: UniqueKey().toString(),
          uid: UniqueKey().toString(),
          username: 'username',
          name: 'Trilha do morro da santa',
          description: 'cool a description',
          distance: 7.19,
          elevation: 308.0,
          maxElevation: 500.0,
          duration: 60,
          createdAt: DateTime.now(),
          points: const [
            LatLng(-25.02095165946743, -50.060495950131404),
            LatLng(-25.020004932573844, -50.06153520675037),
            LatLng(-25.01989070603476, -50.0626116730901),
            LatLng(-25.016612033444382, -50.064359654031634),
            LatLng(-25.015100274658174, -50.061776307357114),
            LatLng(-25.015430836906418, -50.06051030475191),
            LatLng(-25.014137750102453, -50.060810712149745),
            LatLng(-25.00853127629199, -50.06106123111519),
            LatLng(-25.013747450868873, -50.05436702588947),
            LatLng(-25.017688050213025, -50.04301755157397),
            LatLng(-25.014663120094298, -50.04050948002432),
            LatLng(-25.01569323979217, -50.04327016288908),
          ],
          coments: [],
          images: [
            'https://i.imgur.com/0AlwvzW.png'
          ])
    ]);
  }

  @override
  Future<bool> create(Trail trail, List<XFile> images) async {
    _trails.add(trail);
    return Future.value(true);
  }

  @override
  Future<bool> delete(Trail trail) {
    final int index = _trails.indexWhere((t) => t.id == trail.id);
    if (index >= 0) {
      _trails.removeAt(index);
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Future<bool> update(Trail trail, List<String> toRemove, List<XFile> images) {
    final int index = _trails.indexWhere((t) => t.id == trail.id);
    if (index >= 0) {
      _trails.removeAt(index);
      _trails.add(trail);
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Future<List<Trail>> fetchAll() {
    return Future.value(_trails);
  }

  @override
  Future<List<Trail>> getByGeoLocation(LatLng latlong) {
    // TODO: implement getByGeoLocation
    throw UnimplementedError();
  }

  @override
  Future<Trail> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<void> addComent(Trail trail, Coment comment) {
    throw UnimplementedError();
  }

  @override
  // TODO: implement onTrailAdded
  Stream<DatabaseEvent> get onTrailAdded => throw UnimplementedError();

  @override
  // TODO: implement onTrailChanged
  Stream<DatabaseEvent> get onTrailChanged => throw UnimplementedError();

  @override
  // TODO: implement onTrailRemoved
  Stream<DatabaseEvent> get onTrailRemoved => throw UnimplementedError();
}
