import 'package:elemes_movies/bloc/search/search_bloc.dart';
import 'package:elemes_movies/models/search_movie_model.dart';
import 'package:elemes_movies/widgets/movie_horizontal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding:
                  EdgeInsets.only(left: 24.0, right: 24, top: 24, bottom: 8),
              child: Text('Search Movie',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24.0, right: 24, bottom: 18, top: 10),
              child: _SearchBar(),
            ),
            _SearchBody(),
          ],
        ),
      )),
    );
    ;
  }
}

class _SearchBar extends StatefulWidget {
  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _textController = TextEditingController();
  late SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = context.read<SearchBloc>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: _textController,
        autocorrect: false,
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  _searchBloc.add(
                    GetSearchEvent(_textController.text),
                  );
                },
                icon: Icon(Icons.search)),
            hintText: 'Search a movie',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
            )));
  }
}

class _SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return Container(
              height: 400,
              child: Center(child: const CircularProgressIndicator()));
        }

        if (state is SearchSuccess) {
          return state.searchMovieModel.results.isEmpty
              ? Center(child: const Text('No Results'))
              : _SearchResults(items: state.searchMovieModel);
        }
        return const Text('');
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({Key? key, required this.items}) : super(key: key);

  final SearchMovieModel items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.results.length,
      itemBuilder: (BuildContext context, int index) {
        return MovieHorizontalCard(movie: items.results[index]);
      },
    );
  }
}
