part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class GetOnDisplayMovies extends MoviesEvent {}

class GetPopularMovies extends MoviesEvent {}

class GetMovieCast extends MoviesEvent {
  final int movieId;

  const GetMovieCast(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class GetSearchMovies extends MoviesEvent {
  final String query;

  const GetSearchMovies(
      this.query); // Constructor renombrado y variable inicializada

  @override
  List<Object> get props => [query];
}

class GetSuggestionsByQuery extends MoviesEvent {
  final String searchTerm;

  const GetSuggestionsByQuery(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}

class LoadMoviesEvent extends MoviesEvent {}
