import 'dart:html';
import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:projeto_dev_disp_mob/models/coments_model.dart';
import 'package:projeto_dev_disp_mob/models/trail_model.dart';
import 'package:projeto_dev_disp_mob/services/Trail/trails_repository.dart';

class TrailException implements Exception {
  String message;
  TrailException(this.message);
}

class RemoteTrailsRepository implements TrailsRepository {
  final _trailRef = FirebaseDatabase.instance.ref('Trails');

  @override
  Future<bool> create(Trail trail, List<XFile> images) async {
    try {
      DatabaseReference newRef = _trailRef.push();
      if (newRef.key == null) {
        return false;
      }
      String trailId = newRef.key!;
      trail.id = trailId;

      List<String> imagesUrls = [];
      for (XFile image in images) {
        imagesUrls.add(await uploadImage(image, trailId));
      }

      trail.images = imagesUrls;

      await _trailRef.child(trailId).set(trail.toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> delete(Trail trail) async {
    try {
      final success = await deleteImages(trail.images);
      if (!success) {
        return false;
      }
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
  Future<bool> update(
      Trail trail, List<String> toRemove, List<XFile> images) async {
    try {
      final success = await deleteImages(toRemove);
      if (!success) {
        return false;
      }

      List<String> imagesUrls = [];
      for (XFile image in images) {
        imagesUrls.add(await uploadImage(image, trail.id!));
      }

      trail.images.addAll(imagesUrls);

      await _trailRef.child(trail.id!).update(trail.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> uploadImage(XFile image, String id) async {
    String fileName = '${DateTime.now().millisecondsSinceEpoch}_${image.name}';
    Reference db = FirebaseStorage.instance.ref("trailImages/$id/$fileName");
    try {
      final metadata = SettableMetadata(contentType: 'image/jpeg');
      Uint8List imageData = await image.readAsBytes();
      await db.putData(imageData, metadata);
      return await db.getDownloadURL();
    } on Exception catch (e) {
      print('Erro Uploading Image $e');
      return '';
    }
  }

  Future<bool> deleteImages(List<String> images) async {
    try {
      for (String image in images) {
        Reference db = FirebaseStorage.instance.refFromURL(image);
        await db.delete();
      }
      return true;
    } on Exception catch (e) {
      print("LOL ERROR DELETING IMAGES! $e");
      return false;
    }
  }

  @override
  /*Future<void> addComment(Trail trail, Coment comment) async {
    try {
      await _trailRef.child('${trail.id}/coments').push().set(comment.toMap());
    } catch (e) {
      print('Ocorreu um erro ao adicionar o comentário: $e');
    }
  }*/ /*
  Future<void> addComment(Trail trail, Coment comment) async {
    String? commentId = _trailRef.child('${trail.id}/coments').push().key;
    if (commentId == null) {
      throw Exception("Falha ao gerar comment ID");
    } else {
      Coment commentWithId = comment.copyWithId(commentId);
      await _trailRef
          .child('${trail.id}/coments/$commentId')
          .set(commentWithId.toMap());
    }
  }*/ /*
  Future<void> addComment(Trail trail, Coment comment) async {
    try {
      String? commentId = _trailRef.child('${trail.id}/coments').push().key;
      if (commentId == null) {
        throw Exception("Falha ao gerar comment ID");
      }
      Coment commentWithId = comment.copyWithId(commentId);
      await _trailRef
          .child('${trail.id}/coments/$commentId')
          .set(commentWithId.toMap());
    } catch (e) {
      print('Ocorreu um erro ao adicionar o comentário: $e');
    }
  }*/

  Future<bool> addComent(Trail trail, Coment coment) async {
    try {
      DatabaseReference newRef =
          _trailRef.child(trail.id!).child('coments').push();
      if (newRef.key == null) {
        return false;
      }
      String comentId = newRef.key!;
      Coment comentWithId = coment.copyWithId(comentId);

      await _trailRef
          .child(trail.id!)
          .child('coments')
          .child(comentId)
          .set(comentWithId.toMap());
      return true;
    } catch (e) {
      print('Erro ao adicionar comentário no Firebase: $e');
      return false;
    }
  }

  @override
  Stream<DatabaseEvent> get onTrailAdded => _trailRef.onChildAdded;

  @override
  Stream<DatabaseEvent> get onTrailChanged => _trailRef.onChildChanged;

  @override
  Stream<DatabaseEvent> get onTrailRemoved => _trailRef.onChildRemoved;
}
