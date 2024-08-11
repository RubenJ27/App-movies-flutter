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
  final MovieRepository _movieRepository;

  List<Movie> onDisplayMovies = [];
  final List<Movie> popularMovies = [];
  final List<Movie> _popularMovies = [];
  int _popularMoviesPage = 0;
  final Map<int, List<Cast>> onMoviesCast = {};

  MoviesBloc(this._movieRepository) : super(const MoviesInitial()) {
    on<GetOnDisplayMovies>(_onGetOnDisplayMovies);
    on<GetPopularMovies>(_onGetPopularMovies);
    on<GetMovieCast>(_onGetMovieCast);
    on<GetSearchMovies>(_onSearchMovies);
    on<GetSuggestionsByQuery>(_onGetSuggestionsByQuery);
  }

  void _onGetOnDisplayMovies(
      GetOnDisplayMovies event, Emitter<MoviesState> emit) async {
    emit(const DisplayMoviesLoading());
    try {
      final List<Movie> displayMovies =
          await _movieRepository.getOnDisplayMovies();
      onDisplayMovies = displayMovies;
      emit(DisplayMoviesLoaded(displayMovies));
    } catch (e) {
      emit(DisplayMoviesError(
        message: e.toString(),
      )); // Aquí se pasa el argumento 'message'
    }
  }

  void _onGetPopularMovies(
      GetPopularMovies event, Emitter<MoviesState> emit) async {
    // Emitir estado de carga parcial sin reiniciar la lista de películas
    emit(const PopularMoviesLoading());
    try {
      _popularMoviesPage++;
      final popularMovies =
          await _movieRepository.getOnPopularMovies(_popularMoviesPage);
      _popularMovies.addAll(popularMovies);
      emit(PopularMoviesLoaded(_popularMovies));
    } catch (e) {
      emit(PopularMoviesError(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    _suggestionStreamController.close();
    return super.close();
  }

  void _onGetMovieCast(GetMovieCast event, Emitter<MoviesState> emit) async {
    emit(const MovieCastLoading());
    try {
      if (onMoviesCast.containsKey(event.movieId)) {
        emit(MovieCastLoaded(
          onMoviesCast[event.movieId]!,
        ));
      } else {
        final List<Cast> movieCast =
            await _movieRepository.getOnMovieCast(event.movieId);
        onMoviesCast[event.movieId] = movieCast;
        emit(MovieCastLoaded(movieCast));
      }
    } catch (e) {
      emit(MovieCastError(
        message: e.toString(),
      ));
    }
  }

  void _onSearchMovies(GetSearchMovies event, Emitter<MoviesState> emit) async {
    emit(const SearchMoviesLoading());
    try {
      final movies = await _movieRepository.getOnSearchMovies(event.query);

      if (movies.isEmpty) {
        emit(const SearchMoviesError(
          message: 'Error al cargar la busqueda de la película',
        ));
      } else {
        emit(SearchMoviesLoaded(movies: movies));
      }
    } catch (e) {
      emit(SearchMoviesError(message: e.toString()));
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
        final results = await _movieRepository.getOnSearchMovies(value);
        _suggestionStreamController.add(results);
      } catch (e) {
        // Manejar el error adecuadamente
        print('Error al obtener sugerencias: $e');

        // Emitir un estado de error para que la UI pueda reaccionar
        emit(SuggestionsError(message: 'Error al obtener sugerencias'));
      }
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = event.searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
