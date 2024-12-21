import 'dart:convert';

import '../models/languages_model.dart';
import 'api_service.dart';

class TranslationService {
  final ApiService _apiService = ApiService();

  Future<List<Language>> getLanguages() async {
    try {
      final response = await _apiService.get("/languages");
      if (response.statusCode == 200) {
        final languageResponse = languagesModelFromJson(response.data);
        return languageResponse.data?.languages ?? [];
      } else {
        throw Exception("Failed to fetch languages: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<String> translate(
    String text,
    String targetLanguage,
    String source,
  ) async {
    final encodedParams = {
      'q': text,
      'target': targetLanguage,
      'source': source,
    };
    try {
      final response = await _apiService.post(
        "",
        encodedParams,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData =
            jsonDecode(jsonEncode(response.data));
        return responseData['data']['translations'][0]['translatedText'];
      } else {
        throw Exception("Failed to translate text: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
