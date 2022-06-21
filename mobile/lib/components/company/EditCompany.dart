// Flutter
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

// Components
import '../appBar/appBar.dart';
import '../button/Button.dart';

class EditCompany extends StatefulWidget {
  EditCompany({Key? key}) : super(key: key);
  @override
  State<EditCompany> createState() => _EditCompanyState();
}

class _EditCompanyState extends State<EditCompany> {
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<CompanyProvider>(context);
    // final companys = Provider.of<CompanyProvider>(context).oneCompany;
    LocalStorage storage = LocalStorage('userLogged');
    var userData = storage.getItem('user_data');
    var result;

    TextEditingController nameComController = TextEditingController();
    TextEditingController lastNameComController = TextEditingController();
    TextEditingController docComController = TextEditingController();

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
                    child: Text('Editar compañia',
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'rlight',
                        ))),
                // imagen
                Container(
                    margin: const EdgeInsets.only(top: 30, left: 30),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 255, 255, 255))),
                      onPressed: () {
                        result = FilePicker.platform.pickFiles();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Image.network(
                          userData['user']['avatar'].toString(),
                          width: 150,
                          height: 150,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(66, 20, 17, 17),
                              width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )),

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
                    controller: nameComController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.send,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      hintText: 'Razon Social',
                      labelText: 'Razon Socail',
                    ),
                  ),
                ),

                // apellido
                Container(
                  margin: EdgeInsets.only(top: 10, left: 30),
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: lastNameComController,
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
                    Text('NIT: '),
                    Container(
                        width: 250,
                        child: TextFormField(
                          controller: docComController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.send,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: 'Numero de doc',
                            labelText: 'Numero de doc',
                          ),
                        ))
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
