import 'package:projeto_dev_disp_mob/models/user_model.dart';
import 'package:projeto_dev_disp_mob/services/User/users_repository.dart';

class LocalUserRepository extends UserRepository {
  List<User> _users = [];

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
}
