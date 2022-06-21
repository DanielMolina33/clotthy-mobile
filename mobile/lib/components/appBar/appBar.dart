// Flutter
import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

// Components
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import '../../models/LoginModel.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(70.0),
        super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    LocalStorage storage = LocalStorage('session');
    final userStored = storage.getItem('user_logged'); 
    final userData = User.fromJson(userStored);
    String username = userData.userData!.username.toString();
    String avatar = userData.userData!.avatar.toString();
    String roles = userData.userData!.userRoleInfo!.join(",")
    .replaceAll("Administrador", "")
    .replaceAll("de", "");

    return AppBar(
      toolbarHeight: 100,
      automaticallyImplyLeading: false,
      backgroundColor: const Color.fromARGB(250, 252, 255, 253),
      title: Row(
        children: [
          ZoomIn(
              child: Image.asset(
            'assets/images/clotthy2.png',
            fit: BoxFit.contain,
            height: 60,
          )),
        ],
      ),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              username.isNotEmpty ? username : "Usuario",
              style:
                TextStyle(color: Colors.black, fontFamily: 'SourceSansPro'),
              textAlign: TextAlign.center,
            ),
            Text(
              "Administrador" + roles,
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.grey, fontSize: 11),
            ),
          ],
        ),
        SizedBox(width: 8),
        CircleAvatar(
          child: Image.network(
            avatar,
            fit: BoxFit.contain,
          ),
          radius: 25,
          backgroundColor: Colors.white,
        ),
        SizedBox(width: 10)
      ],
    );
  }
}
