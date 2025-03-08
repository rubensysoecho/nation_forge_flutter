import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nation_forge/screens/nation_detail.dart';
import '../blocs/nation_bloc.dart';
import '../blocs/nation_event.dart';
import '../blocs/nation_state.dart';

class NationList extends StatefulWidget {
  @override
  State<NationList> createState() => _NationListState();
}

class _NationListState extends State<NationList> {
  @override
  void initState() {
    super.initState();
  }

  Future _refresh() async  {
    context.read<NationBloc>().add(LoadNations());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<NationBloc, NationState>(
        builder: (context, state) {
          if (state is NationLoading) {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          } else if (state is NationLoaded) {
            return RefreshIndicator(
              color: Theme.of(context).primaryColor,
              onRefresh: _refresh,
              child: ListView.builder(
                itemCount: state.nations.length,
                itemBuilder: (context, index) {
                  final nation = state.nations[index];
                  return Card(
                    elevation: 3,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.flag),
                      title: Text(nation.nationName),
                      subtitle: Text(nation.id),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NationDetailPage(nation: nation),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Column(
              children: [
                const Center(child: Text('No hay naciones disponibles')),
                IconButton(
                  onPressed: () {
                    context.read<NationBloc>().add(LoadNations());
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
