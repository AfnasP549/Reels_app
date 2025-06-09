import 'package:reels_app/features/data/models/reel_model.dart';
import 'package:reels_app/features/repositories/reels_repository.dart';

class FetchReels {
  final ReelsRepository repository;

  FetchReels(this.repository);

  Future<List<ReelModel>> call(int page, int limit) async{
    return await repository.fetchReels(page, limit);
  }
}