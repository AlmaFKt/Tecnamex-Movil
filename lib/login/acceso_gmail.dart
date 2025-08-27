import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'acceso.dart';

class AccesoGmail extends StatefulWidget {
  final Function valido;
  const AccesoGmail(this.valido, {super.key});

  @override
  State<AccesoGmail> createState() => AccesoGmailState();
}

class AccesoGmailState extends State<AccesoGmail> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        signInWithGmail();
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
          padding: const EdgeInsets.all(6.0),
          child: Image.asset('assets/google.png', fit: BoxFit.contain),
        ),
      ),
    );
  }

  Future<void> signInWithGmail() async {
    try {
      GoogleSignInAccount? googleUser =
          await GoogleSignIn(
            clientId:
                '510763080555-1id8nl2elieqem7qbg2m4g1tgpt6bifn.apps.googleusercontent.com',
          ).signIn();
      if (googleUser == null) {
        return;
      }
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      if (userCredential.user != null) {
        Acceso.validaUsuario(userCredential.user!.email!, widget.valido);
      } else {
        Acceso.errorAcceso(userCredential.user!.email!);
      }
    } catch (_) {
      Acceso.errorAcceso('');
    }
  }
}
