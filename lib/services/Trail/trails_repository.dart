import 'package:projeto_dev_disp_mob/models/trail_model.dart';

abstract class TrailsRepository {
  Future<List<Trail>> fetchAll();
  Future<bool> create(Trail trail);
  Future<bool> update(Trail trail);
  Future<bool> delete(Trail trail);
}