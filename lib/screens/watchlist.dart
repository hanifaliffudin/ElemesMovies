import 'package:elemes_movies/bloc/details_movie/details_movie_bloc.dart';
import 'package:elemes_movies/bloc/watchlist_bloc.dart';
import 'package:elemes_movies/models/details_movie_model.dart';
import 'package:elemes_movies/screens/details_movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:elemes_movies/app_constants.dart' as constants;

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  void viewWillAppear() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: viewWillAppear,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text('My Watchlist',
                    style:
                        TextStyle(fontSize: 34, fontWeight: FontWeight.w500)),
              ),
              BlocBuilder<WatchlistBloc, WatchlistState>(
                builder: (context, state) {
                  if (state is WatchlistLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is WatchlistSuccess) {
                    // return Text(state.boxMovies.length.toString());
                    return WatchlistCardMovie(idMovies: state.boxMovies);
                  }
                  return Text('data');
                },
              )
            ],
          ),
        )),
      ),
    );
  }
}

class WatchlistCardMovie extends StatelessWidget {
  final Iterable idMovies;

  const WatchlistCardMovie({super.key, required this.idMovies});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [for (var item in idMovies) GetDetails(idMovie: item)],
    );
  }
}

class GetDetails extends StatelessWidget {
  final int idMovie;

  const GetDetails({super.key, required this.idMovie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailsMovieBloc()..add(GetDetailsMovieEvent(idMovie)),
      child: BlocBuilder<DetailsMovieBloc, DetailsMovieState>(
        builder: (context, state) {
          if (state is DetailsMovieLoading) {
            return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(child: CircularProgressIndicator()));
          } else if (state is DetailsMovieSuccess) {
            DetailsMovieModel movie = state.detailsMovieModel;
            // bool isWatchlist = getData(detailsMovie.id);
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
                              : const SizedBox(
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
                              const Icon(
                                Icons.star_rate_rounded,
                                color: Colors.yellow,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                ((movie.voteAverage / 10) * 5)
                                    .toStringAsFixed(1),
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.yellow),
                              )
                            ],
                          ),
                          const SizedBox(
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
          } else {
            return const Center(
              child: Text('No Data'),
            );
          }
        },
      ),
    );
  }
}
