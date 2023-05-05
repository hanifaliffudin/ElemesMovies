import 'dart:convert';

import 'package:elemes_movies/models/movie_model.dart';

SearchMovieModel searchMovieModelFromJson(String str) =>
    SearchMovieModel.fromJson(json.decode(str));

String searchMovieModelToJson(SearchMovieModel data) =>
    json.encode(data.toJson());

class SearchMovieModel {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalMovieModels;

  SearchMovieModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalMovieModels,
  });

  factory SearchMovieModel.fromJson(Map<String, dynamic> json) =>
      SearchMovieModel(
        page: json["page"],
        results: List<MovieModel>.from(
            json["results"].map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalMovieModels: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalMovieModels,
      };
}
