import 'dart:convert';

import 'package:elemes_movies/models/movie_model.dart';

TopRatedModel topRatedModelFromJson(String str) =>
    TopRatedModel.fromJson(json.decode(str));

String topRatedModelToJson(TopRatedModel data) => json.encode(data.toJson());

class TopRatedModel {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalMovieModels;

  TopRatedModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalMovieModels,
  });

  factory TopRatedModel.fromJson(Map<String, dynamic> json) => TopRatedModel(
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
