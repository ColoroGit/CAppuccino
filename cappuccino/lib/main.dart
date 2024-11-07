import 'package:camera/camera.dart';
import 'package:cappuccino/pages/home.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera});

  final CameraDescription camera;

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
      home: Home(camera: camera),
    );
  }
}
