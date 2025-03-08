import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nation_forge/blocs/war_bloc.dart';
import 'package:nation_forge/screens/war_detail.dart';
import '../blocs/nation_bloc.dart';
import '../blocs/nation_event.dart';

class WarList extends StatefulWidget {
  @override
  State<WarList> createState() => _WarListState();
}

class _WarListState extends State<WarList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<WarBloc, WarState>(
        builder: (context, state) {
          if (state is WarLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else if (state is WarLoaded) {
            return ListView.builder(
              itemCount: state.wars.length,
              itemBuilder: (context, index) {
                final war = state.wars[index];
                return Card(
                  elevation: 3,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.flag),
                    title: Text(
                        "Guerra ${war.aggressorCountry.name} - ${war.defenderCountry.name}"),
                    subtitle: Text(war.results),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WarDetailPage(
                              war: war,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Column(
              children: [
                const Center(child: Text('No hay naciones disponibles')),
                IconButton(
                  onPressed: () {
                    context.read<WarBloc>().add(LoadWars());
                  },
                  icon: Icon(Icons.refresh),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
