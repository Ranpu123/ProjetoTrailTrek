import 'package:projeto_dev_disp_mob/models/trail_model.dart';
import 'package:projeto_dev_disp_mob/services/Trail/trails_repository.dart';

class LocalTrailRepository extends TrailsRepository {
  List<Trail> _trails = [];

  LocalTrailRepository() {
    load();
  }

  void load() {
    _trails.addAll([]);
  }

  @override
  Future<bool> create(Trail trail) {
    _trails.add(trail);
    return Future.value(true);
  }

  @override
  Future<bool> delete(Trail trail) {
    final int index = _trails.indexWhere((t) => t.id == trail.id);
    if (index >= 0) {
      _trails.removeAt(index);
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Future<bool> update(Trail trail) {
    final int index = _trails.indexWhere((t) => t.id == trail.id);
    if (index >= 0) {
      _trails.removeAt(index);
      _trails.add(trail);
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Future<List<Trail>> fetchAll() {
    return Future.value(_trails);
  }
}
