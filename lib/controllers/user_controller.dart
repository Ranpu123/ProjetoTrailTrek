import 'package:flutter/foundation.dart';
import 'package:projeto_dev_disp_mob/models/user_model.dart';
import 'package:projeto_dev_disp_mob/services/User/users_repository.dart';

class UserController extends ChangeNotifier{
  final UserRepository repository;
  List<User?> users = [];
  User? loggedUser;

  UserController(this.repository){
    load();
  }

  Future<List<User?>> load() async{
    users = await repository.fetchAll();
    notifyListeners();

    return users;
  }

  Future<bool> registerUser(String username, String password, String email) async{
    final newUser = User(username: username, email: email, password: password, createdAt: DateTime.now(), uid: UniqueKey().toString());
    final success = await repository.create(newUser);

    if(success){
      users = await repository.fetchAll();
      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<bool> updateUser(String uid, String username, String password, String email) async{
    final newUser = User(username: username, email: email, password: password, createdAt: DateTime.now(), uid: UniqueKey().toString());
    final success = await repository.update(newUser);

    if(success){
      users = await repository.fetchAll();
      notifyListeners();
      return Future.value(true);
    }

    return Future.value(false);
  }

  Future<bool> removeUser(User user) async{
    final success = await repository.delete(user);
    if(success){
      users = await repository.fetchAll();
      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<bool> login(String email, String password)async{
    dynamic user;
    user = users.firstWhere((e) => e?.email == email && e?.password == password, orElse: () => null);
    if(user != null){
      loggedUser = user;
      return Future.value(true);
    }
    return Future.value(false);
  }
  
}