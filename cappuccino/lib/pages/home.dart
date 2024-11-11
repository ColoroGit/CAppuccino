import 'dart:io';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:camera/camera.dart';
import 'package:cappuccino/models/recepie.dart';
import 'package:cappuccino/pages/edit_recepie.dart';
import 'package:cappuccino/pages/my_barista.dart';
import 'package:cappuccino/pages/my_opinion.dart';
import 'package:cappuccino/pages/my_recepies.dart';
import 'package:cappuccino/utils/database_helper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper db = DatabaseHelper.instance;
  List<int> recentRecepiesIDs = List.filled(3, -1);
  List<Recepie> recepies = [];

  @override
  void initState() {
    super.initState();
    _loadSavedValue();
  }

  // Function to load saved value from SharedPreferences
  void _loadSavedValue() async {
    if (!mounted) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    recepies = [];

    if (prefs.getInt("id0") == null) {
      prefs.setInt("id0", -1);
      prefs.setInt("id1", -1);
      prefs.setInt("id2", -1);
    }

    setState(() {
      for (int i = 0; i < 3; i++) {
        // ignore: unnecessary_brace_in_string_interps
        recentRecepiesIDs[i] = prefs.getInt("id${i}") ?? -1;
      }
    });

    refreshRecepies();
  }

  refreshRecepies() async {
    for (int i = 0; i < 3; i++) {
      var rrid = recentRecepiesIDs[i];

      if (rrid == -1) break;

      Recepie r = await db.fetchRecepie(rrid);

      setState(() {
        recepies.add(r);
      });
    }
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
        actions: [
          PopupMenuButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            color: const Color.fromARGB(250, 236, 204, 180),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset('assets/images/Logo.png', width: 70),
              ),
            ),
            onSelected: (value) => {
              if (value == "Mi Opinión")
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyOpinion(),
                    ),
                  )
                }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: "Mi Opinión",
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.star,
                        color: Color.fromARGB(250, 66, 25, 8),
                      ),
                    ),
                    Text(
                      'Mi Opinión',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: recepies.isEmpty
            ? const Text(
                'Tus recetas más recientes aparecerán aquí',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(250, 66, 25, 8),
                ),
              )
            : ListView(
                children: getRecentRecepiesBanners(),
              ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(250, 168, 93, 48),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyRecepies(camera: widget.camera)));
              },
              icon: Image.asset(
                'assets/images/Search.png',
                height: 35,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.home_filled,
                color: Color.fromARGB(250, 236, 204, 180),
                size: 40,
              ),
              onPressed: () {},
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyBarista(camera: widget.camera)));
              },
              icon: Image.asset(
                'assets/images/CoffeeSchool.png',
                height: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  getRecentRecepiesBanners() {
    final banners = <Widget>[];

    for (int i = 0; i < recepies.length; i++) {
      List<Image> imagesCarousel =
          List.empty(growable: true); //Something's off here aswell

      for (int j = 0; j < recepies[i].captions.length; j++) {
        if (recepies[i].captions[j].caption.startsWith("assets")) {
          imagesCarousel.add(Image.asset(recepies[i].captions[j].caption));
        } else {
          imagesCarousel.add(Image.file(File(recepies[i].captions[j].caption)));
        }
      }

      banners.add(
        TextButton(
          onPressed: () {
            arrangeRecentRecepies(recepies[i]);
            showDialogSuper<String>(
              context: context,
              onDismissed: (v) async {
                if (v == null) {
                  await db.updateRecepie(recepies[i]);
                  _loadSavedValue();
                }
              },
              builder: (context) {
                return StatefulBuilder(builder: (context, setState) {
                  return Dialog(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    backgroundColor: const Color.fromARGB(255, 206, 140, 92),
                    surfaceTintColor: const Color.fromARGB(250, 66, 25, 8),
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
                                enableInfiniteScroll: true,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10,
                                bottom: 10,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    recepies[i].title,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      color: Color.fromARGB(250, 66, 25, 8),
                                    ),
                                  ),
                                  Text(
                                    'Tiempo de prep.: ${recepies[i].timeOfPrep} mins',
                                    style: const TextStyle(
                                      color: Color.fromARGB(250, 66, 25, 8),
                                      fontFamily: 'Sitka',
                                    ),
                                  ),
                                  Text(
                                    'Fecha de creación: ${recepies[i].dateOfCreation.day}/${recepies[i].dateOfCreation.month}/${recepies[i].dateOfCreation.year}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(250, 66, 25, 8),
                                      fontFamily: 'Sitka',
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Veces preparada: ",
                                        style: TextStyle(
                                          color: Color.fromARGB(250, 66, 25, 8),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            recepies[i].timesPrepared--;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.remove,
                                          color: Color.fromARGB(250, 66, 25, 8),
                                        ),
                                      ),
                                      Text("${recepies[i].timesPrepared}"),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            recepies[i].timesPrepared++;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          color: Color.fromARGB(250, 66, 25, 8),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Ingredientes',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Color.fromARGB(250, 66, 25, 8),
                                    ),
                                  ),
                                  Text(
                                    recepies[i].ingredients,
                                    style: const TextStyle(
                                      color: Color.fromARGB(250, 66, 25, 8),
                                      fontFamily: 'Sitka',
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Productos',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Color.fromARGB(250, 66, 25, 8),
                                    ),
                                  ),
                                  Text(
                                    recepies[i].products,
                                    style: const TextStyle(
                                      color: Color.fromARGB(250, 66, 25, 8),
                                      fontFamily: 'Sitka',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Pasos',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Color.fromARGB(250, 66, 25, 8),
                                    ),
                                  ),
                                  Text(
                                    recepies[i].steps,
                                    style: const TextStyle(
                                      color: Color.fromARGB(250, 66, 25, 8),
                                      fontFamily: 'Sitka',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          left: 230,
                          top: 2,
                          child: Column(
                            children: [
                              FloatingActionButton.small(
                                onPressed: () {
                                  // List<XFile> pictures = [];
                                  // for (var c in recepies[i].captions) {
                                  //   pictures.add(XFile(c.caption));
                                  // }
                                  // No deja compartir archivos
                                  Share.share(
                                      "Admira mi súper receta de café!!\n\n${recepies[i].title}\nCreada el ${recepies[i].dateOfCreation.day} del ${recepies[i].dateOfCreation.month} del ${recepies[i].dateOfCreation.year}\n\nToma tan solo ${recepies[i].timeOfPrep} minutos hacerla, y yo ya la he hecho ${recepies[i].timesPrepared} veces\n\nIngredientes:\n\n${recepies[i].ingredients}\n\nProductos:\n\n${recepies[i].products}\n\nPasos:\n\n${recepies[i].steps}\n\nCuéntame qué te parece :D");
                                },
                                child: const Icon(Icons.share),
                              ),
                              FloatingActionButton.small(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditRecepie(
                                        camera: widget.camera,
                                        recepie: recepies[i],
                                        pScreen: "home",
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(Icons.edit),
                              ),
                              FloatingActionButton.small(
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
                                          color:
                                              Color.fromARGB(255, 206, 140, 92),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "¿Segur@ que deseas eliminar\nesta receta?",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    250, 66, 25, 8),
                                                fontFamily: 'Sitka',
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await db.deleteRecepie(
                                                        recepies[i]);
                                                    var prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    prefs.setInt(
                                                        "id0",
                                                        prefs.getInt("id1")
                                                            as int);
                                                    prefs.setInt(
                                                        "id1",
                                                        prefs.getInt("id2")
                                                            as int);
                                                    prefs.setInt("id2", -1);
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Home(
                                                                camera: widget
                                                                    .camera),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text(
                                                    "Si",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          250, 66, 25, 8),
                                                      fontFamily: 'Sitka',
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    "No",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          250, 66, 25, 8),
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
                                child: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              color: Color.fromARGB(255, 206, 140, 92),
            ),
            child: SizedBox(
              width: 360,
              child: Column(
                children: [
                  ListTile(
                    leading:
                        (recepies[i].captions[0].caption.startsWith("assets"))
                            ? Image.asset(recepies[i].captions[0].caption)
                            : Image.file(File(recepies[i].captions[0].caption)),
                    title: Text(
                      recepies[i].title,
                      style: const TextStyle(
                        color: Color.fromARGB(250, 66, 25, 8),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return banners;
  }

  arrangeRecentRecepies(Recepie r) async {
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
