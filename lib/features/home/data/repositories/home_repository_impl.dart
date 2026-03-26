import '../../domain/entities/look_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../models/look_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<List<LookEntity>> getRecentlyCreatedLooks() async {
    // Mocking data for now as requested by "maintain data, domain"
    await Future.delayed(const Duration(seconds: 1));
    return [
      const LookModel(id: '1', imageUrl: 'assets/images/auth_home.png', isBookmarked: true),
      const LookModel(id: '2', imageUrl: 'assets/images/auth_home.png', isBookmarked: false),
    ];
  }
}
