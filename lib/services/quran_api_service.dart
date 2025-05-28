import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/chapter_model.dart';
import '../models/verse_model.dart';

class QuranApiService {
  final String _baseUrl = 'https://api.quran.com/api/v4';

  Future<List<Chapter>> getChapters() async {
    final response = await http.get(Uri.parse('$_baseUrl/chapters'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> chaptersJson = data['chapters'];
      return chaptersJson.map((json) => Chapter.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load chapters');
    }
  }

  Future<List<Verse>> getVerses(int chapterId) async {
    // Using translation ID 131 (Dr. Mustafa Khattab, The Clear Quran - English)
    // The `language=en` is for the language of the transliteration if available directly.
    // The `fields` parameter can be used to specify what data to return for each verse.
    // Adding words=true for transliteration.
    // Specifying translation ID 131 for English.
    // Explicitly requesting text_uthmani AND translations in the fields parameter.
    // Adding per_page=300 to fetch all verses (longest surah has 286 verses).
    final String queryParams =
        'language=en&words=true&translations=131&fields=text_uthmani,translations&per_page=300';
    final response = await http.get(
      Uri.parse('$_baseUrl/verses/by_chapter/$chapterId?$queryParams'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> versesJson = data['verses'];
      // The Verse.fromJson method will now need to correctly parse 'transliteration' and 'translations'
      // based on the actual API response from this new endpoint.
      return versesJson.map((json) => Verse.fromJson(json)).toList();
    } else {
      throw Exception(
        'Failed to load verses for chapter $chapterId. Status: ${response.statusCode}',
      );
    }
  }
}
