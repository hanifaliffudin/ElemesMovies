import 'dart:convert';

import 'package:elemes_movies/models/now_playing_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:elemes_movies/app_constants.dart' as constants;

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  String endpoint = '/movie/now_playing';

  NowPlayingBloc() : super(NowPlayingInitial()) {
    on<GetNowPlayingEvent>((event, emit) async {
      emit(NowPlayingLoading());
      final response = await http.get(Uri.parse(
          '${constants.AppConstants.baseUrl}$endpoint?api_key=${constants.AppConstants.apiKey}'));
      emit(NowPlayingSuccess(
          nowPlayingModel:
              NowPlayingModel.fromJson(jsonDecode(response.body))));
    });
  }
}
