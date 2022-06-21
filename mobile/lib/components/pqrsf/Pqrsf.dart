// Flutter
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../appBar/appBar.dart';
import '../button/Button.dart';

// Components

class Pqrsf extends StatefulWidget {
  const Pqrsf({Key? key}) : super(key: key);

  @override
  State<Pqrsf> createState() => _PqrsfState();
}

class _PqrsfState extends State<Pqrsf> {
  var _solicitud = ['opcion1', 'opcion2', 'opcion3'];
  String _vista = 'Tipo de solicitud';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(250, 252, 255, 253),
        appBar: CustomAppBar(),
        floatingActionButton: ButtonDesp(),
        body: ListView(
          children: [
            Column(
              children: [
                Divider(color: Colors.white.withOpacity(0.1)),
                // este container contiene el titulo
                Container(
                    width: 300,
                    alignment: Alignment.bottomLeft,
                    child: const Text(
                      'Pqrsf',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
                    )),
                Divider(color: Colors.white.withOpacity(0.1)),
                Divider(color: Colors.white.withOpacity(0.1)),

                // tipo de solicitud

                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  width: 325,
                  height: 40,
                  child: DropdownButton(
                    elevation: 80,
                    underline: Container(),
                    items: _solicitud.map((String a) {
                      return DropdownMenuItem(value: a, child: Text(a));
                    }).toList(),
                    onChanged: (value) => {
                      setState(() => {
                            // _vista=value
                          })
                    },
                    hint: Text(_vista),
                  ),
                ),

                Divider(color: Colors.white.withOpacity(0.1)),

                // adjunta los archivos seleccionados
                Container(
                  width: 325,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 255, 255, 255))),
                      onPressed: () {
                        final result = FilePicker.platform.pickFiles();
                      },
                      child: const Text(
                        'Adjuntar captura',
                        style: TextStyle(color: Colors.grey),
                      )),
                ),

                Divider(color: Colors.white.withOpacity(0.1)),
                Divider(color: Colors.white.withOpacity(0.1)),

                Container(
                    alignment: Alignment.topLeft, child: const Text('Asunto')),
                const Divider(),

                const SizedBox(
                  height: 125,
                  width: 325,
                  child: TextField(
                    maxLines: 50,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Descripción...",
                    ),
                  ),
                ),
                Divider(color: Colors.white.withOpacity(0.1)),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          height: 40,
                          width: 150,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 126, 128, 131))),
                            child: const Text('Cancelar'),
                            onPressed: () {
                              Navigator.pop(context, 'cancelar');
                            },
                          )),
                      Container(
                          height: 40,
                          width: 150,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 36, 91, 189))),
                            child: const Text('Enviar'),
                            onPressed: () {
                              Navigator.pop(context, '');
                            },
                          )),
                    ]),
              ],
            ),
          ],
        ));
  }
}
