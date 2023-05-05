import 'package:elemes_movies/bloc/details_movie/details_movie_bloc.dart';
import 'package:elemes_movies/models/movie_model.dart';
import 'package:elemes_movies/screens/details_movies.dart';
import 'package:flutter/material.dart';
import 'package:elemes_movies/app_constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedCard extends StatelessWidget {
  const TopRatedCard({
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
        padding: const EdgeInsets.only(left: 24, right: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            width: 160,
            height: 300.0,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 250,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: movie.posterPath != null
                          ? Image.network(
                              constants.AppConstants.imageUrlW500 +
                                  movie.posterPath!,
                              width: 160,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 160,
                              child: Icon(
                                Icons.image,
                              ),
                            )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 8, bottom: 2),
                  child: Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_rate_rounded,
                        color: Colors.yellow[700],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        ((movie.voteAverage / 10) * 5).toStringAsFixed(1),
                        style:
                            TextStyle(fontSize: 16, color: Colors.yellow[900]),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
