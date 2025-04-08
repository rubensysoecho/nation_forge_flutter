import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nation_forge/l10n/app_localizations.dart';
import 'package:nation_forge/screens/login.dart';
import 'app_theme.dart';
import 'blocs/auth_bloc.dart';
import 'blocs/nation_bloc.dart';
import 'blocs/war_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  // Obtener el idioma preferido guardado
  final locale = await AppLocalizations.getPreferredLocale();
  runApp(MyApp(locale: locale));
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack)  {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
} 

class MyApp extends StatefulWidget {
  final Locale locale;
  
  const MyApp({Key? key, required this.locale}) : super(key: key);

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
        BlocProvider<WarBloc>(create: (context) => WarBloc()),
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
