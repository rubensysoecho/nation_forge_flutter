import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nation_forge/core/l10n/app_localizations.dart';
import 'app/app.dart';

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
