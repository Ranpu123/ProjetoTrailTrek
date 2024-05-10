import 'package:projeto_dev_disp_mob/models/trail_model.dart';
import 'package:latlong2/latlong.dart';

abstract class TrailsRepository {
  Future<List<Trail>> fetchAll();
  Future<bool> create(Trail trail);
  Future<bool> update(Trail trail);
  Future<bool> delete(Trail trail);
  Future<Trail?> getById(String id);
  Future<List<Trail>> getByGeoLocation(LatLng latlong);
}
