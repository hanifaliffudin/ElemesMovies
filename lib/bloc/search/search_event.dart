part of 'search_bloc.dart';

abstract class SearchEvent {}

class GetSearchEvent extends SearchEvent {
  final String keyword;

  GetSearchEvent(this.keyword);
}
