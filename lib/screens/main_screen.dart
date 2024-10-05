import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'word_list_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VOBO', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF8A7FBA),
        elevation: 0,
        // shape 속성 제거
      ),
      body: Container(
        color: Color(0xFFF0F0FF),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLargeButton(
                context,
                icon: Icons.search,
                label: '단어 찾기',
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                ),
              ),
              const SizedBox(height: 20),
              _buildLargeButton(
                context,
                icon: Icons.flash_on,
                label: '오늘 단어',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('준비 중입니다.'),
                      backgroundColor: Color(0xFF8A7FBA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildLargeButton(
                context,
                icon: Icons.book,
                label: '단어 목록',
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WordListScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        backgroundColor: Color(0xFF8A7FBA),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xFFD5D1EE),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '단어찾기'),
          BottomNavigationBarItem(icon: Icon(Icons.flash_on), label: '오늘단어'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: '단어목록'),
        ],
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
              break;
            case 2:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('준비 중입니다.'),
                  backgroundColor: Color(0xFF8A7FBA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WordListScreen()),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildLargeButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 80,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 30, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF8A7FBA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
        ),
      ),
    );
  }
}
