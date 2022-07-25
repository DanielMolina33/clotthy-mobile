// Flutter
import 'dart:convert';
import 'package:clotthy/models/CompanyModel.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

// Utilities
import 'package:clotthy/utils/Api.dart';

import '../components/modal/Modal.dart';
import '../models/CompanyDetailModel.dart';
import '../utils/ApiMessages.dart';

class CompanyProvider extends ChangeNotifier {
  LocalStorage storage = LocalStorage('session');
  List<dynamic>? companies = [];
  DataDetail? company;

  void getCompanies(context) async {
    companies = [];
    String path = '/company';
    final res = await Api.httpGet(path, "");
    final statusCode = res.statusCode;
    Map<String, dynamic> dataMap = jsonDecode(res.body);

    if(statusCode == 200){
      final companyData = CompanyModel.fromJson(dataMap);
      if(companyData.data!.data != null){
        final companiesReverse = List.from(companyData.data!.data!.reversed);
        companies = companiesReverse;
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
  }

  Future<DataDetail?> getCompany(context, id) async {
    company = null;
    String path = "/company/$id";
    final res = await Api.httpGet(path, "");
    final statusCode = res.statusCode;
    Map<String, dynamic> dataMap = jsonDecode(res.body);

    if(statusCode == 200){
      final companyData = CompanyDetailModel.fromJson(dataMap);
      if(companyData.data != null){
        return companyData.data;
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

    return null;
  }

  void createCompany(Map<String, String> data, token, context) async {
    String path = '/company';
    final res = await Api.httpMultipart(path, data, data['image'], token);
    final statusCode = res.statusCode;
    Map<String, dynamic> dataMap = jsonDecode(res.body);

    if(dataMap.isNotEmpty){
      final apiMessages = ApiMessages();
      if(statusCode == 201){
        apiMessages.getMessages(dataMap, context, redirect: true);
      } else {
        apiMessages.getMessages(dataMap, context);
      }
    }
  }

  void editCompany(Map<String, String> data, id, token, context) async {
    String path = "/company/$id";
    final res = await Api.httpPutMultipart(path, data, data['image'], token);
    final statusCode = res.statusCode;
    Map<String, dynamic> dataMap = jsonDecode(res.body);

    if(dataMap.isNotEmpty){
      final apiMessages = ApiMessages();
      if(statusCode == 200){
        apiMessages.getMessages(dataMap, context, redirect: true);
      } else {
        apiMessages.getMessages(dataMap, context);
      }
    }
  }
}
