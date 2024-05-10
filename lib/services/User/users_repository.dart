import 'package:projeto_dev_disp_mob/models/user_model.dart';

abstract class UserRepository {
  Future<List<User>> fetchAll();
  Future<bool> create(User user);
  Future<bool> update(User user);
  Future<bool> delete(User user);
  Future<User?> getById(String id);
}
