import 'package:elemes_movies/bloc/now_playing/now_playing_bloc.dart';
import 'package:elemes_movies/bloc/popular_people/popular_people_bloc.dart';
import 'package:elemes_movies/bloc/search/search_bloc.dart';
import 'package:elemes_movies/bloc/top_rated/top_rated_bloc.dart';
import 'package:elemes_movies/bloc/upcoming/upcoming_bloc.dart';
import 'package:elemes_movies/bloc/watchlist_bloc.dart';
import 'package:elemes_movies/screens/watchlist.dart';
import 'package:elemes_movies/screens/discover.dart';
import 'package:elemes_movies/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  final List<Widget> _widgetOptions = <Widget>[
    BlocProvider(
      create: (context) => SearchBloc(),
      child: SearchPage(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpcomingBloc()..add(GetUpcomingEvent()),
        ),
        BlocProvider(
          create: (context) => NowPlayingBloc()..add(GetNowPlayingEvent()),
        ),
        BlocProvider(
          create: (context) => TopRatedBloc()..add(GetTopRatedEvent()),
        ),
        BlocProvider(
          create: (context) =>
              PopularPeopleBloc()..add(GetPopularPeopleEvent()),
        ),
      ],
      child: DiscoverPage(),
    ),
    BlocProvider(
      create: (context) => WatchlistBloc()..add(GetWatchlistEvent()),
      child: WatchlistPage(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            activeIcon: Icon(Icons.bookmark),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
    ;
  }
}
