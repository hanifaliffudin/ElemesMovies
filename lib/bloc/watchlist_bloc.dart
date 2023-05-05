import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(WatchlistInitial()) {
    on<GetWatchlistEvent>((event, emit) async {
      emit(WatchlistLoading());
      var box = await Hive.openBox('movies');
      var boxArray = box.values.cast();
      emit(WatchlistSuccess(boxArray));
    });
  }
}
