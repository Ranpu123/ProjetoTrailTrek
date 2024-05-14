import 'package:image_picker/image_picker.dart';
import 'package:projeto_dev_disp_mob/models/user_model.dart';
import 'package:projeto_dev_disp_mob/services/User/users_repository.dart';

class LocalUserRepository extends UserRepository {
  List<User> _users = [];

  LocalUserRepository() {
    _localdata();
  }

  void _localdata() {
    _users.addAll([
      User(
          username: 'username',
          email: 'test@test.com',
          password: 'test',
          createdAt: DateTime.now()),
    ]);
  }

  @override
  Future<bool> create(User user) {
    _users.add(user);
    return Future.value(true);
  }

  @override
  Future<bool> delete(User user) {
    final int index = _users.indexWhere((u) => u.uid == user.uid);
    if (index >= 0) {
      _users.removeAt(index);
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Future<bool> update(User user) {
    final int index = _users.indexWhere((u) => u.uid == user.uid);
    if (index >= 0) {
      _users.removeAt(index);
      _users.add(user);
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Future<List<User>> fetchAll() {
    return Future.value(_users);
  }

  @override
  Future<User?> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  Future<String> uploadImage(XFile image, String id) async {
    throw UnimplementedError();
  }
}
