import 'package:flutter/material.dart';

class DailyWordScreen extends StatelessWidget {
  const DailyWordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('일일 단어')),
      body: Center(
        child: Text('일일 단어 화면'),
      ),
    );
  }
}
