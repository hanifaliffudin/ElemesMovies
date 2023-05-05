part of 'details_movie_bloc.dart';

abstract class DetailsMovieEvent {}

class GetDetailsMovieEvent extends DetailsMovieEvent {
  final int idMovie;

  GetDetailsMovieEvent(this.idMovie);
}
