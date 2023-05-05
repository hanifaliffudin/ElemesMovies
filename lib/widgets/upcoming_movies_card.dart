import 'package:elemes_movies/bloc/details_movie/details_movie_bloc.dart';
import 'package:elemes_movies/models/movie_model.dart';
import 'package:elemes_movies/screens/details_movies.dart';
import 'package:flutter/material.dart';
import 'package:elemes_movies/app_constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingMoviesCard extends StatelessWidget {
  const UpcomingMoviesCard({
    super.key,
    required this.movie,
  });

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => DetailsMovieBloc()
                            ..add(GetDetailsMovieEvent(movie.id)),
                        ),
                      ],
                      child: const DetailsMoviePage(),
                    )),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 11),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: movie.posterPath != null
                  ? Image.network(
                      constants.AppConstants.imageUrlW500 + movie.posterPath!,
                      width: 300,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 300,
                      child: Icon(
                        Icons.image,
                      ),
                    )),
        ));
  }
}
