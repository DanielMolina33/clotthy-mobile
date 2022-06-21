import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _CajaColor(),
          // _HeaderImage(),
          this.child,
        ],
      ),
    );
  }
}

//Imagen desde atras

// class _HeaderImage extends StatelessWidget {
//   const _HeaderImage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Flexible(
//         fit: FlexFit.loose,
//         child: Container(
//           width: double.infinity,
//           margin: EdgeInsets.only(top: 30),
//           child: Image.asset(
//             'images/clotthy.png',
//             height: 135,
//           ),
//         ),
//       ),
//     );
//   }
// }

class _CajaColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Pulse(
        child: Container(
          width: double.infinity,
          height: size.height * 0.6,
          decoration: _bluebackground(),
          //       child: Stack(
          //         children: [
          //           Positioned(child: _Buble(), top: 90, left: 30),
          //           Positioned(child: _Buble(), top: -40, left: -30),
          //           Positioned(child: _Buble(), top: -50, right: -20),
          //           Positioned(child: _Buble(), bottom: -50, left: 10),
          //           Positioned(child: _Buble(), bottom: 120, right: 20),
          //         ],
        ),
        duration: Duration(seconds: 3));
  }

  BoxDecoration _bluebackground() => BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(100),
          bottomLeft: Radius.circular(100),
        ),
        gradient: LinearGradient(
            colors: [Color(0xFF245BBD), Color.fromARGB(255, 36, 91, 189)]),
      );
}

// class _Buble extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: 100,
//         height: 100,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100),
//           color: Color.fromRGBO(255, 255, 255, 0.05),
//         ));
//   }
// }