import 'dart:convert';

import 'package:elemes_movies/models/upcoming_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:elemes_movies/app_constants.dart' as constants;

part 'upcoming_event.dart';
part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  String endpoint = '/movie/upcoming';

  UpcomingBloc() : super(UpcomingInitial()) {
    on<GetUpcomingEvent>((event, emit) async {
      emit(UpcomingLoading());
      final response = await http.get(Uri.parse(
          '${constants.AppConstants.baseUrl}$endpoint?api_key=${constants.AppConstants.apiKey}'));
      emit(UpcomingSuccess(
          upcomingMovies:
              UpcomingMovieModel.fromJson(jsonDecode(response.body))));
    });
  }
}
