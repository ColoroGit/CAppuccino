import 'package:camera/camera.dart';
import 'package:cappuccino/models/barista_recepie.dart';
import 'package:cappuccino/models/recepie.dart';
import 'package:cappuccino/pages/home.dart';
import 'package:cappuccino/pages/my_opinion.dart';
import 'package:cappuccino/pages/my_recepies.dart';
import 'package:cappuccino/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBarista extends StatefulWidget {
  const MyBarista({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<StatefulWidget> createState() => _MyBaristaState();
}

class _MyBaristaState extends State<MyBarista> {
  DatabaseHelper db = DatabaseHelper.instance;
  List<BRecepie> br = [];

  loadBaristaRecepies() {
    BRecepie.loadBRecepies().then((value) {
      setState(() {
        br = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadBaristaRecepies();
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
        child: ListView(children: getBaristaRecepiesBanners()),
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
                color: Color.fromARGB(250, 66, 25, 8),
                size: 40,
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(
                              camera: widget.camera,
                            )));
              },
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/images/Selected_CoffeeSchool.png',
                height: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  getBaristaRecepiesBanners() {
    var banners = <Widget>[];

    for (int i = 0; i < br.length; i++) {
      banners.add(
        TextButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
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
                      Image.asset(br[i].mainCaption.caption),
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
                              br[i].title,
                              style: const TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(250, 66, 25, 8),
                              ),
                            ),
                            Text(
                              'Tiempo de prep.: ${br[i].timeOfPrep} mins',
                              style: const TextStyle(
                                color: Color.fromARGB(250, 66, 25, 8),
                                fontFamily: 'Sitka',
                              ),
                            ),
                            Text(
                              'Fecha de creación: ${br[i].dateOfCreation.day}/${br[i].dateOfCreation.month}/${br[i].dateOfCreation.year}',
                              style: const TextStyle(
                                color: Color.fromARGB(250, 66, 25, 8),
                                fontFamily: 'Sitka',
                              ),
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
                              br[i].ingredients,
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
                              br[i].products,
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
                              br[i].steps,
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
                          onPressed: () async {
                            Recepie r = await db.insertBRecepie(br[i]);
                            arrangeRecentRecepies(r);
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
                                    child: const Text(
                                      "Receta Añadida",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                    leading: Image.asset(br[i].mainCaption.caption),
                    title: Text(
                      br[i].title,
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
