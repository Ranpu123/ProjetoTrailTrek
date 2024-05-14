import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_dev_disp_mob/models/user_model.dart';
import 'package:projeto_dev_disp_mob/services/User/users_repository.dart';

class UserController extends ChangeNotifier {
  final UserRepository repository;
  List<User?> users = [];
  User? loggedUser;

  UserController(this.repository) {
    load();
  }

  Future<List<User?>> load() async {
    users = await repository.fetchAll();
    notifyListeners();

    return users;
  }

  /*Future<bool> registerUser(
      String username, String password, String email) async {
    final newUser = User(
        username: username,
        email: email,
        password: password,
        createdAt: DateTime.now(),
        uid: UniqueKey().toString());
    final success = await repository.create(newUser);

    if (success) {
      users = await repository.fetchAll();
      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }*/

  Future<bool> registerUser(
      String uid, String username, String password, String email) async {
    final newUser = User(
        username: username,
        email: email,
        password: password,
        createdAt: DateTime.now(),
        uid: uid,
        profileImage: "");

    final success = await repository.create(newUser);
    if (success) {
      loggedUser = newUser;
      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<bool> updateUser(
      String uid, String username, String password, String email) async {
    final newUser = User(
        username: username,
        email: email,
        password: password,
        createdAt: DateTime.now(),
        uid: UniqueKey().toString());
    final success = await repository.update(newUser);

    if (success) {
      users = await repository.fetchAll();
      notifyListeners();
      return Future.value(true);
    }

    return Future.value(false);
  }

  Future<bool> removeUser(User user) async {
    final success = await repository.delete(user);
    if (success) {
      users = await repository.fetchAll();
      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<bool> login(String id) async {
    User? user = await repository.getById(id);

    if (user != null) {
      loggedUser = user;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

/*
  Future<bool> updateProfileImage(String downloadURL) async {
    if (loggedUser != null) {
      loggedUser!.profileImage = downloadURL;
      final success = await repository.update(loggedUser!);

      if (success) {
        notifyListeners();
        return Future.value(true);
      }
    }
    return Future.value(false);
  }
*/
  Future<bool> uploadProfileImage(XFile pickedImage, User user) async {
    String downloadURL = await repository.uploadImage(pickedImage, user.uid!);

    if (downloadURL.isNotEmpty) {
      user.profileImage = downloadURL;
      bool updateSuccess = await repository.update(user);
      if (updateSuccess) {
        loggedUser = user;
        notifyListeners();
      }
      return updateSuccess;
    } else {
      print('Erro ao fazer upload da imagem');
      return false;
    }
  }
}
