import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_localizations_es.dart';
import 'app_localizations_en.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static Future<Locale> getPreferredLocale() async {
    final prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language_code');
    if (languageCode == null) {
      return const Locale('es'); // Español como idioma predeterminado
    }
    return Locale(languageCode);
  }

  static Future<void> setLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode);
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'es': spanishValues,
    'en': englishValues,
  };

  // Método auxiliar para obtener valores localizados de manera segura
  String _getLocalizedValue(String key, String defaultValue) {
    // Verificar si el idioma actual está soportado
    if (!_AppLocalizationsDelegate().isSupported(locale)) {
      // Si no está soportado, usar español como respaldo
      return _localizedValues['es']?[key] ?? defaultValue;
    }
    
    // Obtener el valor del idioma actual, o usar el valor predeterminado si no existe la clave
    return _localizedValues[locale.languageCode]?[key] ?? defaultValue;
  }
  
  // Getters utilizando el nuevo método auxiliar
  String get appTitle => _getLocalizedValue('appTitle', 'Nation Forge');
  String get slogan => _getLocalizedValue('slogan', 'La historia es tuya.');
  
  // Login Screen
  String get loginButton => _getLocalizedValue('loginButton', 'Iniciar sesión');
  String get logoutConfirmation => _getLocalizedValue('logoutConfirmation', '¿Seguro que quieres cerrar sesión?');
  
  // Dashboard
  String get dashboard => _getLocalizedValue('dashboard', 'Panel Principal');
  String get nations => _getLocalizedValue('nations', 'Naciones');
  String get wars => _getLocalizedValue('wars', 'Guerras');
  String get createNation => _getLocalizedValue('createNation', 'Crear Nación');
  String get createWar => _getLocalizedValue('createWar', 'Crear Guerra');
  
  // Nation list
  String get noNationsAvailable => _getLocalizedValue('noNationsAvailable', 'No hay naciones disponibles');
  String get createNationHint => _getLocalizedValue('createNationHint', 'Pulsa + para crear una nueva nación');
  String get pullToRefresh => _getLocalizedValue('pullToRefresh', 'Desliza hacia abajo para actualizar');
  String get confirmDeletion => _getLocalizedValue('confirmDeletion', 'Confirmar eliminación');
  String get deletionConfirmation => _getLocalizedValue('deletionConfirmation', '¿Estás seguro que deseas eliminar la nación "{name}"?');
  
  // Nation details
  String get nationDetails => _getLocalizedValue('nationDetails', 'Detalles de la Nación');
  String get history => _getLocalizedValue('history', 'Historia');
  String get government => _getLocalizedValue('government', 'Gobierno');
  String get economy => _getLocalizedValue('economy', 'Economía');
  String get culture => _getLocalizedValue('culture', 'Cultura');
  
  // War details
  String get warDetails => _getLocalizedValue('warDetails', 'Detalles de la Guerra');
  String get participants => _getLocalizedValue('participants', 'Participantes');
  String get causes => _getLocalizedValue('causes', 'Causas');
  String get development => _getLocalizedValue('development', 'Desarrollo');
  String get outcome => _getLocalizedValue('outcome', 'Resultado');

  // Common buttons and labels
  String get save => _getLocalizedValue('save', 'Guardar');
  String get cancel => _getLocalizedValue('cancel', 'Cancelar');
  String get edit => _getLocalizedValue('edit', 'Editar');
  String get delete => _getLocalizedValue('delete', 'Eliminar');
  String get loading => _getLocalizedValue('loading', 'Cargando...');
  String get error => _getLocalizedValue('error', 'Error');
  String get success => _getLocalizedValue('success', 'Éxito');
  String get name => _getLocalizedValue('name', 'Nombre');
  String get description => _getLocalizedValue('description', 'Descripción');
  String get date => _getLocalizedValue('date', 'Fecha');
  String get year => _getLocalizedValue('year', 'Año');
  String get language => _getLocalizedValue('language', 'Idioma');
  String get english => _getLocalizedValue('english', 'Inglés');
  String get spanish => _getLocalizedValue('spanish', 'Español');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['es', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return Future.value(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

class AppLocalizationsProvider extends InheritedWidget {
  final Locale locale;
  final Function(Locale) onChangeLocale;

  const AppLocalizationsProvider({
    Key? key,
    required this.locale,
    required this.onChangeLocale,
    required Widget child,
  }) : super(key: key, child: child);

  static AppLocalizationsProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppLocalizationsProvider>()!;
  }

  @override
  bool updateShouldNotify(AppLocalizationsProvider oldWidget) {
    return locale != oldWidget.locale;
  }
}