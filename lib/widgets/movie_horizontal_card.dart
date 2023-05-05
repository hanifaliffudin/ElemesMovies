import 'package:elemes_movies/bloc/details_movie/details_movie_bloc.dart';
import 'package:elemes_movies/models/movie_model.dart';
import 'package:elemes_movies/screens/details_movies.dart';
import 'package:flutter/material.dart';
import 'package:elemes_movies/app_constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieHorizontalCard extends StatelessWidget {
  const MovieHorizontalCard({
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
        padding: const EdgeInsets.only(left: 24, bottom: 22, right: 24),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 13),
              child: SizedBox(
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: movie.posterPath != null
                      ? Image.network(
                          constants.AppConstants.imageUrlW500 +
                              movie.posterPath!,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 100,
                          child: Icon(
                            Icons.image,
                          ),
                        ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rate_rounded,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        ((movie.voteAverage / 10) * 5).toStringAsFixed(1),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.yellow),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Popularity: ${movie.popularity}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
