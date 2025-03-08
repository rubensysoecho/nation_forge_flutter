import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nation_forge/screens/dashboard.dart';
import 'app_theme.dart';
import 'blocs/nation_bloc.dart';
import 'blocs/war_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WarBloc>(create: (context) => WarBloc()),
        BlocProvider<NationBloc>(create: (context) => NationBloc()),
      ],
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
