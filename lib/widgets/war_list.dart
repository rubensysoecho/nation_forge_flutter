import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:nation_forge/blocs/war_bloc.dart';
import 'package:nation_forge/screens/war_detail.dart';
import '../models/war/war.dart';

class WarList extends StatefulWidget {
  @override
  State<WarList> createState() => _WarListState();
}

class _WarListState extends State<WarList> {
  Future<void> _refresh() async {
    context.read<WarBloc>().add(LoadWars());
  }

  Widget _buildWarCard(War war) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.flag),
        title: Text(war.name),
        subtitle: Text("Guerra ${war.aggressorCountry.name} - ${war.defenderCountry.name}"),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WarDetailPage(war: war)),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingWarCard() {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.6, end: 1.0)
          .animate(AnimationController(
        vsync: Navigator.of(context),
        duration: const Duration(milliseconds: 800),
      )..repeat(reverse: true)),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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

  Widget _buildWarList(List<War> wars) {
    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      onRefresh: _refresh,
      child: ListView.builder(
        itemCount: wars.length,
        itemBuilder: (context, index) => _buildWarCard(wars[index]),
      ),
    );
  }

  Widget _buildNoWarsView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(child: Text('No hay guerras disponibles')),
        IconButton(
          onPressed: () => context.read<WarBloc>().add(LoadWars()),
          icon: const Icon(Icons.refresh),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<WarBloc, WarState>(
        builder: (context, state) {
          switch (state) {
            case WarLoading():
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) => _buildLoadingWarCard(),
              );

            case WarLoaded():
              return state.wars.isNotEmpty ? _buildWarList(state.wars) : _buildNoWarsView();

            default:
              return _buildNoWarsView();
          }
        },
      ),
    );
  }
}