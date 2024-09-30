import 'package:cappuccino/models/coffee_school.dart';
import 'package:cappuccino/models/recepie.dart';
import 'package:cappuccino/pages/browse.dart';
import 'package:cappuccino/pages/home.dart';
import 'package:cappuccino/pages/log_in.dart';
import 'package:cappuccino/pages/profile_favorites.dart';
import 'package:cappuccino/pages/profile_friends.dart';
import 'package:cappuccino/pages/settings.dart';
import 'package:flutter/material.dart';

class ProfileCoffeeSchools extends StatefulWidget {
  const ProfileCoffeeSchools(
      {super.key, required this.recepies, required this.coffeeSchools});

  final List<Recepie> recepies;
  final List<CoffeeSchool> coffeeSchools;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _ProfileCoffeeSchoolsState(
      recepies: recepies, coffeeSchools: coffeeSchools);
}

class _ProfileCoffeeSchoolsState extends State<ProfileCoffeeSchools> {
  _ProfileCoffeeSchoolsState(
      {required this.recepies, required this.coffeeSchools});

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
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/Selected_CoffeeSchool.png',
                          height: 35,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileFriends(
                                        recepies: recepies,
                                        coffeeSchools: coffeeSchools,
                                      )));
                        },
                        icon: const Icon(
                          Icons.people_rounded,
                          color: Color.fromARGB(250, 66, 25, 8),
                          size: 40,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 490,
              width: 400,
              child: ListView(
                children: getLikedCoffeeSchools(),
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

  getLikedCoffeeSchools() {
    final banners = <Widget>[];

    for (int i = 0; i < coffeeSchools.length; i++) {
      if (!coffeeSchools[i].like) continue;

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
              child: ListView(
                children: [
                  Image.asset(coffeeSchools[i].caption),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${coffeeSchools[i].name} School',
                              style: const TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(250, 66, 25, 8),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                (coffeeSchools[i].like)
                                    ? 'assets/images/Selected_Heart.png'
                                    : 'assets/images/Heart.png',
                                height: 25,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${coffeeSchools[i].lessons.length} recepies',
                          style: const TextStyle(
                            color: Color.fromARGB(250, 66, 25, 8),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          coffeeSchools[i].description,
                          style: const TextStyle(
                            color: Color.fromARGB(250, 66, 25, 8),
                            fontFamily: 'Sitka',
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 300,
                          height: 300,
                          child: GridView.count(
                            crossAxisCount: 2,
                            children: getLessonsCards(coffeeSchools[i]),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          child: Container(
            height: 55,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 206, 140, 92),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${coffeeSchools[i].name} School',
                    style: const TextStyle(
                      color: Color.fromARGB(250, 66, 25, 8),
                      fontSize: 20,
                    ),
                  ),
                  Image.asset(
                    'assets/images/Selected_Heart.png',
                    height: 25,
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

  getLessonsCards(CoffeeSchool cs) {
    final cards = <Widget>[];

    for (int i = 0; i < cs.lessons.length; i++) {
      cards.add(
        SizedBox(
          height: 150,
          width: 150,
          child: TextButton(
            onPressed: () {},
            child: Image.asset(cs.lessons[i].caption),
          ),
        ),
      );
    }

    return cards;
  }
}
