import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'acceso.dart';

class AccesoTelefono extends StatefulWidget {
  final Function valido;
  const AccesoTelefono(this.valido, {super.key});

  @override
  State<AccesoTelefono> createState() => _AccesoTelefonoState();
}

class _AccesoTelefonoState extends State<AccesoTelefono> {
  String verificationId = '';
  TextEditingController controladorCelular = TextEditingController();
  TextEditingController controladorCodigo = TextEditingController();
  String celular = '';

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        pideCodigo();
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
          child: Icon(
            Icons.phone,
            color: Theme.of(context).colorScheme.primary,
            size: 40,
          ),
        ),
      ),
    );
  }

  void pideCodigo() {
    showDialog(
      context: context,
      builder:
          (b) => Dialog(
            backgroundColor: Colors.transparent,
            child: AlertDialog(
              title: const Center(child: Text('Acceso por teléfono')),
              content: SizedBox(
                width: 300,
                child: Column(
                  spacing: 10,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...campos(),
                    MaterialButton(
                      color: const Color.fromARGB(255, 10, 69, 117),
                      onPressed: () async {
                        celular = controladorCelular.text;
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: '+52$celular',
                          verificationCompleted: (e) {
                            //  print('verificacion completa:$e');
                          },
                          verificationFailed: (e) {
                            // print('Numero invalido');
                          },
                          codeSent: (s, w) {
                            verificationId = s;
                          },
                          codeAutoRetrievalTimeout: (m) {
                            //print('time:$m');
                          },
                        );
                      },
                      child: const Text(
                        'Solicitar código',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: controladorCodigo,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.numbers),
                        labelText: 'Código recibido',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),

                    MaterialButton(
                      color: const Color.fromARGB(255, 10, 69, 117),
                      onPressed: () async {
                        try {
                          final cred = PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: controladorCodigo.text,
                          );
                          UserCredential cc = await auth.signInWithCredential(
                            cred,
                          );

                          if (cc.user != null) {
                            Acceso.validaUsuario(celular, widget.valido);
                            Navigator.of(context).pop();
                          }
                        } catch (e) {
                          Acceso.errorAcceso(
                            'Error',
                            error:
                                'Código de verificación incorrecto. Inténtalo de nuevo.',
                          );
                        }
                      },
                      child: const Text(
                        'Verificar código',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  List<Widget> campos() {
    return [
      SizedBox(
        width: 90,
        height: 90,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Image.asset('assets/tec/itz.png'),
        ),
      ),
      const Text('''Este medio solo funciona 
si tienes registrado tu número de 
celular en tu expediente de tecnamex.
'''),

      TextField(
        controller: controladorCelular,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.phone),
          labelText: 'Celular',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
      ),
    ];
  }
}
