import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_dev_disp_mob/models/user_model.dart' as um;
import 'package:projeto_dev_disp_mob/services/User/users_repository.dart';

class UserException implements Exception {
  String message;
  UserException(this.message);
}

class RemoteUserRepository implements UserRepository {
  final DatabaseReference _userRef = FirebaseDatabase.instance.ref('Users');
  @override
  Future<bool> create(um.User user) async {
    try {
      await _userRef.child(user.uid!).set(user.toMap());
      return true;
    } catch (e) {
      return false;
      //throw UserException("Error creating user: $e");
    }
  }

  @override
  Future<bool> delete(um.User user) async {
    try {
      await _userRef.child(user.uid!).remove();
      return true;
    } catch (e) {
      return false;
      //throw UserException("Error deleting user: $e");
    }
  }

  @override
  Future<List<um.User>> fetchAll() async {
    List<um.User> userList = [];
    try {
      DataSnapshot event = await _userRef.get();
      for (final child in event.children) {
        final map = child.value as Map;
        final user = um.User.fromMap(map);
        userList.add(user);
      }
    } catch (e) {
      print("Error fetching users: $e");
    }
    return userList;
  }

  @override
  Future<bool> update(um.User user) async {
    try {
      await _userRef.child(user.uid!).update(user.toMap());
      return true;
    } catch (e) {
      return false;
      //throw UserException("Error updating user: $e");
    }
  }

  @override
  Future<um.User?> getById(String id) async {
    try {
      DataSnapshot snapshot = await _userRef.child(id).get();
      if (snapshot.exists) {
        final map = snapshot.value as Map;
        final user = um.User.fromMap(map);
        return user;
      }
    } catch (error) {
      print("Error getting user by UID: $error");
    }
    return null;
  }

  Future<String> uploadImage(XFile image, String id) async {
    String fileName = '${DateTime.now().millisecondsSinceEpoch}_${image.name}';
    Reference db = FirebaseStorage.instance.ref("usersImages/$id/$fileName");
    try {
      final metadata = SettableMetadata(contentType: 'image/png');
      Uint8List imageData = await image.readAsBytes();
      await db.putData(imageData, metadata);
      return await db.getDownloadURL();
    } on Exception catch (e) {
      print('Erro Uploading Image $e');
      return '';
    }
  }
  /*Future<String> uploadImage(XFile image, String id) async {
    String fileName = '${DateTime.now().millisecondsSinceEpoch}_${image.name}';
    Reference db = FirebaseStorage.instance.ref("usersImages/$id/$fileName");
    try {
      final metadata = SettableMetadata(contentType: 'image/png');
      Uint8List imageData = await image.readAsBytes();
      await db.putData(imageData, metadata);
      return await db.getDownloadURL();
    } on Exception catch (e) {
      print('Erro Uploading Image $e');
      return '';
    }
  }
  */
}
