import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Acceso {
  static void validaUsuario(String usuario, Function valido) async {
    RxBool esperar = Get.find(tag: 'esperar');
    esperar.value = true;
    CollectionReference col = FirebaseFirestore.instance.collection(
      'itz/tecnamex/usuarios',
    );
    QuerySnapshot l = await col.where('accesos', arrayContains: usuario).get();
    List<QueryDocumentSnapshot> docs = l.docs;
    if (docs.isEmpty) {
      FirebaseAuth.instance.signOut();
      Acceso.errorAcceso(usuario);
      return;
    }
    if (docs.length > 1) {
      FirebaseAuth.instance.signOut();
      Acceso.errorAcceso(
        usuario,
        error: 'Usuario duplicado, pasar a Centro de Computo',
      );
      return;
    }
    DocumentReference docUsuario = docs[0].reference;
    String s = sesion();
    await docUsuario.update({'sesion': s});
    Map<String, dynamic> data = docs[0].data() as Map<String, dynamic>;
    valido(data['nombre'], s);
  }

  static String sesion() {
    Random r = Random();
    int w, t = r.nextInt(20) + 100;
    StringBuffer s = StringBuffer();
    for (int x = 0; x < t; x++) {
      w = r.nextInt(3);
      switch (w) {
        case 0:
          s.write(String.fromCharCode(r.nextInt(26) + 65));
          break;
        case 1:
          s.write(String.fromCharCode(r.nextInt(26) + 97));
        case 2:
        default:
          s.write(String.fromCharCode(r.nextInt(10) + 48));
      }
    }
    return s.toString();
  }

  static void errorAcceso(
    String usuario, {
    String error = 'Usuario no encontrado.',
  }) {
    RxBool esperar = Get.find(tag: 'esperar');
    esperar.value = false;
    Get.snackbar(
      'Error',
      '$usuario\n$error',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}
