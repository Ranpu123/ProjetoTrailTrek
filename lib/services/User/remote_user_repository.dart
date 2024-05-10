import 'package:firebase_database/firebase_database.dart';
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
}
