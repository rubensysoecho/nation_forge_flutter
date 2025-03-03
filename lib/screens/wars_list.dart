import 'package:flutter/material.dart';
import 'package:nation_forge/widgets/nation_list.dart';

class WarsList extends StatefulWidget {
  const WarsList({super.key});

  @override
  State<WarsList> createState() => _WarsListState();
}

class _WarsListState extends State<WarsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Explora y crea nuevas naciones de manera intuitiva',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Text('ESTO SON GUERRAS'),
          )
        ],
      ),
    );
  }
}
