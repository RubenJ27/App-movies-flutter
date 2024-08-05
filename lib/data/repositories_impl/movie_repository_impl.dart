import 'package:app_movies/domain/models/credits_response.dart';

import '../../domain/entities/movie.dart';
import '../../domain/models/now_playing_response.dart';
import '../../domain/models/popular_movies_response.dart';
import '../../domain/models/search_response.dart';
import '../../domain/repositories/base_repository.dart';
import '../../domain/repositories/movie_repository.dart';
import '../data_services/api_data_service.dart';
import '../utils/json_utils.dart';

class MovieRepositoryImpl extends BaseRepository implements MovieRepository {
  final ApiDataService _apiDataService;

  MovieRepositoryImpl(this._apiDataService);

  @override
  Future<List<Movie>> getOnDisplayMovies() async {
    try {
      final jsonData = await _apiDataService.getJsonData('/movie/now_playing');
      // Verificar si jsonData es un mapa y convertirlo a cadena JSON si es necesario
      final String jsonString = convertToJsonString(jsonData);
      final nowPlayingResponse = NowPlayingResponse.fromJson(jsonString);
      return nowPlayingResponse.results;
    } catch (e, stackTrace) {
      handleError(e, stackTrace);
      throw 'Failed to fetch on display movies: $e';
    }
  }

  @override
  Future<List<Movie>> getOnPopularMovies(int page) async {
    try {
      final jsonData =
          await _apiDataService.getJsonData('/movie/popular', page: page);
      // Verificar si jsonData es un mapa y convertirlo a cadena JSON si es necesario
      final String jsonString = convertToJsonString(jsonData);
      final popularMoviesResponse = PopularMoviesResponse.fromJson(jsonString);
      return popularMoviesResponse.results;
    } catch (e, stackTrace) {
      handleError(e, stackTrace);
      throw 'Failed to fetch popular movies: $e';
    }
  }

  @override
  Future<List<Cast>> getOnMovieCast(int movieId) async {
    try {
      final jsonData =
          await _apiDataService.getJsonData('/movie/$movieId/credits');
      // Verificar si jsonData es un mapa y convertirlo a cadena JSON si es necesario
      final String jsonString = convertToJsonString(jsonData);
      final movieCastResponse = CreditsResponse.fromJson(jsonString);
      return movieCastResponse.cast;
    } catch (e, stackTrace) {
      handleError(e, stackTrace);
      throw 'Failed to fetch movie cast: $e';
    }
  }

  @override
  Future<List<Movie>> getOnSearchMovies(String query) async {
    try {
      final jsonData = await _apiDataService
          .getJsonData('/search/movie', additionalParams: {'query': query});
      // Verificar si jsonData es un mapa y convertirlo a cadena JSON si es necesario
      final String jsonString = convertToJsonString(jsonData);
      final searchMoviesResponse = SearchResponse.fromJson(jsonString);
      return searchMoviesResponse.results;
    } catch (e, stackTrace) {
      handleError(e, stackTrace);
      throw 'Failed to fetch search movies: $e';
    }
  }
}
