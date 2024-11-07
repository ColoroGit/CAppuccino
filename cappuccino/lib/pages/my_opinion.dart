import 'package:cappuccino/models/question.dart';
import 'package:flutter/material.dart';

class MyOpinion extends StatefulWidget {
  const MyOpinion({super.key});

  @override
  State<StatefulWidget> createState() => _MyOpinionState();
}

class _MyOpinionState extends State<MyOpinion> {
  List<Question> questions = List.empty(growable: true);
  var values = <int>[];

  loadQuestions() {
    Question.loadQuestions().then((value) {
      setState(() {
        questions = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadQuestions();
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
      ),
      body: Center(
        child: ListView(children: getQuestions()),
      ),
    );
  }

  getQuestions() {
    var qBanners = <Widget>[];
    values = List.filled(questions.length, 0);

    for (int i = 0; i < questions.length; i++) {
      qBanners.add(
        SizedBox(
          width: 375,
          height: 300,
          child: Container(
            margin: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              color: Color.fromARGB(255, 206, 140, 92),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    questions[i].title,
                    style: const TextStyle(
                      color: Color.fromARGB(250, 66, 25, 8),
                      fontFamily: 'Sitka',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 75,
                        child: Text(
                          questions[i].min,
                          textAlign: TextAlign.center,
                          textWidthBasis: TextWidthBasis.parent,
                          style: const TextStyle(
                            color: Color.fromARGB(250, 66, 25, 8),
                            fontFamily: 'Sitka',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Slider(
                          value: values[i].toDouble(),
                          divisions: 5,
                          label: "${values[i]}",
                          min: 0,
                          max: 5,
                          onChanged: (double v) {
                            setState(() {
                              values[i] = v.round();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 75,
                        child: Text(
                          questions[i].max,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color.fromARGB(250, 66, 25, 8),
                            fontFamily: 'Sitka',
                            fontSize: 12,
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
      );
    }

    return qBanners;
  }
}
