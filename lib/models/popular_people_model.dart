import 'dart:convert';

import 'package:elemes_movies/models/people_model.dart';

PopularPeopleModel popularPeopleModelFromJson(String str) =>
    PopularPeopleModel.fromJson(json.decode(str));

String popularPeopleModelToJson(PopularPeopleModel data) =>
    json.encode(data.toJson());

class PopularPeopleModel {
  final int page;
  final List<PeopleModel> results;
  final int totalPages;
  final int totalPeopleModels;

  PopularPeopleModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalPeopleModels,
  });

  factory PopularPeopleModel.fromJson(Map<String, dynamic> json) =>
      PopularPeopleModel(
        page: json["page"],
        results: List<PeopleModel>.from(
            json["results"].map((x) => PeopleModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalPeopleModels: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalPeopleModels,
      };
}
