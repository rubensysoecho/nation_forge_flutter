import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nation_forge/core/l10n/app_localizations.dart';
import 'package:nation_forge/presentation/views/login.dart';
import 'app_theme.dart';
import '../presentation/providers/blocs/auth/auth_bloc.dart';
import '../presentation/providers/blocs/nation/nation_bloc.dart';

class MyApp extends StatefulWidget {
  final Locale locale;
  
  const MyApp({super.key, required this.locale});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = widget.locale;
  }

  void _changeLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
      AppLocalizations.setLocale(newLocale.languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NationBloc>(create: (context) => NationBloc()),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
      ],
      child: AppLocalizationsProvider(
        locale: _locale,
        onChangeLocale: _changeLocale,
        child: MaterialApp(
          title: 'Nation Forge',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          locale: _locale,
          supportedLocales: const [
            Locale('es'), // Español
            Locale('en'), // Inglés
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: LoginPage()
        ),
      ),
    );
  }
}
