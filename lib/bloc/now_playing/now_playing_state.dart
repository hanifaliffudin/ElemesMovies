part of 'now_playing_bloc.dart';

abstract class NowPlayingState {}

class NowPlayingInitial extends NowPlayingState {}

class NowPlayingLoading extends NowPlayingState {}

class NowPlayingSuccess extends NowPlayingState {
  final NowPlayingModel nowPlayingModel;

  NowPlayingSuccess({required this.nowPlayingModel});
}
