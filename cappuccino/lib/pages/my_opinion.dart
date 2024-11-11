import 'package:cappuccino/models/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class MyOpinion extends StatefulWidget {
  const MyOpinion({super.key});

  @override
  State<StatefulWidget> createState() => _MyOpinionState();
}

class _MyOpinionState extends State<MyOpinion> {
  List<Question> questions = List.empty(growable: true);
  var values = List.filled(9, 0);
  String name = "";
  String relation = "";
  int groupValue = 0;
  String group = "";

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

    //datos de la persona
    qBanners.add(Column(
      children: [
        const Text(
          "Ingresa tu Nombre y Apellido",
          style: TextStyle(
            color: Color.fromARGB(250, 66, 25, 8),
            fontFamily: 'Sitka',
            fontSize: 15,
          ),
        ),
        SizedBox(
          width: 300,
          child: TextField(
            style: const TextStyle(
              fontFamily: 'Sitka',
              color: Color.fromARGB(250, 66, 25, 8),
            ),
            onChanged: (s) {
              name = s;
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "¿Cuál es tu relación con Tomás Concha? (Madre, Padre, Amigo, Colega, etc.)",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(250, 66, 25, 8),
            fontFamily: 'Sitka',
            fontSize: 15,
          ),
        ),
        SizedBox(
          width: 300,
          child: TextField(
            style: const TextStyle(
              fontFamily: 'Sitka',
              color: Color.fromARGB(250, 66, 25, 8),
            ),
            onChanged: (s) {
              relation = s;
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "¿A cuál de estos 3 grupos perteneces?",
          style: TextStyle(
            color: Color.fromARGB(250, 66, 25, 8),
            fontFamily: 'Sitka',
            fontSize: 15,
          ),
        ),
        ListTile(
          title: const Text(
            'Estoy cursando Dispositivos Móviles',
            style: TextStyle(
              color: Color.fromARGB(250, 66, 25, 8),
              fontFamily: 'Sitka',
              fontSize: 15,
            ),
          ),
          leading: Radio<int>(
            value: 1,
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = value!;
              });
              group = 'estoy cursando Dispositivos Móviles';
            },
          ),
        ),
        ListTile(
          title: const Text(
            'Estudio IDVRV',
            style: TextStyle(
              color: Color.fromARGB(250, 66, 25, 8),
              fontFamily: 'Sitka',
              fontSize: 15,
            ),
          ),
          leading: Radio<int>(
            value: 2,
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = value!;
              });
              group = 'estudio IDVRV';
            },
          ),
        ),
        ListTile(
          title: const Text(
            'No tengo conocimientos técnicos de Pogramación ni Diseño',
            style: TextStyle(
              color: Color.fromARGB(250, 66, 25, 8),
              fontFamily: 'Sitka',
              fontSize: 15,
            ),
          ),
          leading: Radio<int>(
            value: 3,
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = value!;
              });
              group =
                  'no tengo conocimientos técnicos de Pogramación ni Diseño';
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ));

    qBanners.add(Padding(
      padding: const EdgeInsets.only(bottom: 20.0, left: 100, right: 100),
      child: ElevatedButton(
          style: const ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(Color.fromARGB(250, 168, 93, 48)),
          ),
          onPressed: () async {
            var response = List.empty(growable: true);

            for (int i = 0; i < questions.length; i++) {
              response.add(" - ${questions[i].title}: ${values[i]}\n\n");
            }
            var r = response.join();

            final Email email = Email(
              body:
                  'Hola!!\n\nSoy tu $relation $name [ya sabes que $group ;)], y esta es mi opinión sobre tu aplicación!\n\n $r **Aquí puedes agregar algún mensaje extra, sino borra esto**',
              subject: 'EVALUACIÓN CAPPUCCINO',
              recipients: ['tomasconcha31@gmail.com'],
              isHTML: false,
            );

            await FlutterEmailSender.send(email).then((v) {});
          },
          child: const Text(
            "Enviar",
            style: TextStyle(
              color: Color.fromARGB(250, 236, 204, 180),
              fontSize: 15,
            ),
          )),
    ));

    return qBanners;
  }
}
