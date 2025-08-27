import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'acceso.dart';
import 'acceso_gmail.dart';
import 'acceso_outlook.dart';
import 'dart:math';

import 'acceso_telefono.dart';

class InicioSesion extends StatefulWidget {
  final String titulo;
  final Function valido;
  const InicioSesion(this.titulo, this.valido, {super.key});

  @override
  InicioSesionState createState() => InicioSesionState();
}

class InicioSesionState extends State<InicioSesion> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController contUser = TextEditingController();
  TextEditingController contContra = TextEditingController();
  FocusNode focusUser = FocusNode();
  FocusNode focusContra = FocusNode();
  bool textoOculto = true;
  final IconData _iconoOculto = Icons.remove_red_eye;
  final IconData _iconoVisible = Icons.remove_red_eye_outlined;
  IconData _icono = Icons.remove_red_eye;
  bool entrando = false;
  late RxBool esperar;
  String? usuarioTecnamex;
  String? passwordTecnamex;
  String? usuarioOutlook;
  String? passwordOutlook;
  String? usuarioGmail;
  String? passwordGmail;
  late SharedPreferences prefs;
  late String nombreFondo;

  @override
  void initState() {
    preferencias();
    super.initState();
    esperar = RxBool(false);
    Get.put(tag: 'esperar', esperar);
    Random r = Random();
    nombreFondo = "fondo${r.nextInt(3)}.jpg";
  }

  void preferencias() async {
    prefs = await SharedPreferences.getInstance();
    final String? usuarioTecnamex = prefs.getString('usuarioTecnamex');
    final String? passwordTecnamex = prefs.getString('passwordTecnamex');
    if (usuarioTecnamex != null && passwordTecnamex != null) {
      contUser.text = usuarioTecnamex;
      contContra.text = passwordTecnamex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tecnológico Nacional de México',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 10, 69, 117),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.2),
              BlendMode.dstATop,
            ),
            image: AssetImage("assets/tec/$nombreFondo"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Obx(
            () => !esperar.value
                ? Container(
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                      maxHeight: 700,
                    ),
                    decoration: BoxDecoration(
                      // Added BoxDecoration
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 183, 218, 247),
                          Colors.white,
                        ], // Define your gradient colors
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors
                            .black, // Colors.grey.shade400, // Border color
                      ),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ), // Rounded corners
                      boxShadow: [
                        // Adds shadow
                        BoxShadow(
                          color: const Color.fromARGB(
                            255,
                            124,
                            123,
                            123,
                          ).withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(
                            0,
                            5,
                          ), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(
                      10.0,
                    ), // Add padding inside the container
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          'Instituto Tecnológico de Zacatepec',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            RotatedBox(
                              quarterTurns: -1,
                              child: Text(
                                widget.titulo,
                                style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Form(
                                key: _formkey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    spacing: 10,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      logo(),
                                      usuario(),
                                      password(),
                                      (!entrando)
                                          ? botonEntrar()
                                          : const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                      const SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        spacing: 20,
                                        children: [
                                          AccesoOutlook(widget.valido),
                                          AccesoGmail(widget.valido),
                                          AccesoTelefono(widget.valido),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  )
                : const SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
      ),
    );
  }

  Widget logo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: kIsWeb ? 140 : 90,
          height: kIsWeb ? 140 : 90,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Image.asset('assets/tec/tecnm.png'),
          ),
        ),
        SizedBox(
          width: kIsWeb ? 100 : 60,
          height: kIsWeb ? 100 : 60,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Image.asset('assets/tec/itz.png'),
          ),
        ),
      ],
    );
  }

  Widget usuario() {
    return Container(
      width: 240,
      margin: const EdgeInsets.all(10.0),
      child: FocusScope(
        child: Focus(
          child: TextFormField(
            focusNode: focusUser,
            controller: contUser,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person),
              labelText: 'Usuario',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget password() {
    return Container(
      width: 240,
      margin: const EdgeInsets.all(10.0),
      child: TextFormField(
        focusNode: focusContra,
        validator: (value) {
          if (value!.isEmpty) {
            entrando = false;
            setState(() {});
            return 'Contraseña de Tecnamex requerida';
          }
          return null;
        },
        controller: contContra,
        obscureText: textoOculto,
        decoration: InputDecoration(
          prefixIcon: IconButton(
            icon: Icon(_icono),
            onPressed: () {
              setState(() {
                if (textoOculto) {
                  _icono = _iconoVisible;
                  textoOculto = false;
                } else {
                  _icono = _iconoOculto;
                  textoOculto = true;
                }
              });
            },
          ),
          labelText: 'Contraseña de Tecnamex',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
      ),
    );
  }

  void inicio() async {
    if (_formkey.currentState!.validate()) {
      String usuario = contUser.text;
      String password = contContra.text;
      User? userx;
      userx = await intentoIngreso(usuario, password);
      userx ??= await intentoIngreso('l$usuario@zacatepec.tecnm.mx', password);
      userx ??= await intentoIngreso('$usuario@tecnamex.com', password);
      userx ??= await intentoIngreso('m$usuario@zacatepec.tecnm.mx', password);
      userx ??= await intentoIngreso('d$usuario@zacatepec.tecnm.mx', password);
      entrando = false;
      if (userx != null) {
        contUser.text = '';
        contContra.text = '';
        if (usuarioTecnamex == null && passwordTecnamex == null) {
          await prefs.setString('usuarioTecnamex', contUser.text);
          await prefs.setString('passwordTecnamex', contContra.text);
        }
        Acceso.validaUsuario(usuario, widget.valido);
      } else {
        mensaje(
          'Error',
          'Error de usuario o contraseña.\n\n'
              'Reintenta nuevamente.\n'
              'Si persiste el error actualiza la Contraseña ',
          ok: false,
        );
      }
      setState(() {});
    }
  }

  Future<User?> intentoIngreso(String usuario, String password) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      return (await auth.signInWithEmailAndPassword(
        email: usuario,
        password: password,
      )).user;
    } catch (_) {}
    return null;
  }

  void mensaje(String titulo, String letrero, {bool? ok}) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        titulo,
        style: TextStyle(
          color: (ok == null || ok) ? Colors.black : Colors.white,
        ),
      ),
      messageText: Text(
        letrero,
        style: TextStyle(
          color: (ok == null || ok) ? Colors.black : Colors.white,
        ),
      ),
      backgroundColor: (ok == null || ok) ? Colors.green : Colors.red,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 4),
    );
  }

  Widget botonEntrar() {
    return GestureDetector(
      onTap: () {
        setState(() {
          entrando = true;
        });
        inicio();
      },
      child: Container(
        width: 200,
        height: 40,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 4, 52, 92),
          border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
        alignment: Alignment.center,
        child: const Text(
          'Ingresar',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
