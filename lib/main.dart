import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/login/inicio_sesion.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    //await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAYiYYU9gosrco_BmFSWiNeiV533Adcq1o",
      authDomain: "teczacatepec.firebaseapp.com",
      projectId: "teczacatepec",
      storageBucket: "teczacatepec.appspot.com",
      messagingSenderId: "510763080555",
      appId: "1:510763080555:web:9fca672c8c654b9d7b0a2e",
      measurementId: "G-W3Q61MMYLL",
    ),
  );

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 46, 82, 241),
        ),
      ),
      home: InicioSesion('Tecnamex', (String usuario, String sesion) async {
        final Uri url = Uri.parse(
          'https://tecnamex.appspot.com?usuario=$usuario&sesion=$sesion',
        );
        await launchUrl(url, webOnlyWindowName: '_self');
        await Future.delayed(const Duration(seconds: 2));
        RxBool esperar = Get.find(tag: 'esperar');
        esperar.value = false;
      }),
    ),
  );
}
