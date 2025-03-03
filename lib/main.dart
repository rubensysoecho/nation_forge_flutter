import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nation_forge/screens/dashboard.dart';
import 'app_theme.dart';
import 'blocs/nation_bloc.dart';
import 'blocs/nation_event.dart';
import 'screens/nations_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NationBloc()..add(LoadNations()),
      child: MaterialApp(
        title: 'Historical Nation Generator',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: Dashboard(),
      ),
    );
  }
}
