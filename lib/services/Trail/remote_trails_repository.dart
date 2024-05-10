import 'package:firebase_database/firebase_database.dart';
import 'package:latlong2/latlong.dart';
import 'package:projeto_dev_disp_mob/models/trail_model.dart';
import 'package:projeto_dev_disp_mob/services/Trail/trails_repository.dart';

class TrailException implements Exception {
  String message;
  TrailException(this.message);
}

class RemoteTrailsRepository implements TrailsRepository {
  final _trailRef = FirebaseDatabase.instance.ref('Trails');

  @override
  Future<bool> create(Trail trail) async {
    try {
      DatabaseReference newRef = _trailRef.push();
      if (newRef.key == null) {
        return false;
      }
      String trailId = newRef.key!;
      trail.id = trailId;
      await _trailRef.child(trailId).set(trail.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> delete(Trail trail) async {
    try {
      await _trailRef.child(trail.id!).remove();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Trail>> fetchAll() async {
    List<Trail> trails = [];
    try {
      DataSnapshot event = await _trailRef.get();
      for (final child in event.children) {
        final map = child.value as Map;
        final trail = Trail.fromMap(map);
        trails.add(trail);
      }
    } catch (e) {
      print("ERRO NA BUSCA DE TODOS OS TRAILS $e");
      //TODO: Finish Throw for each db operation
    }
    return trails;
  }

  @override
  Future<List<Trail>> getByGeoLocation(LatLng latlong) {
    // TODO: implement getByGeoLocation
    throw UnimplementedError();
  }

  @override
  Future<Trail?> getById(String id) async {
    try {
      DataSnapshot snapshot = await _trailRef.child(id).get();
      final map = snapshot.value as Map;
      final trail = Trail.fromMap(map);
      return trail;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> update(Trail trail) async {
    try {
      await _trailRef.child(trail.id!).update(trail.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
