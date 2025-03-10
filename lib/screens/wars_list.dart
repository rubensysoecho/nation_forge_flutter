import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nation_forge/blocs/war_bloc.dart';
import 'package:nation_forge/widgets/war_list.dart';

import '../models/war.dart';

class WarsList extends StatefulWidget {
  const WarsList({super.key});

  @override
  State<WarsList> createState() => _WarsListState();
}

class _WarsListState extends State<WarsList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String nationA = '';
              String nationB = '';
              String casusBelli = '';
              String age = '';
              return AlertDialog(
                icon: Icon(Icons.military_tech),
                title: const Text('Crear Nueva Guerra'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Nación Atacante',
                      ),
                      onChanged: (value) => nationA = value,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Nación Defensora',
                      ),
                      onChanged: (value) => nationB = value,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Casus Belli (Motivo)',
                      ),
                      onChanged: (value) => casusBelli = value,
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
                          .read<WarBloc>()
                          .add(CreateWar(nationA, nationB, casusBelli, age));
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
          WarList(),
        ],
      ),
    );
  }
}
