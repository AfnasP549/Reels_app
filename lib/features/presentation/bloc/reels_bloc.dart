import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reels_app/features/data/models/reel_model.dart';
import 'package:reels_app/features/domain/usecase/fetch_reels.dart';

part 'reels_event.dart';
part 'reels_state.dart';

class ReelsBloc extends Bloc<ReelsEvent, ReelsState> {
  final FetchReels fetchReels;
  int currentPage = 1;
  final int  limit = 10;
  List<ReelModel> allreels = [];
  
  ReelsBloc({required this.fetchReels}) : super(ReelsInitial()) {
    on<FetchReelsEvent>((event, emit) async{
      emit(ReelsLoading());
      try{
        final reels = await fetchReels(event.page, limit);
        allreels.addAll(reels);

        emit(ReelsLoaded(
          reels: allreels,
          hasReachedMax: reels.length < limit
        ));
        currentPage++;
      }catch(e){
        emit(ReelsError(message: e.toString()));
      }

    });
  }
}
