import 'package:flutter/material.dart';
import 'home.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'LOG IN',
              style: TextStyle(
                  fontSize: 28, color: Color.fromARGB(250, 66, 25, 8)),
            ),
            SizedBox(
              width: 375,
              height: 300,
              child: Container(
                margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  color: Color.fromARGB(255, 206, 140, 92),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        obscureText: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(250, 236, 204, 180),
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(250, 66, 25, 8),
                            fontFamily: 'Sitka',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(250, 236, 204, 180),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(250, 66, 25, 8),
                            fontFamily: 'Sitka',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
                style: const ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(Size(125, 50)),
                  elevation: WidgetStatePropertyAll(5),
                  shadowColor:
                      WidgetStatePropertyAll(Color.fromARGB(250, 66, 25, 8)),
                  backgroundColor:
                      WidgetStatePropertyAll(Color.fromARGB(250, 168, 93, 48)),
                  foregroundColor: WidgetStatePropertyAll(
                      Color.fromARGB(250, 236, 204, 180)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                },
                child: const Text(
                  'Enter',
                  style: TextStyle(
                    color: Color.fromARGB(250, 236, 204, 180),
                    fontSize: 20,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
