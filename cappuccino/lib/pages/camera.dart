import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Camera extends StatefulWidget {
  const Camera({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<StatefulWidget> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  var logger = Logger();
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late XFile image;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color.fromARGB(250, 168, 93, 48),
        title: const Text(
          'CÁmara',
          style: TextStyle(
            color: Color.fromARGB(250, 66, 25, 8),
            fontSize: 40,
          ),
        ),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(child: CameraPreview(_controller));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            image = await _controller.takePicture();

            if (!context.mounted) return;

            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  image: image,
                ),
              ),
            );
          } catch (e) {
            logger.e(
                "Something went wrong during the process of taking a picture");
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  const DisplayPictureScreen({super.key, required this.image});

  final XFile image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color.fromARGB(250, 168, 93, 48),
        title: const Text(
          'Tu Foto',
          style: TextStyle(
            color: Color.fromARGB(250, 66, 25, 8),
            fontSize: 40,
          ),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.file(File(image.path)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  savePhoto();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Color.fromARGB(250, 168, 93, 48)),
                ),
                child: const Text(
                  "Guardar",
                  style: TextStyle(
                    color: Color.fromARGB(250, 236, 204, 180),
                    fontSize: 15,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Color.fromARGB(250, 168, 93, 48)),
                ),
                child: const Text(
                  "Cancelar",
                  style: TextStyle(
                    color: Color.fromARGB(250, 236, 204, 180),
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }

  void savePhoto() async {
    // Step 1: Retrieve image from picker
// final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

// Step 2: Check for valid file
// if (image == null) return;

// Step 3: Get directory where we can duplicate selected file.
    final Directory duplicateFile = await getApplicationDocumentsDirectory();

// Step 4: Copy the file to a application document directory.
    final fileName = basename(image.path);
    final fPath = '${duplicateFile.path}/$fileName';
    await image.saveTo(fPath);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("lastPicture", fPath);
  }
}
