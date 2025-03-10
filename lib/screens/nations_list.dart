import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nation_forge/widgets/nation_list.dart';

import '../blocs/nation_bloc.dart';
import '../blocs/nation_event.dart';

class NationsList extends StatefulWidget {
  const NationsList({super.key});

  @override
  State<NationsList> createState() => _NationsListState();
}

class _NationsListState extends State<NationsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String nationName = '';
              String governmentType = '';
              String age = '';
              return AlertDialog(
                icon: Icon(Icons.flag),
                title: const Text('Crear Nueva Nación'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Nombre de la nación',
                      ),
                      onChanged: (value) => nationName = value,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Tipo de Gobierno',
                      ),
                      onChanged: (value) => governmentType = value,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Época',
                      ),
                      onChanged: (value) => age = value,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<NationBloc>()
                          .add(CreateNation(nationName, governmentType, age));
                      Navigator.of(context).pop();
                    },
                    child: const Text('Crear'),
                  )
                ],
              );
            },
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
          ),
          NationList(),
          //NationCreateButton(),
        ],
      ),
    );
  }
}
