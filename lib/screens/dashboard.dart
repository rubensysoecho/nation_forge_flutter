import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nation_forge/app_theme.dart';
import 'package:nation_forge/blocs/nation_event.dart';
import 'package:nation_forge/l10n/app_localizations.dart';
import 'package:nation_forge/screens/wars_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/nation_bloc.dart';
import 'login.dart';
import 'nations_list.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../utils/extensions.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  String _version = 'Cargando...';

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
    final localizations = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.primaryColor,
          title: Text(localizations.loginButton),
          content: Text(localizations.logoutConfirmation),
          actions: <Widget>[
            TextButton(
              child: Text(
                localizations.cancel,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(
                localizations.save,
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
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _changeLanguage() {
    final localizations = AppLocalizations.of(context);
    final provider = AppLocalizationsProvider.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.primaryColor,
          title: Text(localizations.language),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(localizations.spanish,
                    style: TextStyle(color: Colors.white)),
                trailing: provider.locale.languageCode == 'es'
                    ? Icon(Icons.check, color: Colors.white)
                    : null,
                onTap: () {
                  provider.onChangeLocale(const Locale('es'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(localizations.english,
                    style: TextStyle(color: Colors.white)),
                trailing: provider.locale.languageCode == 'en'
                    ? Icon(Icons.check, color: Colors.white)
                    : null,
                onTap: () {
                  provider.onChangeLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _initVersion();
    context.read<NationBloc>().add(LoadNations());
  }

  Future<void> _initVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _version = 'v${packageInfo.version}';
      });
    } catch (e) {
      print('Error al obtener la versión: $e');
      _version = 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          // Selector de idioma
          IconButton(
            onPressed: _changeLanguage,
            icon: Icon(Icons.language),
            tooltip: localizations.language,
          ),
          // Botón de cerrar sesión
          IconButton(
            onPressed: _logOff,
            icon: Icon(Icons.logout),
            tooltip: localizations.loginButton,
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          localizations.appTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Utilizamos el índice seleccionado para mostrar la página correspondiente
          _pages[_selectedIndex],
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: Text(
              _version,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
