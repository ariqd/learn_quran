import 'package:flutter/material.dart';
import '../models/chapter_model.dart';
import '../models/verse_model.dart';
import '../services/quran_api_service.dart';

class VerseListPage extends StatefulWidget {
  final Chapter chapter;

  const VerseListPage({super.key, required this.chapter});

  @override
  State<VerseListPage> createState() => _VerseListPageState();
}

class _VerseListPageState extends State<VerseListPage> {
  late Future<List<Verse>> _versesFuture;
  final QuranApiService _apiService = QuranApiService();

  @override
  void initState() {
    super.initState();
    _versesFuture = _apiService.getVerses(widget.chapter.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.chapter.nameSimple)),
      body: FutureBuilder<List<Verse>>(
        future: _versesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final verses = snapshot.data!;
            if (verses.isEmpty) {
              return const Center(
                child: Text('No verses found for this chapter.'),
              );
            }
            return ListView.builder(
              itemCount: verses.length,
              itemBuilder: (context, index) {
                final verse = verses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: ListTile(
                    leading: Text(
                      verse.verseKey,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Text(
                      verse.textUthmani,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 22,
                        fontFamily:
                            'NotoNaskhArabic', // Ensure you have this font or a similar Arabic font
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (verse.transliteration != null &&
                            verse.transliteration!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              verse.transliteration!,
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        if (verse.translationText != null &&
                            verse.translationText!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              verse.translationText!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey[700],
                              ),
                            ),
                          ),
                      ],
                    ),
                    onTap: () {
                      // Handle verse tap - e.g., play audio, show more details, etc.
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Tapped on ${verse.verseKey}: ${verse.textUthmani.substring(0, (verse.textUthmani.length > 20) ? 20 : verse.textUthmani.length)}...',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No verses found.'));
          }
        },
      ),
    );
  }
}
