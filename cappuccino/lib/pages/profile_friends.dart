import 'package:cappuccino/models/coffee_school.dart';
import 'package:cappuccino/models/recepie.dart';
import 'package:cappuccino/pages/browse.dart';
import 'package:cappuccino/pages/home.dart';
import 'package:cappuccino/pages/log_in.dart';
import 'package:cappuccino/pages/profile_coffee_schools.dart';
import 'package:cappuccino/pages/profile_favorites.dart';
import 'package:cappuccino/pages/settings.dart';
import 'package:flutter/material.dart';

class ProfileFriends extends StatefulWidget {
  const ProfileFriends(
      {super.key, required this.recepies, required this.coffeeSchools});

  final List<Recepie> recepies;
  final List<CoffeeSchool> coffeeSchools;

  @override
  State<StatefulWidget> createState() =>
      // ignore: no_logic_in_create_state
      _ProfileFriendsState(recepies: recepies, coffeeSchools: coffeeSchools);
}

class _ProfileFriendsState extends State<ProfileFriends> {
  _ProfileFriendsState({required this.recepies, required this.coffeeSchools});

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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 206, 140, 92),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 300,
                        child: ListTile(
                          leading: Icon(
                            Icons.account_circle_rounded,
                            size: 100,
                            color: Color.fromARGB(250, 66, 25, 8),
                          ),
                          title: Text(
                            'Username',
                            style: TextStyle(
                              fontSize: 22,
                              color: Color.fromARGB(250, 66, 25, 8),
                            ),
                          ),
                          subtitle: Text(
                            'age: XX',
                            style: TextStyle(
                              color: Color.fromARGB(250, 66, 25, 8),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit_square,
                              color: Color.fromARGB(250, 66, 25, 8),
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
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
                        icon: Image.asset(
                          'assets/images/Selected_Heart.png',
                          height: 35,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileCoffeeSchools(
                                        recepies: recepies,
                                        coffeeSchools: coffeeSchools,
                                      )));
                        },
                        icon: Image.asset(
                          'assets/images/CoffeeSchool.png',
                          height: 35,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.people_rounded,
                          size: 40,
                          color: Color.fromARGB(250, 236, 204, 180),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 490,
              width: 400,
              child: Center(
                child: Text(
                  'This Feature isnt available yet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(250, 66, 25, 8),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(250, 168, 93, 48),
        child: const Icon(
          Icons.add,
          size: 50,
          color: Color.fromARGB(250, 236, 204, 180),
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
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Browse(
                                recepies: recepies,
                                coffeeSchools: coffeeSchools,
                              )));
                },
                icon: Image.asset(
                  'assets/images/Search.png',
                  height: 35,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.account_circle,
                  // size: 50,
                  color: Color.fromARGB(250, 236, 204, 180),
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
