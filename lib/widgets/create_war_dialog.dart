// filepath: /Users/administrador/AndroidStudioProjects/nation_forge/lib/widgets/create_war_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nation_forge/blocs/war_bloc.dart';
import '../app_theme.dart';

class CreateWarDialog extends StatefulWidget {
  const CreateWarDialog({super.key});

  @override
  State<CreateWarDialog> createState() => _CreateWarDialogState();
}

class _CreateWarDialogState extends State<CreateWarDialog> {
  final TextEditingController _nationAController = TextEditingController();
  final TextEditingController _nationBController = TextEditingController();
  final TextEditingController _casusBelliController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.primaryColor.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Colors.white30,
          width: 1.5,
        ),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Crear Nueva Guerra',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                shadows: [
                  const Shadow(
                    blurRadius: 3.0,
                    color: Colors.black26,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: _nationAController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Nación Atacante',
                labelStyle: const TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white30),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: AppTheme.primaryColor.withOpacity(0.3),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _nationBController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Nación Defensora',
                labelStyle: const TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white30),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: AppTheme.primaryColor.withOpacity(0.3),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _casusBelliController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Casus Belli (Motivo)',
                labelStyle: const TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white30),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: AppTheme.primaryColor.withOpacity(0.3),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _ageController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Época',
                labelStyle: const TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white30),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: AppTheme.primaryColor.withOpacity(0.3),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                if (_nationAController.text.isEmpty ||
                    _nationBController.text.isEmpty ||
                    _casusBelliController.text.isEmpty ||
                    _ageController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "Por favor, rellene todos los campos.",
                    toastLength: Toast.LENGTH_SHORT,
                  );
                } else {
                  context.read<WarBloc>().add(CreateWar(
                      _nationAController.text,
                      _nationBController.text,
                      _casusBelliController.text,
                      _ageController.text));
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.secondaryColor,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                shadowColor: Colors.black26,
              ),
              child: const Text(
                'Generar',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}