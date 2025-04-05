import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

extension BuildContextExtensions on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this);
}