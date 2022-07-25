// Flutter
import 'dart:io';
import 'package:clotthy/components/modal/Modal.dart';
import 'package:clotthy/providers/LocationsProvider.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:localstorage/localstorage.dart';
import '../../providers/CompanyProvider.dart';


// Components
import '../appBar/appBar.dart';
import '../button/Button.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({Key? key}) : super(key: key);
  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  LocalStorage storage = LocalStorage("session");
  late LocationsProvider locations;

  late File logo = File("");
  String idCountry = "Pais *";
  String idDepartment = "Departamento *";
  String idCity = "Ciudad *";
  List<DropdownMenuItem<String>> countries = [
    const DropdownMenuItem(
      value: "Pais *",
      child: Text("Pais *", style: TextStyle(color: Colors.black54)),
      enabled: false
    ),
  ];
  List<DropdownMenuItem<String>> departments = [
    const DropdownMenuItem(
      value: "Departamento *",
      child: Text("Departamento *", style: TextStyle(color: Colors.black54)),
      enabled: false
    ),
  ];
  List<DropdownMenuItem<String>> cities = [
    const DropdownMenuItem(
      value: "Ciudad *",
      child: Text("Ciudad *", style: TextStyle(color: Colors.black54)),
      enabled: false
    ),
  ];
  TextEditingController name = TextEditingController();
  TextEditingController idNumber = TextEditingController();
  TextEditingController cpIndicative = TextEditingController();
  TextEditingController cellphone = TextEditingController();
  TextEditingController pIndicative = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController wpp = TextEditingController();
  TextEditingController ig = TextEditingController();
  TextEditingController fb = TextEditingController();
  TextEditingController tw = TextEditingController();
  TextEditingController web = TextEditingController();

  @override
  void initState() {
    super.initState();
    locations = Provider.of<LocationsProvider>(context, listen: false);
    locations.getCountries(context).then((value) => {
      countries.addAll(fillMenuItems(value, "paises")),
      setState((){ countries; }),
    });
  }

  List<DropdownMenuItem<String>> fillMenuItems(locationItem, valueToShow){
    List<DropdownMenuItem<String>> menuItems = [];

    for (var item in locationItem) {
      var text = "";

      switch(valueToShow){
        case 'paises':
          text = item.nombrepaises;
          break;
        case 'departamentos':
          text = item.nombredepar;
          break;
        case 'ciudades':
          text = item.nombreciudades;
          break;
        default:
          text = "No item";
          break;
      }

      menuItems.add(DropdownMenuItem(
        value: item.id.toString(),
        child: Text(text)
      ));  
    }

    return menuItems;
  }

  void openFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ["jpg", "jpeg", "png"]
    );

    if(result != null) {
      final bytes = result.files.single.size;
      if((bytes / 1e+6) <= 2){
        setState(() {
          logo = File(result.files.single.path.toString());
        });
      } else { 
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Modal(
              title: "Advertencia",
              textContent: "La imagen no puede superar los 2MB",
              icon: Icons.warning_amber_rounded,
              iconColor: Colors.orange,
            );
          }
        );
      }
    }
  }

  void fetchData(provider, context){
    final token = storage.getItem("user_logged")['token'];
    final wppName = wpp.text.isNotEmpty ? "Whatsapp" : "";
    final igName = ig.text.isNotEmpty ? "Instagram" : "";
    final fbName = fb.text.isNotEmpty ? "Facebook" : "";
    final twName = tw.text.isNotEmpty ? "Twitter" : "";
    final webName = web.text.isNotEmpty ? "Web" : "";
    final phoneInfo = {"p_length": "1", "p_1": phone.text, "indicative_p_1": pIndicative.text};
    final smInfo = fillSmData();
    final data = {
      "company_name": name.text,
      "id_city": idCity.toString(),
      "nit": idNumber.text,
      "cp_length": "1",
      "cp_1": cellphone.text,
      "indicative_cp_1": cpIndicative.text,
      "image": logo.path.toString()
    };

    if(phone.text.isNotEmpty) data.addEntries(phoneInfo.entries);
    data.addEntries(smInfo.entries); 
    provider.createCompany(data, token, context);
  }

  Map<String, String> fillSmData(){
    final fields = [wpp, ig, fb, tw, web];
    final data = [];
    final Map<String, String> smData = {};

    for(var i = 0; i <= fields.length-1; i++) { 
      if(fields[i].text.isNotEmpty){
        var smName = "";
        data.add(fields[i]);

        switch(i){
          case 0: smName = "Whatsapp"; break;
          case 1: smName = "Instagram"; break;
          case 2: smName = "Facebook"; break;
          case 3: smName = "Twitter"; break;
          case 4: smName = "Web"; break;
        }

        if(!smData.keys.contains("sm_url_1")){
          smData.addEntries({
            "sm_url_1":fields[i].text,
            "sm_name_1": smName,
          }.entries);
        } else {
          smData.addEntries({
            "sm_url_${i+1}": fields[i].text,
            "sm_name_${i+1}": smName,
          }.entries);
        }
      }
    }

    smData.addEntries({"sm_length": data.isEmpty ? "1" : data.length.toString()}.entries);
    return smData;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<CompanyProvider>(context);

    return Scaffold(
        appBar: CustomAppBar(),
        floatingActionButton: ButtonDesp(),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                right: 20,
                bottom: 150,
                left: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // titulo
                  Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: const Text('Agregar una empresa',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w400
                        )
                      )),
                  // imagen
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    child: GestureDetector(
                      child: logo.path.isEmpty
                      ? const Icon(
                        FontAwesomeIcons.fileImage, 
                        color: Colors.grey, 
                        size: 40
                      )
                      : Image.file(logo),
                      onTap: () {
                        openFiles();
                      },
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Text('DATOS BASICOS',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w400
                        )),
                  ),
                  // nombre
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      controller: name,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.userLarge, size: 20),
                        hintText: 'Razón Social',
                        labelText: 'Razón Social *',
                      ),
                    ),
                  ),
                  // documento
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    width: size.width,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black)),
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      value: idCountry,
                      underline: Container(),
                      items: [...countries],
                      onChanged: (String? newVal) => {
                        setState((){ idCountry = newVal!; }),
                        locations.getDepartments(newVal, context).then((value) => {
                          setState(() {
                            departments.addAll(fillMenuItems(value, 'departamentos'));
                          }),
                        }),
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          width: size.width,
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.black)),
                          ),
                          child: DropdownButton(
                            isExpanded: true,
                            value: idDepartment,
                            underline: Container(),
                            items: [...departments],
                            onChanged: (String? newVal) => {
                              setState((){ idDepartment = newVal!; }),
                              locations.getCities(newVal, context).then((value) => {
                                setState(() {
                                  cities.addAll(fillMenuItems(value, "ciudades"));
                                })
                              })
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          width: size.width,
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.black)),
                          ),
                          child: DropdownButton(
                            isExpanded: true,
                            value: idCity,
                            underline: Container(),
                            items: [...cities],
                            onChanged: (String? newVal) => {
                              setState(() => {
                                idCity = newVal!,
                              }),
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: idNumber,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(FontAwesomeIcons.idCard, size: 20),
                          hintText: 'NIT',
                          labelText: 'NIT *',
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Text('CONTACTO',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w400
                      )),
                  ),     
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.15,
                          child: TextFormField(
                            controller: cpIndicative,
                            keyboardType: TextInputType.phone,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                              prefix: Text("+"),
                              labelText: 'Indicativo *',
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: TextFormField(
                            controller: cellphone,
                            keyboardType: TextInputType.phone,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                              hintText: 'Celular',
                              labelText: 'Celular *',
                            ),
                          ),
                        )
                      ] ,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.15,
                          child: TextFormField(
                            controller: pIndicative,
                            keyboardType: TextInputType.phone,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                              prefix: Text("+"),
                              labelText: 'Indicativo',
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: TextFormField(
                            controller: phone,
                            keyboardType: TextInputType.phone,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                              hintText: 'Télefono',
                              labelText: 'Télefono',
                            ),
                          ),
                        )
                      ] ,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      controller: wpp,
                      keyboardType: TextInputType.url,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.whatsapp, size: 20),
                        hintText: 'Whastapp link',
                        labelText: 'Whatsapp link',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      controller: ig,
                      keyboardType: TextInputType.url,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.instagram, size: 20),
                        hintText: 'Instagram',
                        labelText: 'Instagram',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      controller: fb,
                      keyboardType: TextInputType.url,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.facebook, size: 20),
                        hintText: 'Facebook',
                        labelText: 'Facebook',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      controller: tw,
                      keyboardType: TextInputType.url,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.twitter, size: 20),
                        hintText: 'Twitter',
                        labelText: 'Twitter',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      controller: web,
                      keyboardType: TextInputType.url,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.chrome, size: 20),
                        hintText: 'Web',
                        labelText: 'Web',
                      ),
                    ),
                  ),
                  // boton actualizar
                  SizedBox(
                    width: size.width,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                const EdgeInsets.symmetric(
                                  vertical: 15
                                )
                              ),
                              backgroundColor:
                                MaterialStateProperty.all<Color>(
                                Colors.grey
                              )),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancelar', style: TextStyle(fontSize: 16))
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                const EdgeInsets.symmetric(
                                  vertical: 15
                                )
                              ),
                              backgroundColor:
                                MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 36, 91, 189)
                              )),
                            onPressed: () {
                              fetchData(provider, context);
                            },
                            child: const Text('Agregar', style: TextStyle(fontSize: 16))
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
