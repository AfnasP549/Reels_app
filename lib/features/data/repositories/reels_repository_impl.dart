
import 'package:reels_app/features/data/datasources/api_service.dart';
import 'package:reels_app/features/data/models/reel_model.dart';
import 'package:reels_app/features/repositories/reels_repository.dart' show ReelsRepository;

class ReelsRepositoryImpl implements ReelsRepository {
  final ApiService apiService;

  ReelsRepositoryImpl({required this.apiService});

  @override
  Future<List<ReelModel>> fetchReels(int page, int limit) async {
    try {
      final reels = await apiService.fetchReels(page, limit);
      return reels;
    } catch (e) {
      throw Exception('Failed to fetch reels: $e');
    }
  }
}