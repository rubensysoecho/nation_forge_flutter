import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nation_forge/blocs/nation_bloc.dart';
import 'package:nation_forge/blocs/nation_event.dart';
import '../app_theme.dart';

class CreateNationDialog extends StatefulWidget {
  const CreateNationDialog({super.key});

  @override
  State<CreateNationDialog> createState() => _CreateNationDialogState();
}

class _CreateNationDialogState extends State<CreateNationDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _governmentTypeController =
      TextEditingController();
  final TextEditingController _eraController = TextEditingController();
  bool _isAC = false;

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
              'Crear Nación',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24, // Aumenta el tamaño de la fuente
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
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Nombre de la Nación',
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
                fillColor:
                    AppTheme.primaryColor.withOpacity(0.3), // Color de relleno
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _governmentTypeController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Tipo de Gobierno',
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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _eraController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Era',
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
                ),
                const SizedBox(width: 10),
                CupertinoSwitch(
                  value: _isAC,
                  onChanged: (bool value) {
                    setState(() {
                      _isAC = value;
                    });
                  },
                  activeTrackColor: AppTheme.secondaryColor,
                ),
                const SizedBox(width: 5),
                Text(
                  _isAC ? 'a.C' : 'd.C',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isEmpty ||
                    _governmentTypeController.text.isEmpty ||
                    _eraController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "Por favor, rellene todos los campos.",
                    toastLength: Toast.LENGTH_SHORT,
                  );
                } else {
                   context.read<NationBloc>().add(CreateNation(
                      _nameController.text,
                      _governmentTypeController.text,
                      '${_eraController.text} ${_isAC ? 'a.C' : 'd.C'}'));
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
