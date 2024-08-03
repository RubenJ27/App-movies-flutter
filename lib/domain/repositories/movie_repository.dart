import '../../data/data_services/api_data_service.dart';
import '../entities/movie.dart';
import '../models/credits_response.dart';
import '../models/now_playing_response.dart';
import '../models/popular_movies_response.dart';
import '../models/search_response.dart';

class MovieRepository {
  final ApiDataService _apiDataService;
  MovieRepository(this._apiDataService);

  Future<List<Movie>> getOnDisplayMovies() async {
    final jsonData = await _apiDataService.getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    return nowPlayingResponse.results;
  }

  Future<List<Movie>> getOnPopularMovies(int page) async {
    final jsonData =
        await _apiDataService.getJsonData('3/movie/popular', page: page);
    final popularMoviesResponse = PopularMoviesResponse.fromJson(jsonData);
    return popularMoviesResponse.results;
  }

  Future<List<Cast>> getOnMovieCast(int movieId) async {
    final jsonData =
        await _apiDataService.getJsonData('3/movie/$movieId/credits');
    final movieCastResponse = CreditsResponse.fromJson(jsonData);
    return movieCastResponse.cast;
  }

  Future<List<Movie>> getOnSearchMovies(String query) async {
    final jsonData = await _apiDataService
        .getJsonData('3/search/movie', additionalParams: {'query': query});
    final searchMoviesResponse = SearchResponse.fromJson(jsonData);
    return searchMoviesResponse.results;
  }
}
