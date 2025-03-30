import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nation_forge/app_theme.dart';
import 'package:nation_forge/blocs/nation_event.dart';
import 'package:nation_forge/screens/wars_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/nation_bloc.dart';
import 'login.dart';
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

  Future<void> _logOff() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.primaryColor,
          title: const Text('Cerrar sesión'),
          content: const Text('¿Seguro que quieres cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text(
                'Aceptar',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('user_id', '');
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),(route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    context.read<NationBloc>().add(LoadNations());
    //final warBloc = WarBloc();
    //warBloc.add(LoadWars());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _logOff();
            },
            icon: Icon(Icons.logout),
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Generador de Naciones',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Naciones',
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
      ),*/
      body: NationsList(),
    );
  }
}
