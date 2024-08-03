import 'package:http/http.dart' as http;

import '../../config/api_config.dart';

class ApiDataService {
  final String _baseUrl = ApiConfig.baseUrl;
  final String _apiKey = ApiConfig.apiKey;
  final String _language = ApiConfig.language;

  Future<String> getJsonData(String endpoint,
      {int page = 1, Map<String, String>? additionalParams}) async {
    final params = {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    };

    if (additionalParams != null) {
      params.addAll(additionalParams);
    }

    final url = Uri.https(_baseUrl, endpoint, params);

    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to load data');
    }
    return response.body;
  }
}
