import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/nation_bloc.dart';
import '../blocs/nation_event.dart';
import '../models/nation.dart';

class NationForm extends StatefulWidget {
  @override
  _NationFormState createState() => _NationFormState();
}

class _NationFormState extends State<NationForm> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Nombre')),
        TextField(controller: _descriptionController, decoration: InputDecoration(labelText: 'Descripción')),
      ],
    );
  }
}
