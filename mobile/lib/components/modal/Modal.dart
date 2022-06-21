import 'package:flutter/material.dart';

class Modal extends StatelessWidget {
  String title, textContent;
  IconData icon;
  Color iconColor;

  Modal({
    Key? key,
    required this.title,
    required this.textContent,
    required this.icon,
    required this.iconColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 20),
          Text(title)
        ]
      ),
      content: Text(textContent),
      backgroundColor: Colors.white,
      elevation: 24.0,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Aceptar'),
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}