import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nation_forge/presentation/views/hub.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../views/dashboard.dart';

class LoginButton extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final auth = FirebaseAuth.instance;

  LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  Future<void> saveSession(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
  }

  /* Future<void> _signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential =
          await widget.auth.signInWithEmailAndPassword(
        email: widget.emailController.text,
        password: widget.passwordController.text,
      );
      if (userCredential.user != null) {
        await saveSession(userCredential.user!.uid);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HubPage(user: fire)),
        );
      } else {
        Fluttertoast.showToast(
          msg: 'No se pudo iniciar sesión. Usuario es nulo.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Error al iniciar sesión';
      if (e.code == 'user-not-found') {
        errorMessage = 'Usuario no encontrado.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Contraseña incorrecta.';
      }
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error inesperado: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  } */

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (widget.emailController.text.isEmpty ||
            widget.passwordController.text.isEmpty) {
          Fluttertoast.showToast(
            msg: 'Faltan credenciales por introducir',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          //_signInWithEmailAndPassword();
        }
      },

      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 14),
        minimumSize: Size(double.infinity, 0),
        backgroundColor: Color(0xFFE37613),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 6,
      ),
      child: Text(
        'Iniciar Sesión',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
