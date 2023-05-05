import 'dart:convert';

import 'package:elemes_movies/models/top_rated_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:elemes_movies/app_constants.dart' as constants;

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  String endpoint = '/movie/top_rated';

  TopRatedBloc() : super(TopRatedInitial()) {
    on<GetTopRatedEvent>((event, emit) async {
      emit(TopRatedLoading());
      final response = await http.get(Uri.parse(
          '${constants.AppConstants.baseUrl}$endpoint?api_key=${constants.AppConstants.apiKey}'));
      emit(TopRatedSuccess(
          topRatedModel: TopRatedModel.fromJson(jsonDecode(response.body))));
    });
  }
}
