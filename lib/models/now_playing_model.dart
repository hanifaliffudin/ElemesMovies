// To parse this JSON data, do
//
//     final nowPlayingModel = nowPlayingModelFromJson(jsonString);

import 'package:elemes_movies/models/movie_model.dart';
import 'dart:convert';

NowPlayingModel nowPlayingModelFromJson(String str) =>
    NowPlayingModel.fromJson(json.decode(str));

String nowPlayingModelToJson(NowPlayingModel data) =>
    json.encode(data.toJson());

class NowPlayingModel {
  final Dates dates;
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalMovieModels;

  NowPlayingModel({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalMovieModels,
  });

  factory NowPlayingModel.fromJson(Map<String, dynamic> json) =>
      NowPlayingModel(
        dates: Dates.fromJson(json["dates"]),
        page: json["page"],
        results: List<MovieModel>.from(
            json["results"].map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalMovieModels: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "dates": dates.toJson(),
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalMovieModels,
      };
}

class Dates {
  final DateTime maximum;
  final DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toJson() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}
