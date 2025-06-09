import 'package:reels_app/features/data/models/reel_model.dart';

abstract class ReelsRepository {
  Future<List<ReelModel>> fetchReels(int page, int limit);
}