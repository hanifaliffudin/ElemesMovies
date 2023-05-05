part of 'details_movie_bloc.dart';

abstract class DetailsMovieState {}

class DetailsMovieInitial extends DetailsMovieState {}

class DetailsMovieLoading extends DetailsMovieState {}

class DetailsMovieSuccess extends DetailsMovieState {
  final DetailsMovieModel detailsMovieModel;

  DetailsMovieSuccess({required this.detailsMovieModel});
}
