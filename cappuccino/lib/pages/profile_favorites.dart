import 'package:cappuccino/models/coffee_school.dart';
import 'package:cappuccino/models/recepie.dart';
import 'package:cappuccino/pages/browse.dart';
import 'package:cappuccino/pages/home.dart';
import 'package:cappuccino/pages/log_in.dart';
import 'package:cappuccino/pages/profile_coffee_schools.dart';
import 'package:cappuccino/pages/profile_friends.dart';
import 'package:cappuccino/pages/settings.dart';
import 'package:flutter/material.dart';

class ProfileFavorites extends StatefulWidget {
  const ProfileFavorites(
      {super.key, required this.recepies, required this.coffeeSchools});

  final List<Recepie> recepies;
  final List<CoffeeSchool> coffeeSchools;

  @override
  State<StatefulWidget> createState() =>
      // ignore: no_logic_in_create_state
      _ProfileFavoritesState(recepies: recepies, coffeeSchools: coffeeSchools);
}

class _ProfileFavoritesState extends State<ProfileFavorites> {
  _ProfileFavoritesState({required this.recepies, required this.coffeeSchools});

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
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/Heart.png',
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
                children: getLikedRecepieBanners(),
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

  getLikedRecepieBanners() {
    final banners = <Widget>[];

    for (int i = 0; i < recepies.length; i++) {
      if (!recepies[i].like) continue;

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
                  // falta botón X
                  Image.asset(recepies[i].caption),
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
                              recepies[i].title,
                              style: const TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(250, 66, 25, 8),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                (recepies[i].like)
                                    ? 'assets/images/Selected_Heart.png'
                                    : 'assets/images/Heart.png',
                                height: 25,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${recepies[i].rating}',
                                  style: const TextStyle(
                                    color: Color.fromARGB(250, 66, 25, 8),
                                  ),
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Color.fromARGB(250, 66, 25, 8),
                                ),
                              ],
                            ),
                            Text(
                              'prep time: ${recepies[i].timeOfPrep} mins',
                              style: const TextStyle(
                                color: Color.fromARGB(250, 66, 25, 8),
                              ),
                            ),
                            Text(
                              'servings: ${recepies[i].servings}',
                              style: const TextStyle(
                                color: Color.fromARGB(250, 66, 25, 8),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'schools: ',
                              style: TextStyle(
                                color: Color.fromARGB(250, 66, 25, 8),
                              ),
                            ),
                            Row(
                              children: getShcools(recepies[i]),
                            )
                          ],
                        ),
                        Text(
                          recepies[i].details,
                          style: const TextStyle(
                            color: Color.fromARGB(250, 66, 25, 8),
                            fontFamily: 'Sitka',
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Products Needed',
                          style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(250, 66, 25, 8),
                          ),
                        ),
                        const ListBody(
                          children: [
                            Text(
                              '- 18g ground espresso',
                              style: TextStyle(
                                color: Color.fromARGB(250, 66, 25, 8),
                                fontFamily: 'Sitka',
                              ),
                            ),
                            Text(
                              '- 150ml Milk',
                              style: TextStyle(
                                color: Color.fromARGB(250, 66, 25, 8),
                                fontFamily: 'Sitka',
                              ),
                            ),
                            Text(
                              '- Coffee Machine',
                              style: TextStyle(
                                color: Color.fromARGB(250, 66, 25, 8),
                                fontFamily: 'Sitka',
                              ),
                            ),
                            Text(
                              '- Cocoa Powder',
                              style: TextStyle(
                                color: Color.fromARGB(250, 66, 25, 8),
                                fontFamily: 'Sitka',
                              ),
                            ),
                          ],
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
                        ListBody(
                          children: getSteps(recepies[i]),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Creator',
                          style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(250, 66, 25, 8),
                          ),
                        ),
                        Center(
                          child: ListTile(
                            leading: const Icon(
                              Icons.account_circle,
                              size: 75,
                              color: Color.fromARGB(250, 66, 25, 8),
                            ),
                            title: Text(
                              recepies[i].creator.name,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(250, 66, 25, 8),
                              ),
                            ),
                            subtitle: Text(
                              'date of creation: ${recepies[i].dateOfCreation.day}/${recepies[i].dateOfCreation.month}/${recepies[i].dateOfCreation.year}',
                              style: const TextStyle(
                                color: Color.fromARGB(250, 66, 25, 8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Rate',
                          style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(250, 66, 25, 8),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 40,
                              onPressed: () {},
                              icon: const Icon(
                                Icons.star,
                                color: Color.fromARGB(250, 66, 25, 8),
                              ),
                            ),
                            IconButton(
                              iconSize: 40,
                              onPressed: () {},
                              icon: const Icon(
                                Icons.star,
                                color: Color.fromARGB(250, 66, 25, 8),
                              ),
                            ),
                            IconButton(
                              iconSize: 40,
                              onPressed: () {},
                              icon: const Icon(
                                Icons.star,
                                color: Color.fromARGB(250, 66, 25, 8),
                              ),
                            ),
                            IconButton(
                              iconSize: 40,
                              onPressed: () {},
                              icon: const Icon(
                                Icons.star,
                                color: Color.fromARGB(250, 66, 25, 8),
                              ),
                            ),
                            IconButton(
                              iconSize: 40,
                              onPressed: () {},
                              icon: const Icon(
                                Icons.star,
                                color: Color.fromARGB(250, 66, 25, 8),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Comment',
                          style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(250, 66, 25, 8),
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          width: 300,
                          child: ListView(
                            children: getComments(recepies[i]),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(250, 236, 204, 180),
                              labelText: 'Write Your Comment',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(250, 66, 25, 8),
                                fontFamily: 'Sitka',
                              )),
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
                    leading: Image.asset(
                      recepies[i].caption,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          recepies[i].title,
                          style: const TextStyle(
                            color: Color.fromARGB(250, 66, 25, 8),
                            fontSize: 20,
                          ),
                        ),
                        Image.asset(
                          (recepies[i].like)
                              ? 'assets/images/Selected_Heart.png'
                              : 'assets/images/Heart.png',
                          height: 25,
                        ),
                      ],
                    ),
                    subtitle: Text(
                      recepies[i].details,
                      style: const TextStyle(
                        color: Color.fromARGB(250, 66, 25, 8),
                        fontFamily: 'Sitka',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${recepies[i].rating}',
                              style: const TextStyle(
                                color: Color.fromARGB(250, 66, 25, 8),
                              ),
                            ),
                            const Icon(
                              Icons.star,
                              color: Color.fromARGB(250, 66, 25, 8),
                            ),
                          ],
                        ),
                      ),
                    ],
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

  getShcools(Recepie r) {
    final schools = <Widget>[];

    for (int i = 0; i < r.coffeeSchools.length; i++) {
      schools.add(
        TextButton(
          style: const ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(Color.fromARGB(250, 168, 93, 48)),
          ),
          onPressed: () {},
          child: Text(
            r.coffeeSchools[i].name,
            style: const TextStyle(color: Color.fromARGB(250, 236, 204, 180)),
          ),
        ),
      );
    }

    return schools;
  }

  getSteps(Recepie r) {
    final steps = <Widget>[];

    for (int i = 0; i < r.steps.length; i++) {
      steps.add(
        Text(
          '$i. ${r.steps[i]}',
          style: const TextStyle(
            color: Color.fromARGB(250, 66, 25, 8),
            fontFamily: 'Sitka',
          ),
        ),
      );
    }

    return steps;
  }

  getComments(Recepie r) {
    final comments = <Widget>[];

    for (int i = 0; i < r.comments.length; i++) {
      comments.add(
        Padding(
          padding: const EdgeInsets.only(
            top: 5.0,
            bottom: 5.0,
          ),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                color: Color.fromARGB(250, 168, 93, 48)),
            child: ListTile(
              leading: const Icon(
                Icons.account_circle,
                size: 50,
                color: Color.fromARGB(250, 236, 204, 180),
              ),
              title: Text(
                r.comments[i].owner.name,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(250, 236, 204, 180),
                ),
              ),
              subtitle: Text(
                r.comments[i].text,
                style: const TextStyle(
                  color: Color.fromARGB(250, 236, 204, 180),
                  fontFamily: 'Sitka',
                ),
              ),
            ),
          ),
        ),
      );
    }

    return comments;
  }
}
