// Flutter
import 'dart:convert';
import 'package:clotthy/utils/apiMessages.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '../components/modal/Modal.dart';
import '../models/LoginModel.dart';

// Utilities
import '../utils/Api.dart';

class LoginProvider extends ChangeNotifier {
  final LocalStorage storage = LocalStorage('session');
  final List<String> requiredRoles = ["administrador general", "superuser"];

  Future<bool> signin(Map<String, String> data, context) async {
    String path = '/signin/employees';
    final res = await Api.httpPost(path, data);
    Map<String, dynamic> dataMap = jsonDecode(res.body);
    String message = "";

    if(res.statusCode == 200){
      final user = User.fromJson(dataMap);
      if(user.userData != null){
        final isAllowed = validateUserRole(user);
        if(isAllowed){
          storage.setItem('user_logged', {
            'user': user.userData?.toJson(),
            'token': user.token,
            'created_at': DateTime.now().toString()
          });
          
          return true;
          // Navigator.pushReplacementNamed(context, 'Company');
        } else {
          showModal(
            "No tienes el rol requerido para ingresar \n" 
            "- administrador general \n" 
            "- superuser",
            context
          );
          logout(user.token, context, false);
        }
      }
    } else if(res.statusCode == 400){
      final apiMessages = ApiMessages();
      apiMessages.getMessages(dataMap, context);
    }

    return false;
  }

  logout(token, context, redirect) async {
    String path = "/logout-employees";
    final res = await Api.httpGet(path, token);
    storage.deleteItem("user_logged");

    if(redirect) Navigator.pushReplacementNamed(context, 'login');
  }

  bool validateUserRole(User user){
    List<UserRoleInfo>? roles;
    bool hasRole = false;

    if(user.userData != null){
      roles = user.userData!.userRoleInfo;
      hasRole = roles!.any((item) => requiredRoles.contains(item.role!.toLowerCase()));
    }

    return hasRole;
  }

  void showModal(message, context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Modal(
          title: "Advertencia", 
          textContent: message, 
          icon: Icons.warning_amber_rounded,
          iconColor: Colors.orange
        );
      }
    );
  }
}
