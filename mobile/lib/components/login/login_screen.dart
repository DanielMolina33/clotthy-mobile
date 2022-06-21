// Flutter
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import '../../providers/LoginProvider.dart';
import '../../providers/login_form_provider.dart';
import '../UI/input_decorations.dart';
import '../modal/Modal.dart';
import '../widgets/auth_background.dart';
import '../widgets/card_container.dart';

// Components

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FadeIn(child: _HeaderImage(), duration: Duration(seconds: 3)),
              SizedBox(height: 20),
              BounceInUp(
                  child: CardContainer(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          ElasticIn(
                            child: Text("Iniciar sesion",
                                style: Theme.of(context).textTheme.headline5),
                            duration: Duration(seconds: 3),
                          ),
                          SizedBox(height: 30),
                          ChangeNotifierProvider(
                            create: (_) => LoginFormProvider(),
                            child: LoginForm(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  duration: Duration(seconds: 3)),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderImage extends StatelessWidget {
  const _HeaderImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: size.height * 0.1),
        child: Image.asset(
          'assets/images/clotthy.png',
          height: 135,
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    final loginform = Provider.of<LoginFormProvider>(context);
    final provider = Provider.of<LoginProvider>(context, listen: false);

    return Container(
      child: Form(
        //TODO: Mantener La referencia al key
        key: loginform.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            ElasticInLeft(
                child: TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.authInputDecoration(
                    hinText: "correo@gmail.com",
                    labelText: "Correo Electronico",
                    prefixIcon: Icons.alternate_email_rounded,
                  ),
                  onChanged: (correo) => loginform.email = correo,
                  validator: (correo) {
                    // cuando esta vacio
                    if (correo == null || correo.isEmpty) {
                      return "Este campo es requerido";
                    }
                    // cuando falta algo
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(correo)) {
                      return "Ingrese su email correcto";
                    }
                    // el correo es valido
                    return null;
                  },
                ),
                duration: Duration(seconds: 3)),
            SizedBox(height: 10),
            ElasticInLeft(
                child: TextFormField(
                    autocorrect: isHidden,
                    obscureText: isHidden,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 134, 136, 134),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 47, 255),
                            width: 2,
                          ),
                        ),
                        hintText: "Ingresa tu contraseña",
                        labelText: "Contraseña",
                        prefixIcon:
                            const Icon(Icons.lock_outlined, color: Colors.blue),
                        suffixIcon: IconButton(
                          color: isHidden ? Colors.blue : Colors.grey,
                          onPressed: () {
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                          icon: Icon(isHidden
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                    onChanged: (contra) => loginform.password = contra,
                    validator: (contra) {
                      if (contra == null || contra.isEmpty) {
                        return "Se necesita la contraseña";
                      }
                      if (contra.length >= 10) return null;
                      return "La contraseña tiene que tener 10 caracteres";
                    }),
                duration: Duration(seconds: 3)),
            SizedBox(height: 35),
            FlipInX(
                child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledColor: Colors.grey,
                    elevation: 0,
                    color: Color.fromARGB(255, 36, 91, 189),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      child: Text(
                        "Ingresar",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      // todo login form
                      String sinspa = loginform.email.replaceAll(" ", "");
                      if(loginform.isValidForm()) {
                        provider.signin({
                          "email": loginform.email,
                          "password": loginform.password,
                          "password_confirmation": loginform.password
                        }, context);
                      }
                    }),
                duration: Duration(seconds: 3)),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
