// ignore_for_file: prefer_const_constructors

import 'package:agenda/pages/boot_page/boot_page.dart';
import 'package:agenda/services/eventshub_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();
  String? mensajeErrorServidor;
  bool loginMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailInput,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "usuario@email.com",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _passwordInput,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "12345678",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              if (loginMode)
                ElevatedButton(
                  onPressed: onLoginPressed,
                  child: Text("Iniciar sesión",
                      style: TextStyle(color: Colors.black, fontSize: 25)),
                ),
              if (!loginMode)
                ElevatedButton(
                  onPressed: onCreateAccountPressed,
                  child: Text("Crear cuenta",
                      style: TextStyle(color: Colors.black, fontSize: 25)),
                ),
              SizedBox(
                height: 20,
              ),
              if (loginMode)
                TextButton(
                  onPressed: onSwitchForm,
                  child: Text("¿No tienes una cuenta? Toca aquí para crearla"),
                ),
              if (!loginMode)
                TextButton(
                  onPressed: onSwitchForm,
                  child: Text(
                      "Ya tienes una cuenta. Toca aquí para iniciar sesión"),
                ),
              if (mensajeErrorServidor != null) ...[
                SizedBox(height: 30),
                Text(
                  mensajeErrorServidor!,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  void onSwitchForm() {
    setState(() {
      loginMode = !loginMode;
      mensajeErrorServidor = null;
    });
  }

  void onLoginPressed() async {
    EventsHubSrv eventsHub = Provider.of<EventsHubSrv>(context, listen: false);
    try {
      User? user =
          await eventsHub.onLogin(_emailInput.text, _passwordInput.text);
      print("Inicio de sesión exitoso");
      print(user);
      mensajeErrorServidor = null;
      if (!context.mounted) return;

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => BootPage(),
      ));
    } on FirebaseAuthException catch (e) {
      setState(() {
        mensajeErrorServidor = obtenerMensajeError(e.code);
      });
    }
  }

  void onCreateAccountPressed() async {
    EventsHubSrv eventsHub = Provider.of<EventsHubSrv>(context, listen: false);
    try {
      User? user = await eventsHub.onCreateAccount(
          _emailInput.text, _passwordInput.text);
      print("Cuenta creda con éxito");
      print(user);
      mensajeErrorServidor = null;

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => BootPage(),
      ));
    } on FirebaseAuthException catch (e) {
      print(e);
      setState(() {
        mensajeErrorServidor = obtenerMensajeError(e.code);
      });
    }
  }

  String obtenerMensajeError(String errorCode) {
    return switch (errorCode) {
      "invalid-email" => "El email es inválido.",
      "email-already-in-use" => "El email ya está siendo utilizado",
      "weak-password" => "El password no es lo suficientemente fuerte",
      "user-disabled" => "La cuenta está deshabilitada",
      "user-not-found" => "El usuario no existe",
      "wrong-password" => "Password incorrecto",
      "too-many-requests" => "Demasiadas peticiones",
      "user-token-expired" => "El token del usuario ha expirado",
      "network-request-failed" => "Fallo en la conexíón de red",
      "invalid-credential" => "Credenciales inválidas",
      "operation-not-allowed" => "Operación no permitida",
      _ => "Error al iniciar sesión"
    };
  }
}
