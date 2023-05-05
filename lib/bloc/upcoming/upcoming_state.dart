part of 'upcoming_bloc.dart';

abstract class UpcomingState {}

class UpcomingInitial extends UpcomingState {}

class UpcomingLoading extends UpcomingState {}

class UpcomingSuccess extends UpcomingState {
  final UpcomingMovieModel upcomingMovies;

  UpcomingSuccess({required this.upcomingMovies});
}
