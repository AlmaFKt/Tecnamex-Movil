import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'acceso.dart';

class AccesoOutlook extends StatefulWidget {
  final Function valido;
  const AccesoOutlook(this.valido, {super.key});

  @override
  State<AccesoOutlook> createState() => AccesoOutlookState();
}

class AccesoOutlookState extends State<AccesoOutlook> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        signInWithOutlook();
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Color del borde
            width: 1.0, // Grosor del borde
          ),
          borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/outlook.png', fit: BoxFit.contain),
        ),
      ),
    );
  }

  Future<void> signInWithOutlook() async {
    try {
      final OAuthProvider provider = OAuthProvider('microsoft.com');
      provider.credential();
      provider.setCustomParameters({
        'prompt': 'consent',
        'tenant': '261809a4-d6b4-48b4-a568-f07df069157c',
      });
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithPopup(provider);
      if (userCredential.user != null) {
        Acceso.validaUsuario(
          userCredential.user!.email!
              .split('#')[0]
              .replaceAll('_hotmail.com', '@hotmail.com'),
          widget.valido,
        );
      } else {
        Acceso.errorAcceso(userCredential.user!.email!);
      }
    } catch (e) {
      Acceso.errorAcceso(e.toString());
    }
  }
}
