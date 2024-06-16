import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_dev_disp_mob/models/coments_model.dart';
import 'package:projeto_dev_disp_mob/models/trail_model.dart';
import 'package:latlong2/latlong.dart';

abstract class TrailsRepository {
  Future<List<Trail>> fetchAll();
  Future<bool> create(Trail trail, List<XFile> images);
  Future<bool> update(Trail trail);
  Future<bool> delete(Trail trail);
  Future<Trail?> getById(String id);
  Future<List<Trail>> getByGeoLocation(LatLng latlong);
  Future<void> addComent(Trail trail, Coment comment);
  Stream<DatabaseEvent> get onTrailAdded;
  Stream<DatabaseEvent> get onTrailChanged;
  Stream<DatabaseEvent> get onTrailRemoved;
}
