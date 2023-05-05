import 'dart:convert';

import 'package:elemes_movies/models/popular_people_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:elemes_movies/app_constants.dart' as constants;

part 'popular_people_event.dart';
part 'popular_people_state.dart';

class PopularPeopleBloc extends Bloc<PopularPeopleEvent, PopularPeopleState> {
  String endpoint = '/person/popular';

  PopularPeopleBloc() : super(PopularPeopleInitial()) {
    on<GetPopularPeopleEvent>((event, emit) async {
      emit(PopularPeopleLoading());
      final response = await http.get(Uri.parse(
          '${constants.AppConstants.baseUrl}$endpoint?api_key=${constants.AppConstants.apiKey}'));
      emit(PopularPeopleSuccess(
          popularPeopleModel:
              PopularPeopleModel.fromJson(jsonDecode(response.body))));
    });
  }
}
