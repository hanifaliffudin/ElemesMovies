import 'dart:convert';
import 'package:elemes_movies/models/search_movie_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:elemes_movies/app_constants.dart' as constants;

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  String endpoint = '/search/movie';

  SearchBloc() : super(SearchInitial()) {
    on<GetSearchEvent>((event, emit) async {
      emit(SearchLoading());
      final response = await http.get(Uri.parse(
          '${constants.AppConstants.baseUrl}$endpoint?api_key=${constants.AppConstants.apiKey}&query=${event.keyword}'));
      emit(SearchSuccess(
          searchMovieModel:
              SearchMovieModel.fromJson(jsonDecode(response.body))));
    });
  }
}
