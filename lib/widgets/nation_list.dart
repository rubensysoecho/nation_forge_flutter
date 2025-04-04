import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:nation_forge/screens/nation/details/nation_detail.dart';
import '../blocs/nation_bloc.dart';
import '../blocs/nation_state.dart';
import '../models/nation/nation.dart';

class NationList extends StatefulWidget {
  List<Nation> nationsList = [];
  @override
  State<NationList> createState() => _NationListState();
}

class _NationListState extends State<NationList> {
  Widget _buildNationCard(Nation nation) {
    return Card(
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
      itemCount: nations.length,
      itemBuilder: (context, index) => _buildNationCard(nations[index]),
    );
  }

  Widget _buildNoNationsView() {
    return const Center(child: Text('No hay naciones disponibles'));
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
