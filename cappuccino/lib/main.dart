import 'package:flutter/material.dart';
import 'pages/log_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAppuccino',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(250, 168, 93, 48),
          primary: const Color.fromARGB(255, 206, 140, 92),
          secondary: const Color.fromARGB(250, 66, 25, 8),
          tertiary: const Color.fromARGB(250, 236, 204, 180),
        ),
        fontFamily: 'Lucida',
      ),
      home: const LogIn(),
    );
  }
}
