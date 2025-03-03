import 'package:flutter/material.dart';

class NationCreateButton extends StatefulWidget {
  const NationCreateButton({super.key});

  @override
  State<NationCreateButton> createState() => _NationCreateButtonState();
}

class _NationCreateButtonState extends State<NationCreateButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ElevatedButton.icon(
          onPressed: () => Navigator.pushNamed(context, '/create'),
          icon: const Icon(Icons.add),
          label: const Text('Crear Nación'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
