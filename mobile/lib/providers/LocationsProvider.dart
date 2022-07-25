// Flutter
import 'dart:convert';
import 'package:clotthy/models/CityModel.dart';
import 'package:clotthy/models/CountryModel.dart';
import 'package:clotthy/models/DepatmentModel.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

// Utilities
import 'package:clotthy/utils/Api.dart';
import '../components/modal/Modal.dart';
import '../utils/ApiMessages.dart';

class LocationsProvider extends ChangeNotifier {
  LocalStorage storage = LocalStorage('session');
  // List<Telefono> telefono = [];
  // List<SocialNetwork> socialNetworks = [];
  // List<OneCompani> oneCompany = [];

  // bool isTelefono = false;
  // bool isRed = false;
  // bool isCompany = false;

  Future<List<CountryData>?> getCountries(context) async {
    String path = '/country';
    final res = await Api.httpGet(path, "");
    final statusCode = res.statusCode;
    Map<String, dynamic> dataMap = jsonDecode(res.body);

    if(statusCode == 200){
      final countryModel = CountryModel.fromJson(dataMap);
      if(countryModel.data != null){
        return countryModel.data!;
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Modal(
              title: "Advertencia", 
              textContent: "Hubo un problema al cargar los paises\nintentalo de nuevo", 
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

    return null;
  }

  Future<List<DepartmentData>?> getDepartments(countryId, context) async {
    String path = "/department?country_id=$countryId";
    final res = await Api.httpGet(path, "");
    final statusCode = res.statusCode;
    Map<String, dynamic> dataMap = jsonDecode(res.body);
  
    if(statusCode == 200){
      final departmentModel = DepartmentModel.fromJson(dataMap);
      if(departmentModel.data != null){
        return departmentModel.data!;
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Modal(
              title: "Advertencia", 
              textContent: "Hubo un problema al cargar los departamentos\nintentalo de nuevo", 
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

    return null;
  }

  Future<List<CityData>?> getCities(departmentId, context) async {
    String path = "/city?department_id=$departmentId";
    final res = await Api.httpGet(path, "");
    final statusCode = res.statusCode;
    Map<String, dynamic> dataMap = jsonDecode(res.body);
  
    if(statusCode == 200){
      final cityModel = CityModel.fromJson(dataMap);
      if(cityModel.data != null){
        return cityModel.data!;
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Modal(
              title: "Advertencia", 
              textContent: "Hubo un problema al cargar las ciudades\nintentalo de nuevo", 
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

    return null;
  }
}