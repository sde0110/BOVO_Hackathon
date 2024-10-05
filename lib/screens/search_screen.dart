import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'main_screen.dart';
import 'word_list_screen.dart';
import 'word_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _allWords = [];
  List<Map<String, String>> _filteredWords = [];
  List<String> _recentSearches = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadWords();
    _loadRecentSearches();
  }

  Future<void> _loadWords() async {
    String jsonString = await rootBundle.loadString('assets/words.json');
    Map<String, dynamic> jsonResponse = json.decode(jsonString);
    setState(() {
      _allWords = jsonResponse.values
          .expand((list) => list as List)
          .map((item) => Map<String, String>.from(item))
          .toList();
    });
  }

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _recentSearches = prefs.getStringList('recentSearches') ?? [];
    });
  }

  Future<void> _saveRecentSearch(String search) async {
    if (!_recentSearches.contains(search)) {
      _recentSearches.insert(0, search);
      if (_recentSearches.length > 3) {
        _recentSearches.removeLast();
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('recentSearches', _recentSearches);
    }
  }

  void _filterSearchResults(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      if (_isSearching) {
        _filteredWords = _allWords
            .where((word) =>
                word['word']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        _filteredWords = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('단어 찾기', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF8A7FBA),
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFFF0F0FF),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: '검색어를 입력하세요',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: Color(0xFF8A7FBA)),
                    onPressed: () {
                      _filterSearchResults(_searchController.text);
                    },
                  ),
                ),
                onChanged: _filterSearchResults,
                onSubmitted: (value) {
                  _filterSearchResults(value);
                },
              ),
            ),
            Expanded(
              child:
                  _isSearching ? _buildSearchResults() : _buildRecentSearches(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFF8A7FBA),
      selectedItemColor: Colors.white,
      unselectedItemColor: Color(0xFFD5D1EE),
      currentIndex: 1,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: '단어찾기'),
        BottomNavigationBarItem(icon: Icon(Icons.flash_on), label: '오늘단어'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: '단어목록'),
      ],
      onTap: (index) {
        if (index != 1) {
          Widget screen;
          switch (index) {
            case 0:
              screen = MainScreen();
              break;
            case 3:
              screen = WordListScreen();
              break;
            default:
              return;
          }
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => screen),
            (Route<dynamic> route) => false,
          );
        }
      },
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _filteredWords.length,
      itemBuilder: (context, index) {
        final word = _filteredWords[index];
        return ListTile(
          title:
              Text(word['word']!, style: TextStyle(color: Color(0xFF5D4777))),
          onTap: () {
            _saveRecentSearch(word['word']!);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WordDetailScreen(word: word),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRecentSearches() {
    return _recentSearches.isEmpty
        ? Center(child: Text('최근 검색어가 없습니다.'))
        : ListView.builder(
            itemCount: _recentSearches.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.history),
                title: Text(_recentSearches[index]),
                onTap: () {
                  _searchController.text = _recentSearches[index];
                  _filterSearchResults(_recentSearches[index]);
                },
              );
            },
          );
  }
}
