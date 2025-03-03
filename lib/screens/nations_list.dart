import 'package:flutter/material.dart';
import 'package:nation_forge/widgets/nation_list.dart';

class NationsList extends StatefulWidget {
  const NationsList({super.key});

  @override
  State<NationsList> createState() => _NationsListState();
}

class _NationsListState extends State<NationsList> {
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
          NationList(),
          //NationCreateButton(),
        ],
      ),
    );
  }
}
