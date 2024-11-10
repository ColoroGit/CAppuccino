import 'package:camera/camera.dart';
import 'package:cappuccino/models/recepie.dart';
import 'package:cappuccino/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class EditRecepie extends StatefulWidget {
  const EditRecepie({
    super.key,
    required this.camera,
    required this.recepie,
    required this.pScreen,
  });

  final CameraDescription camera;
  final Recepie recepie;
  final String pScreen;

  @override
  State<EditRecepie> createState() => _EditRecepieState();
}

class _EditRecepieState extends State<EditRecepie> {
  DatabaseHelper db = DatabaseHelper.instance;
  TextEditingController dateInput = TextEditingController();
  late Recepie r;

  @override
  void initState() {
    r = widget.recepie;

    DateTime dt = DateTime(
      r.dateOfCreation.year,
      r.dateOfCreation.month,
      r.dateOfCreation.day,
    );
    dateInput.text = DateFormat('dd-MM-yyyy').format(dt);

    super.initState();
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
        child: Stack(children: [
          ListView(
            children: [
              Column(
                children: [
                  //carrusel de Imágenes
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Título",
                    style: TextStyle(
                      fontSize: 28,
                      color: Color.fromARGB(250, 66, 25, 8),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                      left: 75,
                      right: 75,
                    ),
                    child: TextFormField(
                      style: const TextStyle(
                        fontFamily: 'Sitka',
                        color: Color.fromARGB(250, 66, 25, 8),
                      ),
                      initialValue: r.title,
                      onChanged: (value) {
                        r.title = value;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Tiempo de\nPreparación",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(250, 66, 25, 8),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      SizedBox(
                        width: 60,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          initialValue: r.timeOfPrep.toString(),
                          onChanged: (value) {
                            r.timeOfPrep = value as int;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Fecha de\nCreación",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(250, 66, 25, 8),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      SizedBox(
                        width: 180,
                        child: TextField(
                          controller: dateInput,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.calendar_today,
                            ),
                            labelText: "Ingresa una fecha",
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime.now(),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                              setState(() {
                                dateInput.text = formattedDate;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Ingredientes",
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(250, 66, 25, 8),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      style: const TextStyle(
                        fontFamily: 'Sitka',
                        color: Color.fromARGB(250, 66, 25, 8),
                      ),
                      initialValue: r.ingredients,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        r.ingredients = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Productos",
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(250, 66, 25, 8),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      style: const TextStyle(
                        fontFamily: 'Sitka',
                        color: Color.fromARGB(250, 66, 25, 8),
                      ),
                      initialValue: r.products,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        r.products = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Pasos",
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(250, 66, 25, 8),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      style: const TextStyle(
                        fontFamily: 'Sitka',
                        color: Color.fromARGB(250, 66, 25, 8),
                      ),
                      initialValue: r.steps,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        r.steps = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
              left: 65,
              top: 560,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      /*guardat receta en bd y notificar usuario*/
                    },
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(250, 168, 93, 48)),
                    ),
                    child: Text(
                      "Guardar",
                      style: TextStyle(
                        color: Color.fromARGB(250, 236, 204, 180),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {/*Dialog de warning*/},
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(250, 168, 93, 48)),
                      ),
                      child: Text(
                        "Salir",
                        style: TextStyle(
                          color: Color.fromARGB(250, 236, 204, 180),
                          fontSize: 15,
                        ),
                      ))
                ],
              ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /*Foto, probar que se pueda seleccionar desde la galería y tomar foto*/
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
