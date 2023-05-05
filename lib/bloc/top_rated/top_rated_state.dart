part of 'top_rated_bloc.dart';

abstract class TopRatedState {}

class TopRatedInitial extends TopRatedState {}

class TopRatedLoading extends TopRatedState {}

class TopRatedSuccess extends TopRatedState {
  final TopRatedModel topRatedModel;

  TopRatedSuccess({required this.topRatedModel});
}
