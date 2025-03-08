import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nation_forge/blocs/nation_event.dart';
import 'package:nation_forge/blocs/war_bloc.dart';
import 'package:nation_forge/screens/wars_list.dart';
import '../blocs/nation_bloc.dart';
import 'nations_list.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    NationsList(),
    WarsList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    context.read<NationBloc>().add(LoadNations());

    final warBloc = WarBloc();
    warBloc.add(LoadWars());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Generador de Naciones',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Naciones Generadas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports),
            label: 'Guerras Generadas',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
      ),
      body: _pages[_selectedIndex],
    );
  }
}
