import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../providers/loginProvider.dart';
import '../../providers/login_form_provider.dart';

class InputContrasena extends StatefulWidget {
  InputContrasena({
    Key? key,
    required hinText,
    required labelText,
    required prefixIcon,
    required suffixIcon,
  }) : super(key: key);

  String hinText = 'Ingrese contraseña';
  String labelText = 'Contraseña';
  IconData prefixIcon = Icons.lock;
  IconData suffixIcon = Icons.visibility;

  @override
  State<InputContrasena> createState() => _InputContrasenaState();
}

class _InputContrasenaState extends State<InputContrasena> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    final loginform = Provider.of<LoginFormProvider>(context);
    // final provider = Provider.of<LoginProvider>(context, listen: false);
    return ElasticInLeft(
        child: TextFormField(
          autocorrect: isHidden,
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 134, 136, 134),
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 0, 47, 255),
                width: 2,
              ),
            ),
            hintText: widget.hinText,
            labelText: widget.labelText,
            labelStyle: const TextStyle(
              color: Colors.grey,
            ),
            prefixIcon: widget.prefixIcon != null
                ? InkWell(
                    onTap: () {
                      togglePasswordVisibility();
                    },
                    child: Icon(widget.prefixIcon, color: Colors.blue))
                : null,
            suffixIcon: widget.suffixIcon != null
                ? InkWell(
                    onTap: () {
                      togglePasswordVisibility();
                    },
                    child: Icon(widget.suffixIcon, color: Colors.blue))
                : null,
          ),
          onChanged: (value) => loginform.password = value,
          validator: (value) {
            if (value != null && value.length >= 10) return null;

            return "La contraseña tiene que tener 10 caracteres";
          },
        ),
        duration: const Duration(seconds: 3));
  }

  void togglePasswordVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  Widget togglePassword() {
    return IconButton(
        onPressed: () {
          setState(() {
            isHidden = !isHidden;
          });
        },
        icon: isHidden
            ? const Icon(Icons.visibility)
            : const Icon(Icons.visibility_off),
        color: Colors.grey);
  }
}
