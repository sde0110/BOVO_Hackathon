import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'search_screen.dart';
import 'word_list_screen.dart';

class WordDetailScreen extends StatelessWidget {
  final Map<String, String> word;

  const WordDetailScreen({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(word['word'] ?? '', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF8A7FBA),
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFFF0F0FF),
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text(
              word['word'] ?? '',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4777),
              ),
            ),
            SizedBox(height: 16),
            Text(
              '정의:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A5495),
              ),
            ),
            SizedBox(height: 8),
            Text(
              word['definition'] ?? '',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF6A5495),
              ),
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
        Widget screen;
        switch (index) {
          case 0:
            screen = MainScreen();
            break;
          case 1:
            screen = SearchScreen();
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
      },
    );
  }
}
