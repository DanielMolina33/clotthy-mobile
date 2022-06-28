// Flutter
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import '../appBar/appBar.dart';
import '../button/Button.dart';

// Components

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<LoginProvider>(context);
    LocalStorage storage = LocalStorage('userLogged');
    // var userData = storage.getItem('user_data');
    var _solicitud = ['Cc', 'Ti', 'Nit'];
    String _vista = 'Doc';

    TextEditingController nameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();

    return Scaffold(
        appBar: CustomAppBar(),
        floatingActionButton: ButtonDesp(),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // titulo
                Container(
                    margin: const EdgeInsets.only(top: 30, left: 30),
                    child: Text(
                        'Perfil',
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'rlight',
                        ))),
                // imagen
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 30),
                  child: null,
                  // Image.network(
                  //   userData['user']['avatar'].toString(),
                  //   width: 120,
                  //   height: 110,
                  // ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(66, 20, 17, 17), width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                // sub titulo (datos basico)
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 30),
                  child: const Text('Datos basicos',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ),
                // nombre
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 25),
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.send,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      hintText: 'Nombre',
                      labelText: 'Nombre',
                    ),
                  ),
                ),

                // apellido
                Container(
                  margin: EdgeInsets.only(top: 10, left: 30),
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: lastNameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.send,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: 'Apellido',
                      labelText: 'Apellido',
                    ),
                  ),
                ),

                // documento
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      width: 80,
                      height: 40,
                      child: DropdownButton(
                        elevation: 80,
                        underline: Container(),
                        items: _solicitud.map((String a) {
                          return DropdownMenuItem(value: a, child: Text(a));
                        }).toList(),
                        onChanged: (value) => {
                          // value = _vista,
                          // setState(() => {value = _vista})
                        },
                        hint: Text(_vista),
                      ),
                    ),
                    Container(
                      width: 250,
                      child: TextFormField(
                        controller: lastNameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.send,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'Numero de doc',
                          labelText: 'Numero de doc',
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                // boton actualizar
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Container(
                          width: 125,
                          height: 50,
                          child: Center(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 36, 91, 189))),
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [Text('Actualizar')],
                                )),
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
          ],
        ));
  }
}

// --------------------------esto es para aplicar el documento---------------------------

//  Widget documento(){
//   var documentos=['CC','CE'];
//   String vista='CC';
//  return Row(
//     children: [
//      DropdownButton(
//     items: <String> ['CC','CE']
//     .map<DropdownMenuItem<String>>((String value){
//       return DropdownMenuItem<String>(
//         value: value,
//         child: Text(value),
//       );
//     }).toList(),
//       value:documentos,
//       icon:Icon(Icons.arrow_drop_down),
//       iconSize:15,
//       elevation: 16,
//       style: TextStyle(color: Colors.grey),
//       underline: Container(
//         height:3,
//       ),
//      onChanged: (String value){
//        setState((){
//         documentos = value;
//        }

//        )
//      });
//    ],
//  );
// }
