import 'package:elemes_movies/bloc/now_playing/now_playing_bloc.dart';
import 'package:elemes_movies/bloc/popular_people/popular_people_bloc.dart';
import 'package:elemes_movies/bloc/top_rated/top_rated_bloc.dart';
import 'package:elemes_movies/bloc/upcoming/upcoming_bloc.dart';
import 'package:elemes_movies/widgets/movie_horizontal_card.dart';
import 'package:elemes_movies/widgets/popular_person_card.dart';
import 'package:elemes_movies/widgets/top_rated_card.dart';
import 'package:elemes_movies/widgets/upcoming_movies_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text('Upcoming Movies',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 450.0,
              child: BlocBuilder<UpcomingBloc, UpcomingState>(
                builder: (context, state) {
                  if (state is UpcomingLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UpcomingSuccess) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return UpcomingMoviesCard(
                          movie: state.upcomingMovies.results[index],
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No Data'),
                    );
                  }
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text('Now Playing',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500)),
            ),
            BlocBuilder<NowPlayingBloc, NowPlayingState>(
              builder: (context, state) {
                if (state is NowPlayingLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NowPlayingSuccess) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return MovieHorizontalCard(
                        movie: state.nowPlayingModel.results[index],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No Data'),
                  );
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text('Top Rated',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 330.0,
              child: BlocBuilder<TopRatedBloc, TopRatedState>(
                builder: (context, state) {
                  if (state is TopRatedLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TopRatedSuccess) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return TopRatedCard(
                          movie: state.topRatedModel.results[index],
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No Data'),
                    );
                  }
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text('Popular People',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: BlocBuilder<PopularPeopleBloc, PopularPeopleState>(
                builder: (context, state) {
                  if (state is PopularPeopleLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PopularPeopleSuccess) {
                    return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 9,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                childAspectRatio: (1 / 1.4)),
                        itemBuilder: (context, index) {
                          return PopularPersonCard(
                            peopleModel:
                                state.popularPeopleModel.results[index],
                          );
                        });
                  } else {
                    return const Center(
                      child: Text('No Data'),
                    );
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
