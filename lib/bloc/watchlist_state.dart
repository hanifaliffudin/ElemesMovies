part of 'watchlist_bloc.dart';

abstract class WatchlistState {}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistSuccess extends WatchlistState {
  final Iterable boxMovies;

  WatchlistSuccess(this.boxMovies);
}
