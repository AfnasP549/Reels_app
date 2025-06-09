part of 'reels_bloc.dart';

@immutable
sealed class ReelsEvent {}

class FetchReelsEvent extends ReelsEvent {
  final int page;
  FetchReelsEvent({required this.page});
}
