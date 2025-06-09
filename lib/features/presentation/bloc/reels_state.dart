part of 'reels_bloc.dart';

@immutable
sealed class ReelsState {}

class ReelsInitial extends ReelsState {}

class ReelsLoading extends ReelsState {}

class ReelsLoaded extends ReelsState {
  final List<ReelModel> reels;
  final bool hasReachedMax;
  ReelsLoaded({required this.reels, this.hasReachedMax= false});
}

class ReelsError extends ReelsState {
  final String message;
  ReelsError({required this.message});
}