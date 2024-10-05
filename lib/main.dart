import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp()); // const 추가 (만약 아직 추가하지 않았다면)
}

// 커스텀 MaterialColor 생성
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // const 생성자 추가 (만약 아직 추가하지 않았다면)

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BOVO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(), // 이미 const로 되어 있을 것입니다.
    );
  }
}
