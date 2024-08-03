part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesDisplayLoaded extends MoviesState {
  final List<Movie> movies;

  const MoviesDisplayLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class MoviesError extends MoviesState {
  final String message;

  const MoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularMoviesLoading extends MoviesState {}

class PopularMoviesLoaded extends MoviesState {
  final List<Movie> popularMovies;
  const PopularMoviesLoaded(this.popularMovies);
}

class PopularMoviesError extends MoviesState {
  final String message;
  const PopularMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieCastLoading extends MoviesState {}

class MovieCastLoaded extends MoviesState {
  final List<Cast> cast;

  const MovieCastLoaded(this.cast);

  @override
  List<Object> get props => [cast];
}

class MovieCastError extends MoviesState {
  final String message;
  const MovieCastError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchMoviesLoading extends MoviesState {}

class SearchMoviesLoaded extends MoviesState {
  final List<Movie> movies;

  const SearchMoviesLoaded({required this.movies});
}

class SearchMoviesError extends MoviesState {
  final String message;
  const SearchMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieSuggestionsLoading extends MoviesState {}

class MovieSuggestionsLoaded extends MoviesState {
  final List<Movie> suggestions;

  const MovieSuggestionsLoaded(this.suggestions);

  @override
  List<Object> get props => [suggestions];
}
