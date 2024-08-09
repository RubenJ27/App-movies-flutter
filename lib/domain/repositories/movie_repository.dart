import '../../data/data_services/api_data_service.dart';
import '../../data/utils/json_utils.dart';
import '../entities/movie.dart';
import '../models/credits_response.dart';
import '../models/now_playing_response.dart';
import '../models/popular_movies_response.dart';
import '../models/search_response.dart';
import 'base_repository.dart';

abstract class MovieRepository extends BaseRepository {
  final ApiDataService _apiDataService;
  MovieRepository(this._apiDataService);

  Future<List<Movie>> getOnDisplayMovies() async {
    try {
      final String jsonData =
          await _apiDataService.getJsonData('/movie/now_playing');
      // Verificar si jsonData es un mapa y convertirlo a cadena JSON si es necesario
      final String jsonString = convertToJsonString(jsonData);
      final nowPlayingResponse = NowPlayingResponse.fromJson(jsonString);
      return nowPlayingResponse.results;
    } catch (e, stackTrace) {
      handleError(e, stackTrace);
      throw 'Failed to fetch on display movies: $e';
    }
  }

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

  Future<List<Cast>> getOnMovieCast(int movieId) async {
    try {
      final jsonData =
          await _apiDataService.getJsonData('movie/$movieId/credits');
      // Verificar si jsonData es un mapa y convertirlo a cadena JSON si es necesario
      final String jsonString = convertToJsonString(jsonData);
      final movieCastResponse = CreditsResponse.fromJson(jsonString);
      return movieCastResponse.cast;
    } catch (e, stackTrace) {
      handleError(e, stackTrace);
      throw 'Failed to fetch movie cast: $e';
    }
  }

  Future<List<Movie>> getOnSearchMovies(String query) async {
    try {
      final jsonData = await _apiDataService.getJsonData(
          'search/movie&language=es-ES',
          additionalParams: {'query': query});
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
