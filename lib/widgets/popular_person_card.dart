import 'package:elemes_movies/models/people_model.dart';
import 'package:flutter/material.dart';
import 'package:elemes_movies/app_constants.dart' as constants;

class PopularPersonCard extends StatelessWidget {
  const PopularPersonCard({
    super.key,
    required this.peopleModel,
  });

  final PeopleModel peopleModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: Image.network(
            constants.AppConstants.imageUrlW500 + peopleModel.profilePath,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          peopleModel.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
