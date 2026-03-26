import '../entities/look_entity.dart';

abstract class HomeRepository {
  Future<List<LookEntity>> getRecentlyCreatedLooks();
}
