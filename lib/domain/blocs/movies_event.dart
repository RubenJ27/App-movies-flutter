part of 'movies_bloc.dart';

abstract class MoviesEvent {
  const MoviesEvent();
}

class GetOnDisplayMovies extends MoviesEvent {
  const GetOnDisplayMovies();
}

class GetPopularMovies extends MoviesEvent {}

class GetMovieCast extends MoviesEvent {
  final int movieId;

  const GetMovieCast(this.movieId);
}

class GetSearchMovies extends MoviesEvent {
  final String query;

  const GetSearchMovies(
      this.query); // Constructor renombrado y variable inicializada
}

class GetSuggestionsByQuery extends MoviesEvent {
  final String searchTerm;

  const GetSuggestionsByQuery(this.searchTerm);
}
