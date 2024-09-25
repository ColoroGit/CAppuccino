import 'package:cappuccino/pages/log_in.dart';
import 'package:cappuccino/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(250, 168, 93, 48),
          title: const Text('CAppuccino'),
          actions: [
            PopupMenuButton(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset('assets/images/Logo.png', width: 50),
              ),
              onSelected: (value) => {
                if (value == "settings")
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Settings()))
                  }
                else if (value == "log out")
                  {
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
                        child: Icon(Icons.settings),
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
                          child: Icon(Icons.logout)),
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
          child: ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  color: Color.fromARGB(255, 206, 140, 92),
                ),
                child: ListTile(
                  leading: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      color: Color.fromARGB(255, 206, 140, 92),
                    ),
                    child: Image.asset(
                        'assets/images/Latte.png'), // recepie.caption
                  ),
                  title: const Text('Latte'), //recepie.title
                  subtitle: Text(loremIpsum(words: 7)), //recepie.description
                ),
              ),
            ],
          ),
        ));
  }
}
