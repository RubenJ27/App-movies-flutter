part of 'movies_bloc.dart';

class MoviesState extends Equatable {
  final List<Movie>? movies;
  final bool? isLoadingDisplayMovies;
  final String? errorMessage;

  const MoviesState({
    this.movies,
    required this.isLoadingDisplayMovies,
    this.errorMessage,
  });

  MoviesState copyWith({
    List<Movie>? movies,
    bool? isLoadingDisplayMovies,
    String? message,
    String? errorMessage,
  }) =>
      MoviesState(
        movies: movies ?? this.movies,
        isLoadingDisplayMovies:
            isLoadingDisplayMovies ?? this.isLoadingDisplayMovies,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  String toString() {
    return """
      MoviesState{
        movies: $movies,
        isLoadingDisplayMovies: $isLoadingDisplayMovies,
        errorMessage: $errorMessage,
      }
    """;
  }

  factory MoviesState.initialState() => const MoviesState(
        movies: [],
        isLoadingDisplayMovies: false,
        errorMessage: '',
      );

  @override
  List<Object?> get props => [
        movies,
        isLoadingDisplayMovies,
        errorMessage,
      ];
}

class MoviesInitial extends MoviesState {
  const MoviesInitial()
      : super(
          // coverage:ignore-line
          movies: const [],
          errorMessage: null,
          isLoadingDisplayMovies: false,
        );
}

class DisplayMoviesLoading extends MoviesState {
  const DisplayMoviesLoading()
      // coverage:ignore-line
      : super(
          movies: const [],
          isLoadingDisplayMovies: true,
          errorMessage: null,
        );
}

class DisplayMoviesLoaded extends MoviesState {
  const DisplayMoviesLoaded(List<Movie> movies)
      : super(
          movies: movies,
          isLoadingDisplayMovies: false,
          errorMessage: null,
        );
}

class DisplayMoviesError extends MoviesState {
  final String _errorMessage;

  const DisplayMoviesError({required String message})
      : _errorMessage = message,
        super(
          movies: const [],
          isLoadingDisplayMovies: false,
          errorMessage: message,
        );

  @override
  String get errorMessage => _errorMessage;
}

class PopularMoviesLoading extends MoviesState {
  const PopularMoviesLoading()
      : super(
          isLoadingDisplayMovies: false,
          errorMessage: null,
        );
}

class PopularMoviesLoaded extends MoviesState {
  final List<Movie> popularMovies;

  const PopularMoviesLoaded(this.popularMovies)
      : super(
          movies: popularMovies,
          isLoadingDisplayMovies: false,
          errorMessage: null,
        );
}

class PopularMoviesError extends MoviesState {
  final String _errorMessage;

  const PopularMoviesError({required String message})
      : _errorMessage = message,
        super(
          movies: const [],
          isLoadingDisplayMovies: false,
          errorMessage: message,
        );

  @override
  String get errorMessage => _errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}

class MovieCastLoading extends MoviesState {
  const MovieCastLoading()
      : super(
          isLoadingDisplayMovies: false,
          errorMessage: null,
        );
}

class MovieCastLoaded extends MoviesState {
  final List<Cast> cast;

  const MovieCastLoaded(
    this.cast, {
    super.isLoadingDisplayMovies,
    super.errorMessage,
  });

  @override
  List<Object> get props => [cast];
}

class MovieCastError extends MoviesState {
  final String _errorMessage;

  MovieCastError({required String message})
      : _errorMessage = message,
        super(
          movies: [],
          isLoadingDisplayMovies: false,
          errorMessage: message,
        );

  @override
  String get errorMessage => _errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}

class SearchMoviesLoading extends MoviesState {
  const SearchMoviesLoading({
    super.isLoadingDisplayMovies,
  });
}

class SearchMoviesLoaded extends MoviesState {
  @override
  final List<Movie> movies;

  const SearchMoviesLoaded({required this.movies})
      : super(
          isLoadingDisplayMovies: false,
        );
}

class SearchMoviesError extends MoviesState {
  final String _errorMessage;

  const SearchMoviesError({
    required String message,
  })  : _errorMessage = message,
        super(
          movies: const [],
          isLoadingDisplayMovies: false,
          errorMessage: message,
        );

  @override
  String get errorMessage => _errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}

class MovieSuggestionsLoading extends MoviesState {
  const MovieSuggestionsLoading({
    required super.isLoadingDisplayMovies,
  });
}

class MovieSuggestionsLoaded extends MoviesState {
  final List<Movie> suggestions;

  const MovieSuggestionsLoaded(
    this.suggestions, {
    required super.isLoadingDisplayMovies,
  });

  @override
  List<Object> get props => [suggestions];
}

class SuggestionsError extends MoviesState {
  final String _errorMessage;

  SuggestionsError({required String message})
      : _errorMessage = message,
        super(
          movies: [],
          isLoadingDisplayMovies: false,
          errorMessage: message,
        );

  @override
  String get errorMessage => _errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
