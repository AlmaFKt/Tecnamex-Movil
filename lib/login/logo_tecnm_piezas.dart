import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoTecNMPiezas extends StatefulWidget {
  const LogoTecNMPiezas({super.key});

  @override
  LogoTecNMPiezasState createState() => LogoTecNMPiezasState();
}

class LogoTecNMPiezasState extends State<LogoTecNMPiezas> {
  List<Widget> l = [];

  @override
  void initState() {
    super.initState();

    for (int x = 0; x <= 19; x++) {
      l.add(SvgPicture.asset('assets/tec/piezas_tecnm/t$x.svg'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            height: 300,
            child: Stack(
              children: [for (int x = 0; x < l.length; x++) pieza(x)],
            ),
          ),
          const SizedBox(height: 30),
          // FadeInUpBig(
          //   child: Text(
          //     'Hola ${estudiante.nombre.capitalize},\nBienvenid${(estudiante.esHombre) ? 'o' : 'a'} a casa',
          //     style: GoogleFonts.kalam(
          //       fontSize: 30,
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget pieza(int index) {
    // int duracion = 1200;
    int duracion = 100;

    int x = (Random().nextInt(6) + 1) % 6;

    switch (x) {
      case 0:
        return FadeInDownBig(
          duration: Duration(milliseconds: duracion),
          child: l[index],
        );
      case 1:
        return FadeInUpBig(
          duration: Duration(milliseconds: duracion),
          child: l[index],
        );
      case 2:
        return FadeInLeftBig(
          duration: Duration(milliseconds: duracion),
          child: l[index],
        );
      case 3:
        return FadeInRightBig(
          duration: Duration(milliseconds: duracion),
          child: l[index],
        );
      case 4:
        return BounceInDown(
          from: 500,
          duration: Duration(milliseconds: duracion * 2),
          child: l[index],
        );
      default:
        return ZoomIn(
          duration: Duration(milliseconds: duracion),
          child: l[index],
        );
    }
  }
}
