// Flutter
import 'dart:convert';
import 'package:clotthy/models/CompanyModel.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

// Utilities
import 'package:clotthy/utils/Api.dart';

import '../components/modal/Modal.dart';
import '../utils/ApiMessages.dart';

class CompanyProvider extends ChangeNotifier {
  LocalStorage storage = LocalStorage('session');
  List<Data>? companies = [];
  // List<Telefono> telefono = [];
  // List<SocialNetwork> socialNetworks = [];
  // List<OneCompani> oneCompany = [];

  // bool isTelefono = false;
  // bool isRed = false;
  // bool isCompany = false;

  getCompanies(context) async {
    String path = '/company';
    final res = await Api.httpGet(path, "");
    final statusCode = res.statusCode;
    Map<String, dynamic> dataMap = jsonDecode(res.body);

    if(statusCode == 200){
      final companyData = CompanyModel.fromJson(dataMap);
      if(companyData.data!.data != null){
        companies = companyData.data!.data;
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Modal(
              title: "Advertencia", 
              textContent: "Hubo un problema al cargar las empresas\nintentalo de nuevo", 
              icon: Icons.warning_amber_rounded,
              iconColor: Colors.orange
            );
          }
        );
      }
    } else if (statusCode == 400){
      final apiMessages = ApiMessages();
      apiMessages.getMessages(dataMap, context);
    }

    notifyListeners();

    // print(bodyResponse);

    // String message = "";
  }

  // getCompanytel(String id) async {
  //   // print('********************');
  //   LocalStorage storage = LocalStorage('userLogged');
  //   String url = '/company/$id';
  //   var userData = storage.getItem('user_data');
  //   final token = userData['token'];

  //   // conexion a all api contando los documentos
  //   final resp = await AllApi.httpGet(url, token);
  //   final bodyResponse = jsonDecode(resp.body);

  //   // print(bodyResponse);
  //   final Telefonos telefono =
  //       Telefonos.fromlist(bodyResponse['data']['telefonos']);
  //   this.telefono = telefono.dato;
  //   if (telefono.dato[0].id != "") {
  //     isTelefono = true;
  //   }

  //   notifyListeners();
  //   // String message = "";
  // }

  // getCompanyNet(String id) async {
  //   // print('********************');
  //   LocalStorage storage = LocalStorage('userLogged');
  //   String url = '/company/$id';
  //   var userData = storage.getItem('user_data');
  //   final token = userData['token'];

  //   // conexion a all api contando los documentos
  //   final resp = await AllApi.httpGet(url, token);
  //   final bodyResponse = jsonDecode(resp.body);

  //   print('**************  ' + bodyResponse.toString());
  //   final SocialNetworks socialNetworks =
  //       SocialNetworks.fromlist(bodyResponse['data']['redessociales']);

  //   this.socialNetworks = socialNetworks.dato;
  //   print(socialNetworks.dato);
  //   if (socialNetworks.dato != "") {
  //     isRed = true;
  //   }
  //   // print(socialNetworks.dato);
  //   notifyListeners();
  //   // String message = "";
  // }

  // getCompany(context, id) async {
  //   LocalStorage storage = LocalStorage('userLogged');
  //   String url = '/company/$id';
  //   var userData = storage.getItem('user_data');
  //   final token = userData['token'];

  //   // conexion a all api contando los documentos
  //   final resp = await AllApi.httpGet(url, token);
  //   final bodyResponse = jsonDecode(resp.body);

  //   print('**************  ' + bodyResponse.toString());

  //   final OneCompany oneCompany = OneCompany.fromlist(bodyResponse['data']);
  //   this.oneCompany = oneCompany.dato;
  //   print(oneCompany.dato);
  //   if (oneCompany.dato != "") {
  //     isCompany = true;
  //     Navigator.pushReplacementNamed(context, "EditCompany");
  //   }

  //   notifyListeners();
  // }
}
