import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nation_forge/app_theme.dart';
import 'package:shimmer/shimmer.dart';
import 'package:nation_forge/screens/nation/details/nation_detail.dart';
import '../blocs/nation_bloc.dart';
import '../blocs/nation_event.dart';
import '../blocs/nation_state.dart';
import '../models/nation/nation.dart';

class NationList extends StatefulWidget {
  List<Nation> nationsList = [];
  @override
  State<NationList> createState() => _NationListState();
}

class _NationListState extends State<NationList> {

  Widget _buildNationCard(Nation nation) {
    return Dismissible(
      key: Key(nation.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20.0),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: AppTheme.primaryColor,
              title: const Text('Confirmar eliminación'),
              content: Text('¿Estás seguro que deseas eliminar la nación "${nation.nationName}"?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Eliminar', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        context.read<NationBloc>().add(DeleteNation(nation.id));
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: const Icon(Icons.flag),
          title: Text(nation.nationName),
          subtitle: Text(
              'Creado el ${nation.createdAt.day}/${nation.createdAt.month}/${nation.createdAt.year}'),
          trailing: IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NationDetailPage(nation: nation),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingNationCard() {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.6, end: 1.0).animate(AnimationController(
        vsync: Navigator.of(context),
        duration: const Duration(milliseconds: 800),
      )..repeat(reverse: true)),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          leading: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            direction: ShimmerDirection.ltr,
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 24,
            ),
          ),
          title: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            direction: ShimmerDirection.ltr,
            child: Container(
              height: 18,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          subtitle: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            direction: ShimmerDirection.ltr,
            child: Container(
              height: 14,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNationList(List<Nation> nations) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: nations.length,
      itemBuilder: (context, index) => _buildNationCard(nations[index]),
    );
  }

  Widget _buildNoNationsView() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.flag,
                size: 80,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'No hay naciones disponibles',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pulsa + para crear una nueva nación',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Desliza hacia abajo para actualizar',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[400],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<NationBloc, NationState>(
        listener: (context, state) {
          if (state is NationCreated) {
            widget.nationsList.add(state.newNation);
          }
          if (state is NationLoaded) {
            widget.nationsList = state.nations;
          }
        },
        builder: (context, state) {
          if (state is NationLoading) {
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) => _buildLoadingNationCard(),
            );
          }
          return widget.nationsList.isNotEmpty
              ? _buildNationList(widget.nationsList)
              : _buildNoNationsView();
        },
      ),
    );
  }
}
