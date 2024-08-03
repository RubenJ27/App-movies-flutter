import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../helpers/debouncer.dart';
import '../entities/movie.dart';
import '../models/credits_response.dart';
import '../repositories/movie_repository.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieRepository movieRepository;

  List<Movie> onDisplayMovies = [];
  final List<Movie> popularMovies = [];
  final List<Movie> _popularMovies = [];
  int _popularMoviesPage = 0;
  final Map<int, List<Cast>> onMoviesCast = {};

  MoviesBloc(this.movieRepository) : super(MoviesInitial()) {
    on<GetOnDisplayMovies>(_onGetOnDisplayMovies);
    on<GetPopularMovies>(_onGetPopularMovies);
    on<GetMovieCast>(_onGetMovieCast);
    on<GetSearchMovies>(_onSearchMovies);
    on<GetSuggestionsByQuery>(_onGetSuggestionsByQuery);
  }

  void _onGetOnDisplayMovies(
      GetOnDisplayMovies event, Emitter<MoviesState> emit) async {
    emit(MoviesLoading());
    try {
      final List<Movie> displayMovies =
          await movieRepository.getOnDisplayMovies();
      onDisplayMovies = displayMovies;
      emit(MoviesDisplayLoaded(displayMovies));
    } catch (e) {
      emit(MoviesError('Error fetching on display movies: ${e.toString()}'));
    }
  }

  void _onGetPopularMovies(
      GetPopularMovies event, Emitter<MoviesState> emit) async {
    // Emitir estado de carga parcial sin reiniciar la lista de películas
    emit(PopularMoviesLoading());

    try {
      _popularMoviesPage++;
      final popularMovies =
          await movieRepository.getOnPopularMovies(_popularMoviesPage);
      _popularMovies.addAll(popularMovies);
      emit(PopularMoviesLoaded(_popularMovies));
    } catch (e) {
      emit(
          PopularMoviesError('Error fetching popular movies: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() {
    _suggestionStreamController.close();
    return super.close();
  }

  void _onGetMovieCast(GetMovieCast event, Emitter<MoviesState> emit) async {
    emit(MoviesLoading());
    try {
      if (onMoviesCast.containsKey(event.movieId)) {
        emit(MovieCastLoaded(onMoviesCast[event.movieId]!));
      } else {
        final List<Cast> movieCast =
            await movieRepository.getOnMovieCast(event.movieId);
        onMoviesCast[event.movieId] = movieCast;
        emit(MovieCastLoaded(movieCast));
      }
    } catch (e) {
      emit(MovieCastError(e.toString()));
    }
  }

  void _onSearchMovies(GetSearchMovies event, Emitter<MoviesState> emit) async {
    emit(SearchMoviesLoading());
    try {
      final movies = await movieRepository.getOnSearchMovies(event.query);

      if (movies.isEmpty) {
        emit(const MoviesError('No movies found.'));
      } else {
        emit(SearchMoviesLoaded(movies: movies));
      }
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStreamController =
      StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      _suggestionStreamController.stream;

  void _onGetSuggestionsByQuery(
      GetSuggestionsByQuery event, Emitter<MoviesState> emit) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      try {
        final results = await movieRepository.getOnSearchMovies(value);
        _suggestionStreamController.add(results);
      } catch (e) {
        // Manejar el error adecuadamente
        print('Error al obtener sugerencias: $e');
      }
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = event.searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
