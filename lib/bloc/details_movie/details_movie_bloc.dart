import 'dart:convert';

import 'package:elemes_movies/models/details_movie_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:elemes_movies/app_constants.dart' as constants;

part 'details_movie_event.dart';
part 'details_movie_state.dart';

class DetailsMovieBloc extends Bloc<DetailsMovieEvent, DetailsMovieState> {
  DetailsMovieBloc() : super(DetailsMovieInitial()) {
    on<GetDetailsMovieEvent>((event, emit) async {
      String endpoint = '/movie/${event.idMovie}';
      emit(DetailsMovieLoading());
      final response = await http.get(Uri.parse(
          '${constants.AppConstants.baseUrl}$endpoint?api_key=${constants.AppConstants.apiKey}'));
      emit(DetailsMovieSuccess(
          detailsMovieModel:
              DetailsMovieModel.fromJson(jsonDecode(response.body))));
    });
  }
}
