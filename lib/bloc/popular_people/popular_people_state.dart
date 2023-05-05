part of 'popular_people_bloc.dart';

abstract class PopularPeopleState {}

class PopularPeopleInitial extends PopularPeopleState {}

class PopularPeopleLoading extends PopularPeopleState {}

class PopularPeopleSuccess extends PopularPeopleState {
  final PopularPeopleModel popularPeopleModel;

  PopularPeopleSuccess({required this.popularPeopleModel});
}
