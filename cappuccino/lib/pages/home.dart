import 'package:cappuccino/models/coffee_school.dart';
import 'package:cappuccino/models/comment.dart';
import 'package:cappuccino/models/product.dart';
import 'package:cappuccino/models/recepie.dart';
import 'package:cappuccino/models/user.dart';
import 'package:cappuccino/pages/browse.dart';
import 'package:cappuccino/pages/log_in.dart';
import 'package:cappuccino/pages/profile_favorites.dart';
import 'package:cappuccino/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User user1 = User(id: 1, name: 'Alonso', password: '1234', age: 22);
  User user2 = User(id: 2, name: 'Fernanda', password: 'aaaa', age: 21);
  User user3 = User(id: 3, name: 'Tomás', password: 'wxyz', age: 21);

  final List<User> users = <User>[];

  Recepie recepie1 = Recepie(
    id: 1,
    caption: 'assets/images/Latte.png',
    title: "Latte",
    like: true,
    rating: 4.6,
    timeOfPrep: 3,
    servings: 1,
    details: loremIpsum(words: 7),
    steps: <String>[
      loremIpsum(words: 15),
      loremIpsum(words: 15),
    ],
    dateOfCreation: DateTime(2024, 8, 9),
  );

  Recepie recepie2 = Recepie(
    id: 2,
    caption: 'assets/images/Macchiato.png',
    title: "Macchiato",
    like: true,
    rating: 4.2,
    timeOfPrep: 5,
    servings: 1,
    details: loremIpsum(words: 8),
    steps: <String>[
      loremIpsum(words: 10),
      loremIpsum(words: 15),
      loremIpsum(words: 7),
    ],
    dateOfCreation: DateTime(2022, 5, 12),
  );

  Recepie recepie3 = Recepie(
    id: 3,
    caption: 'assets/images/Cappuccino.png',
    title: "Cappuccino",
    like: false,
    rating: 4.8,
    timeOfPrep: 8,
    servings: 1,
    details: loremIpsum(words: 15),
    steps: <String>[
      loremIpsum(words: 10),
      loremIpsum(words: 7),
    ],
    dateOfCreation: DateTime(2024, 9, 5),
  );

  Recepie recepie4 = Recepie(
    id: 4,
    caption: 'assets/images/Flat_White.png',
    title: "Flat White",
    like: true,
    rating: 5.0,
    timeOfPrep: 12,
    servings: 1,
    details: loremIpsum(words: 11),
    steps: <String>[
      loremIpsum(words: 12),
      loremIpsum(words: 8),
      loremIpsum(words: 7),
      loremIpsum(words: 3),
    ],
    dateOfCreation: DateTime(2020, 2, 20),
  );

  Recepie recepie5 = Recepie(
    id: 5,
    caption: 'assets/images/Mocha.png',
    title: "Mocha",
    like: false,
    rating: 3.8,
    timeOfPrep: 5,
    servings: 2,
    details: loremIpsum(words: 10),
    steps: <String>[
      loremIpsum(words: 10),
      loremIpsum(words: 8),
    ],
    dateOfCreation: DateTime(2023, 12, 21),
  );

  final recepies = <Recepie>[];

  CoffeeSchool cs1 = CoffeeSchool(
    id: 1,
    name: 'Milk',
    caption: 'assets/images/Milk.png',
    like: true,
    description: loremIpsum(words: 10),
  );

  CoffeeSchool cs2 = CoffeeSchool(
    id: 2,
    name: 'Blender',
    caption: 'assets/images/Logo.png',
    like: false,
    description: loremIpsum(words: 12),
  );

  CoffeeSchool cs3 = CoffeeSchool(
    id: 3,
    name: 'Cocoa',
    caption: 'assets/images/Cocoa.png',
    like: true,
    description: loremIpsum(words: 8),
  );

  final coffeeSchools = <CoffeeSchool>[];

  Comment comment1 = Comment(
    id: 1,
    text: loremIpsum(words: 15),
  );

  Comment comment2 = Comment(
    id: 2,
    text: loremIpsum(words: 10),
  );

  Comment comment3 = Comment(
    id: 3,
    text: loremIpsum(words: 12),
  );

  final List<Comment> comments = <Comment>[];

  Product p1 = Product(id: 1, name: 'Milk');
  Product p2 = Product(id: 2, name: 'Cocoa Powder');
  Product p3 = Product(id: 3, name: 'Coffee Machine');
  Product p4 = Product(id: 4, name: 'Ground Espresso');

  final List<Product> products = <Product>[];

  bool initailized = false;

  @override
  Widget build(BuildContext context) {
    initializeClasses();

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
        child: ListView(children: getRecepiesBanners()),
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

  void initializeClasses() {
    if (!initailized) {
      users.add(user1);
      users.add(user2);
      users.add(user3);

      recepies.add(recepie1);
      recepies.add(recepie2);
      recepies.add(recepie3);
      recepies.add(recepie4);
      recepies.add(recepie5);

      coffeeSchools.add(cs1);
      coffeeSchools.add(cs2);
      coffeeSchools.add(cs3);

      comments.add(comment1);
      comments.add(comment2);
      comments.add(comment3);

      products.add(p1);
      products.add(p2);
      products.add(p3);
      products.add(p4);

      recepie1.creator = user1;
      recepie2.creator = user2;
      recepie3.creator = user3;
      recepie4.creator = user3;
      recepie5.creator = user2;

      comment1.owner = user1;
      comment2.owner = user2;
      comment3.owner = user3;

      for (int i = 0; i < recepies.length; i++) {
        for (int j = 0; j < products.length; j++) {
          recepies[i].productsNeeded.add(products[j]);
        }
        for (int k = 0; k < comments.length; k++) {
          if (recepies[i].creator.name != comments[k].owner.name) {
            recepies[i].comments.add(comments[k]);
          }
        }
        for (int l = 0; l < coffeeSchools.length; l++) {
          recepies[i].coffeeSchools.add(coffeeSchools[l]);
        }
      }

      for (int i = 0; i < coffeeSchools.length; i++) {
        for (int j = 0; j < recepies.length; j++) {
          coffeeSchools[i].lessons.add(recepies[j]);
        }
      }

      initailized = true;
    }
  }

  getRecepiesBanners() {
    final banners = <Widget>[];

    for (int i = 0; i < recepies.length; i++) {
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
                        ListBody(children: getProductsNeeded(recepies[i])),
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

  getProductsNeeded(Recepie r) {
    final products = <Widget>[];

    for (int i = 0; i < r.productsNeeded.length; i++) {
      products.add(
        Text(
          ' - ${r.productsNeeded[i].name}',
          style: const TextStyle(
            color: Color.fromARGB(250, 66, 25, 8),
            fontFamily: 'Sitka',
          ),
        ),
      );
    }

    return products;
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
