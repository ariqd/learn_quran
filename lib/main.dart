import 'package:flutter/material.dart';
import 'models/chapter_model.dart';
import 'services/quran_api_service.dart';
import 'screens/verse_list_page.dart'; // Added import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn Quran',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF16B068)),
        useMaterial3: true,
      ),
      home: const ChapterListPage(),
    );
  }
}

class ChapterListPage extends StatefulWidget {
  const ChapterListPage({super.key});

  @override
  State<ChapterListPage> createState() => _ChapterListPageState();
}

class _ChapterListPageState extends State<ChapterListPage> {
  final QuranApiService _apiService = QuranApiService();
  List<Chapter> _allChapters = [];
  List<Chapter> _filteredChapters = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchChapters();
    _searchController.addListener(_filterChapters);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterChapters);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchChapters() async {
    try {
      final chapters = await _apiService.getChapters();
      setState(() {
        _allChapters = chapters;
        _filteredChapters = chapters;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _filterChapters() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredChapters = _allChapters.where((chapter) {
        final nameSimpleLower = chapter.nameSimple.toLowerCase();
        final nameArabicLower = chapter.nameArabic.toLowerCase();
        return nameSimpleLower.contains(query) ||
            nameArabicLower.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran Chapters'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search chapters...',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_error != null) {
      return Center(child: Text('Error: $_error'));
    } else if (_filteredChapters.isEmpty) {
      return const Center(child: Text('No chapters found.'));
    } else {
      return ListView.builder(
        itemCount: _filteredChapters.length,
        itemBuilder: (context, index) {
          final chapter = _filteredChapters[index];
          return ListTile(
            leading: CircleAvatar(child: Text(chapter.id.toString())),
            title: Text(chapter.nameSimple),
            subtitle: Text(chapter.nameArabic),
            trailing: Text('${chapter.versesCount} verses'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VerseListPage(chapter: chapter),
                ),
              );
            },
          );
        },
      );
    }
  }
}
