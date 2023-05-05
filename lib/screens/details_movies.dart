import 'package:elemes_movies/bloc/details_movie/details_movie_bloc.dart';
import 'package:elemes_movies/models/details_movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elemes_movies/app_constants.dart' as constants;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class DetailsMoviePage extends StatefulWidget {
  const DetailsMoviePage({super.key});

  @override
  State<DetailsMoviePage> createState() => _DetailsMoviePageState();
}

class _DetailsMoviePageState extends State<DetailsMoviePage> {
  final _moviesBox = Hive.box('movies');

  void writeData(int id) {
    _moviesBox.put(id, id);
  }

  bool getData(int id) {
    return _moviesBox.get(id) != null;
  }

  void removeData(int id) {
    _moviesBox.delete(id);
  }

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2)}h ${parts[1].padLeft(2, '0')}m';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 36.0, right: 36),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.chevron_left,
                      size: 36,
                    ),
                  )
                ],
              ),
            ),
            BlocBuilder<DetailsMovieBloc, DetailsMovieState>(
              builder: (context, state) {
                if (state is DetailsMovieLoading) {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(child: CircularProgressIndicator()));
                } else if (state is DetailsMovieSuccess) {
                  DetailsMovieModel detailsMovie = state.detailsMovieModel;
                  bool isWatchlist = getData(detailsMovie.id);
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 36, vertical: 10),
                        height: 480,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            constants.AppConstants.imageUrlW500 +
                                detailsMovie.posterPath,
                            width: 320,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 36.0, right: 36),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                detailsMovie.title,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  if (isWatchlist) {
                                    removeData(detailsMovie.id);
                                    const snackBar = SnackBar(
                                        content: Text(
                                            'Removed from your watchlist'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    setState(() {});
                                  } else {
                                    writeData(detailsMovie.id);
                                    const snackBar = SnackBar(
                                        content:
                                            Text('Added to your watchlist'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    setState(() {});
                                  }
                                },
                                child: isWatchlist
                                    ? Icon(
                                        Icons.bookmark,
                                        size: 32,
                                      )
                                    : Icon(
                                        Icons.bookmark_outline,
                                        size: 32,
                                      ))
                          ],
                        ),
                      ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   padding: const EdgeInsets.only(
                      //       left: 36.0, right: 36, top: 8),
                      //   child: Text(
                      //     'Release date: ${DateFormat('dd MMMM yyyy').format(detailsMovie.releaseDate)}',
                      //     textAlign: TextAlign.start,
                      //     style: const TextStyle(
                      //         fontSize: 16, fontWeight: FontWeight.w500),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 36.0, right: 36, top: 8),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Wrap(
                            children: [
                              for (var item in detailsMovie.genres)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Chip(
                                      label: Text(
                                    item.name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  )),
                                )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 36.0, right: 36, top: 8),
                        child: Row(
                          children: [
                            Icon(Icons.schedule),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              durationToString(detailsMovie.runtime),
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 36.0, right: 36, top: 8),
                        child: Text(
                          detailsMovie.overview,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text('No Data'),
                  );
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
