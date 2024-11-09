import 'dart:async';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:camera/camera.dart';
import 'package:cappuccino/models/recepie.dart';
import 'package:cappuccino/pages/home.dart';
import 'package:cappuccino/pages/my_barista.dart';
import 'package:cappuccino/pages/my_opinion.dart';
import 'package:cappuccino/utils/database_helper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyRecepies extends StatefulWidget {
  const MyRecepies({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<StatefulWidget> createState() => _MyRecepiesState();
}

class _MyRecepiesState extends State<MyRecepies> {
  DatabaseHelper db = DatabaseHelper.instance;
  List<Recepie> recepies = [];

  refreshRecepies() {
    db.fetchAllRecepies().then((value) {
      setState(() {
        recepies = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    refreshRecepies();
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
                        Icons.settings,
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
                'Todavía no has creado Recetas',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(250, 66, 25, 8),
                ),
              )
            : ListView(children: getRecepiesBanners()),
      ),
      floatingActionButton: IconButton(
        onPressed: () {/*Crear receta de 0*/},
        icon: const Icon(Icons.add),
      ),
      persistentFooterButtons: [
        Container(
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
                onPressed: () {},
                icon: Image.asset(
                  'assets/images/Selected_Search.png',
                  height: 35,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.home_filled,
                  color: Color.fromARGB(250, 66, 25, 8),
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home(camera: widget.camera)));
                },
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
      ],
    );
  }

  getRecepiesBanners() {
    final banners = <Widget>[];

    for (int i = 0; i < recepies.length; i++) {
      List<Image> imagesCarousel = List.empty(growable: true);

      for (int j = 0; j < recepies[i].captions.length; j++) {
        imagesCarousel.add(Image.asset(recepies[i].captions[j].caption));
      }

      banners.add(
        TextButton(
          onPressed: () {
            arrangeRecentRecepies(recepies[i]);
            showDialogSuper<String>(
              context: context,
              onDismissed: (v) {
                if (v == null) {
                  db.updateRecepie(recepies[i]);
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
                            // falta botón X
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
                                    'Prep Time: ${recepies[i].timeOfPrep} mins',
                                    style: const TextStyle(
                                      color: Color.fromARGB(250, 66, 25, 8),
                                      fontFamily: 'Sitka',
                                    ),
                                  ),
                                  Text(
                                    'Date of Creation: ${recepies[i].dateOfCreation.day}/${recepies[i].dateOfCreation.month}/${recepies[i].dateOfCreation.year}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(250, 66, 25, 8),
                                      fontFamily: 'Sitka',
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Times Prepared: ",
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
                                    'Ingredients',
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
                                    'Products',
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
                                    'Steps',
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
                                onPressed: () {},
                                child: const Icon(Icons.share),
                              ),
                              FloatingActionButton.small(
                                onPressed: () {},
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
                                              MainAxisAlignment.center,
                                          children: [
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
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextButton(
                                                  onPressed: () async => await db
                                                      .deleteRecepie(
                                                          recepies[i])
                                                      .then((v) {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => Home(
                                                                    camera: widget
                                                                        .camera)));
                                                      } as FutureOr<void>
                                                          Function(int value)),
                                                  child: const Text(
                                                    "Si",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          250, 66, 25, 8),
                                                      fontFamily: 'Sitka',
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
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
                    leading: Image.asset(recepies[i].captions[0].caption),
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
    setState(() {
      prefs.setInt("id2", prefs.getInt("id1") as int);
      prefs.setInt("id1", prefs.getInt("id0") as int);
      prefs.setInt("id0", r.id);
    });
  }
}
