import 'package:app_movies/domain/models/credits_response.dart';

import '../../domain/entities/movie.dart';
import '../../domain/models/now_playing_response.dart';
import '../../domain/models/popular_movies_response.dart';
import '../../domain/models/search_response.dart';
import '../../domain/repositories/movie_repository.dart';
import '../data_services/api_data_service.dart';

class MovieRepositoryImpl implements MovieRepository {
  final ApiDataService _apiDataService;

  MovieRepositoryImpl(this._apiDataService);

  @override
  Future<List<Movie>> getOnDisplayMovies() async {
    final jsonData = await _apiDataService.getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    return nowPlayingResponse.results;
  }

  @override
  Future<List<Movie>> getOnPopularMovies(int page) async {
    final jsonData =
        await _apiDataService.getJsonData('3/movie/popular', page: page);
    final popularMoviesResponse = PopularMoviesResponse.fromJson(jsonData);
    return popularMoviesResponse.results;
  }

  @override
  Future<List<Cast>> getOnMovieCast(int movieId) async {
    final jsonData =
        await _apiDataService.getJsonData('3/movie/$movieId/credits');
    final movieCastResponse = CreditsResponse.fromJson(jsonData);
    return movieCastResponse.cast;
  }

  @override
  Future<List<Movie>> getOnSearchMovies(String query) async {
    final jsonData = await _apiDataService
        .getJsonData('3/search/movie', additionalParams: {'query': query});
    final searchMoviesResponse = SearchResponse.fromJson(jsonData);
    return searchMoviesResponse.results;
  }
}
