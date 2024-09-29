import 'package:cappuccino/models/coffee_school.dart';
import 'package:cappuccino/models/recepie.dart';
import 'package:cappuccino/pages/home.dart';
import 'package:cappuccino/pages/log_in.dart';
import 'package:cappuccino/pages/profile_favorites.dart';
import 'package:cappuccino/pages/settings.dart';
import 'package:flutter/material.dart';

class Browse extends StatelessWidget {
  const Browse(
      {super.key, required this.recepies, required this.coffeeSchools});

  final List<Recepie> recepies;
  final List<CoffeeSchool> coffeeSchools;

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
              if (value == "settings")
                {
                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Settings(
                                recepies: recepies,
                                coffeeSchools: coffeeSchools,
                              )))
                }
              else if (value == "log out")
                {
                  Navigator.pop(context),
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LogIn()))
                }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: "settings",
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
                      'Settings',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: "log out",
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.logout,
                          color: Color.fromARGB(250, 66, 25, 8),
                        )),
                    Text(
                      'Log Out',
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
        child: Column(
          children: [
            Container(
              width: 360,
              height: 50,
              decoration: const BoxDecoration(
                color: Color.fromARGB(250, 66, 25, 8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 250,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 15, right: 5),
                          child: TextField(
                            obscureText: false,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              fillColor: Color.fromARGB(250, 236, 204, 180),
                              labelText: '',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(250, 66, 25, 8),
                                fontFamily: 'Sitka',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/Selected_Search.png',
                        height: 25,
                      ),
                    ],
                  ),
                  PopupMenuButton(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    icon: const Icon(
                      Icons.filter_alt,
                      color: Color.fromARGB(250, 236, 204, 180),
                      size: 35,
                    ),
                    color: const Color.fromARGB(250, 236, 204, 180),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      const PopupMenuItem(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.search,
                                color: Color.fromARGB(250, 66, 25, 8),
                              ),
                            ),
                            Text('Recepies'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.school,
                                color: Color.fromARGB(250, 66, 25, 8),
                              ),
                            ),
                            Text('Coffe Schools'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.account_circle,
                                color: Color.fromARGB(250, 66, 25, 8),
                              ),
                            ),
                            Text('Users'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 600,
              width: 400,
              child: GridView.count(
                crossAxisCount: 2,
                children: getRecepiesCards(),
              ),
            ),
          ],
        ),
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
                icon: const Icon(
                  Icons.home_filled,
                  color: Color.fromARGB(250, 66, 25, 8),
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                },
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/images/Selected_Search.png',
                  height: 35,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileFavorites(
                                recepies: recepies,
                                coffeeSchools: coffeeSchools,
                              )));
                },
                icon: const Icon(
                  Icons.account_circle,
                  color: Color.fromARGB(250, 66, 25, 8),
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getRecepiesCards() {
    final cards = <Widget>[];

    for (int i = 0; i < recepies.length; i++) {
      cards.add(
        SizedBox(
          height: 150,
          width: 150,
          child: TextButton(
            onPressed: () {},
            child: Image.asset(recepies[i].caption),
          ),
        ),
      );
    }

    return cards;
  }
}
