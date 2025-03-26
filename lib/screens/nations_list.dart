import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nation_forge/widgets/create_nation_dialog.dart';
import 'package:nation_forge/widgets/nation_list.dart';

import '../blocs/nation_bloc.dart';
import '../blocs/nation_event.dart';
import '../blocs/nation_state.dart';

class NationsList extends StatefulWidget {
  const NationsList({super.key});

  @override
  State<NationsList> createState() => _NationsListState();
}

class _NationsListState extends State<NationsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return CreateNationDialog();
            },
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: const Icon(Icons.add),
      ),
      body: BlocListener<NationBloc, NationState>(
        listener: (context, state) {
          if (state is NationError) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
            ),
            NationList(),
          ],
        ),
      ),
    );
  }
}
