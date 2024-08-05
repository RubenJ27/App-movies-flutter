import 'package:dio/dio.dart';

import '../../core/config/api_config.dart';

class ApiDataService {
  final String _apiKey = ApiConfig.apiKey;
  final String _language = ApiConfig.language;
  final Dio _dio = Dio();

  Future<dynamic> getJsonData(String endpoint,
      {int page = 1, Map<String, String>? additionalParams}) async {
    final params = {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    };

    if (additionalParams != null) {
      params.addAll(additionalParams);
    }

    final url = 'https://${ApiConfig.baseUrl}/3$endpoint';

    try {
      final Response<dynamic> response =
          await _dio.get(url, queryParameters: params);
      if (response.statusCode != 200) {
        throw Exception('Failed to load data');
      }
      return response.data; // Return the JSON object directly
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
