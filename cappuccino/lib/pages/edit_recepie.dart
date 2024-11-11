import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cappuccino/models/caption.dart';
import 'package:cappuccino/models/recepie.dart';
import 'package:cappuccino/pages/home.dart';
import 'package:cappuccino/pages/my_recepies.dart';
import 'package:cappuccino/utils/database_helper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditRecepie extends StatefulWidget {
  const EditRecepie({
    super.key,
    required this.camera,
    required this.recepie,
    required this.pScreen,
  });

  final CameraDescription camera;
  final Recepie recepie;
  final String pScreen;

  @override
  State<EditRecepie> createState() => _EditRecepieState();
}

class _EditRecepieState extends State<EditRecepie> {
  DatabaseHelper db = DatabaseHelper.instance;
  TextEditingController dateInput = TextEditingController();
  late Recepie r;
  late File tmpFile;
  List<Image> imagesCarousel = List.empty(growable: true);
  List<String> imagesPath = List.empty(growable: true);
  late String i;

  @override
  void initState() {
    r = widget.recepie;

    if (r.id == -1) {
      r.dateOfCreation.day = DateTime.now().day;
      r.dateOfCreation.month = DateTime.now().month;
      r.dateOfCreation.year = DateTime.now().year;
      dateInput.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    } else {
      DateTime dt = DateTime(
        r.dateOfCreation.year,
        r.dateOfCreation.month,
        r.dateOfCreation.day,
      );
      dateInput.text = DateFormat('dd-MM-yyyy').format(dt);
    }

    for (int i = 0; i < r.captions.length; i++) {
      if (r.captions[i].caption.startsWith("assets")) {
        imagesCarousel.add(Image.asset(r.captions[i].caption));
      } else {
        imagesCarousel.add(Image.file(File(r.captions[i].caption)));
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color.fromARGB(250, 168, 93, 48),
        title: const Text(
          'CAppuccino',
          style: TextStyle(
            color: Color.fromARGB(250, 66, 25, 8),
            fontSize: 40,
          ),
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            ListView(
              children: [
                const SizedBox(
                  height: 15,
                ),
                CarouselSlider(
                  items: imagesCarousel,
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll:
                        (imagesCarousel.length == 1) ? false : true,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Título",
                      style: TextStyle(
                        fontSize: 28,
                        color: Color.fromARGB(250, 66, 25, 8),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                        left: 75,
                        right: 75,
                      ),
                      child: TextFormField(
                        style: const TextStyle(
                          fontFamily: 'Sitka',
                          color: Color.fromARGB(250, 66, 25, 8),
                        ),
                        initialValue: r.title,
                        onChanged: (value) {
                          setState(() {
                            r.title = value;
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Tiempo de\nPreparación",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(250, 66, 25, 8),
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        SizedBox(
                          width: 60,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            initialValue: r.timeOfPrep.toString(),
                            onChanged: (value) {
                              if (value == "") {
                                setState(() {
                                  r.timeOfPrep = 0;
                                });
                              } else {
                                setState(() {
                                  r.timeOfPrep = int.parse(value);
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Fecha de\nCreación",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(250, 66, 25, 8),
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        SizedBox(
                          width: 180,
                          child: TextField(
                            controller: dateInput,
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.calendar_today,
                              ),
                              labelText: "Ingresa una fecha",
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now(),
                              );

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                setState(() {
                                  r.dateOfCreation.day = pickedDate.day;
                                  r.dateOfCreation.month = pickedDate.month;
                                  r.dateOfCreation.year = pickedDate.year;
                                  dateInput.text = formattedDate;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Ingredientes",
                      style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(250, 66, 25, 8),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        style: const TextStyle(
                          fontFamily: 'Sitka',
                          color: Color.fromARGB(250, 66, 25, 8),
                        ),
                        initialValue: r.ingredients,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) {
                          setState(() {
                            r.ingredients = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Productos",
                      style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(250, 66, 25, 8),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        style: const TextStyle(
                          fontFamily: 'Sitka',
                          color: Color.fromARGB(250, 66, 25, 8),
                        ),
                        initialValue: r.products,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) {
                          setState(() {
                            r.products = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Pasos",
                      style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(250, 66, 25, 8),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        style: const TextStyle(
                          fontFamily: 'Sitka',
                          color: Color.fromARGB(250, 66, 25, 8),
                        ),
                        initialValue: r.steps,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) {
                          setState(() {
                            r.steps = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              left: 65,
              top: 560,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      for (i in imagesPath) {
                        setState(() {
                          r.captions
                              .add(Caption(id: -1, recepieId: -1, caption: i));
                        });
                      }

                      if (r.id == -1) {
                        db.insertRecepie(r);
                      } else {
                        db.updateRecepie(r);
                      }
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: SizedBox(
                            height: 30,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                ),
                                color: Color.fromARGB(255, 206, 140, 92),
                              ),
                              child: Text(
                                (r.id == -1)
                                    ? "Receta Creada"
                                    : "Receta Guardada",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(250, 168, 93, 48)),
                    ),
                    child: const Text(
                      "Guardar",
                      style: TextStyle(
                        color: Color.fromARGB(250, 236, 204, 180),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                        backgroundColor: Colors.transparent,
                        child: SizedBox(
                          height: 150,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                              color: Color.fromARGB(255, 206, 140, 92),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "¿Segur@ que deseas salir de la edición?\nCualquier cambio no guardado se perderá",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(250, 66, 25, 8),
                                    fontFamily: 'Sitka',
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        arrangeRecentRecepies(r);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => (widget
                                                        .pScreen ==
                                                    "myR")
                                                ? MyRecepies(
                                                    camera: widget.camera)
                                                : Home(camera: widget.camera),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Salir",
                                        style: TextStyle(
                                          color: Color.fromARGB(250, 66, 25, 8),
                                          fontFamily: 'Sitka',
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Seguir Editando",
                                        style: TextStyle(
                                          color: Color.fromARGB(250, 66, 25, 8),
                                          fontFamily: 'Sitka',
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(250, 168, 93, 48)),
                    ),
                    child: const Text(
                      "Salir",
                      style: TextStyle(
                        color: Color.fromARGB(250, 236, 204, 180),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
            backgroundColor: Colors.transparent,
            child: SizedBox(
              height: 150,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  color: Color.fromARGB(255, 206, 140, 92),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "¿Deseas elegir una foto de tu galería\no tomar una foto con tu cámara?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(250, 66, 25, 8),
                        fontFamily: 'Sitka',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            File? f = await pickImageFromCamera();
                            if (f == null) return;
                            setState(() {
                              imagesCarousel.add(Image.file(f));
                            });
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cámara",
                            style: TextStyle(
                              color: Color.fromARGB(250, 66, 25, 8),
                              fontFamily: 'Sitka',
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            File? f = await pickImageFromGallery();
                            if (f == null) return;
                            setState(() {
                              imagesCarousel.add(Image.file(f));
                            });
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Galería",
                            style: TextStyle(
                              color: Color.fromARGB(250, 66, 25, 8),
                              fontFamily: 'Sitka',
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      persistentFooterAlignment: AlignmentDirectional.topCenter,
    );
  }

  Future pickImageFromGallery() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? i = prefs.getInt("PictureNum");

    if (i == null) {
      prefs.setInt("PictureNum", 0);
    } else {
      i++;
      prefs.setInt("PictureNum", i);
    }

    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return null;

    try {
      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        imagesPath.add('${directory.path}/photo_$i.png');
        return File(pickedImage.path).copy('${directory.path}/photo_$i.png');
      }
    } catch (e) {
      return null;
    }
  }

  Future pickImageFromCamera() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? i = prefs.getInt("PictureNum");

    if (i == null) {
      prefs.setInt("PictureNum", 0);
    } else {
      i++;
      prefs.setInt("PictureNum", i);
    }

    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) return null;

    try {
      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        imagesPath.add('${directory.path}/photo_$i.png');
        return File(pickedImage.path).copy('${directory.path}/photo_$i.png');
      }
    } catch (e) {
      return null;
    }
  }

  arrangeRecentRecepies(Recepie r) async {
    if (r.id == -1) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (r.id == prefs.getInt("id0")) {
      return;
    }

    if (r.id == prefs.getInt("id1")) {
      prefs.setInt("id1", prefs.getInt("id0") as int);
      prefs.setInt("id0", r.id);

      return;
    }

    prefs.setInt("id2", prefs.getInt("id1") as int);
    prefs.setInt("id1", prefs.getInt("id0") as int);
    prefs.setInt("id0", r.id);
  }
}
