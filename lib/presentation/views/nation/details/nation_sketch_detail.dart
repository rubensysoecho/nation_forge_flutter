import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:nation_forge/core/utils/extensions.dart';
import 'package:nation_forge/data/models/nation/nation.dart';
import 'package:nation_forge/data/models/nation/nation_sketch.dart';
import 'package:nation_forge/presentation/providers/blocs/nation/nation_state.dart';
import 'package:nation_forge/presentation/views/nation/details/politics_details_screen.dart';
import 'package:nation_forge/presentation/views/nation/details/economy_details_screen.dart';
import 'package:nation_forge/presentation/views/nation/details/population_details_screen.dart';
import 'package:nation_forge/presentation/views/nation/timeline.dart';

import '../../../providers/blocs/nation/nation_bloc.dart';
import '../../../providers/blocs/nation/nation_event.dart';

class NationSketchDetailPage extends StatefulWidget {
  final NationSketch sketch;

  const NationSketchDetailPage({super.key, required this.sketch});

  @override
  State<NationSketchDetailPage> createState() => _NationSketchDetailPageState();
}

class _NationSketchDetailPageState extends State<NationSketchDetailPage> {
  int _selectedIndex = 0;
  Nation? _nation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NationBloc>().add(LoadNationDetails(widget.sketch.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.sketch.nationName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<NationBloc, NationState>(
        listener: (context, state) {
          if (state is NationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is NationDetailsLoaded) {
            setState(() {
              _nation = state.nation;
            });
          }
        },
        builder: (context, state) {
          if (state is NationLoading || _nation == null) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballPulseSync,
                      strokeWidth: 2,
                    ),
                  ),
                  Text(context.localization.generatingNationDetails),
                ],
              ),
            );
          }
          return _buildBody(_selectedIndex);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'General',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Política',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Economía',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Demografía',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'Timeline',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return _buildDetailView();
      case 1:
        return PoliticsDetailsScreen(politicsDetails: _nation?.politicsDetails);
      case 2:
        return EconomyDetailsScreen(economyDetails: _nation?.economyDetails);
      case 3:
        return PopulationDetailsScreen(
            populationDetails: _nation?.populationDetails);
      case 4:
        return Timeline(
            events: _nation!.events, nationName: _nation!.nationName);
      default:
        return _buildDetailView();
    }
  }

  Widget _buildDetailView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(context),
          const SizedBox(height: 20),
          _buildInfoSection(
            context,
            icon: Icons.history,
            title: 'Contexto Histórico',
            content: _nation!.historicalContext,
          ),
          _buildInfoSection(
            context,
            icon: Icons.public,
            title: 'Contexto Geopolítico',
            content: _nation!.geopoliticalContext,
          ),
          _buildInfoSection(
            context,
            icon: Icons.account_balance,
            title: 'Política',
            content: _nation!.politics,
          ),
          _buildInfoSection(
            context,
            icon: Icons.people,
            title: 'Población',
            content: _nation!.population,
          ),
          _buildListSection(
            context,
            icon: Icons.lightbulb,
            title: 'Curiosidades Históricas',
            items: _nation!.historicalCuriosities,
          ),
          _buildListSection(
            context,
            icon: Icons.person,
            title: 'Personajes Importantes',
            items: _nation!.importantCharacters,
          ),
          _buildCreationDate(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF3A2D1D),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.flag_circle,
            size: 60,
          ),
          const SizedBox(height: 8),
          Text(
            _nation!.nationName,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 16),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required List<String> items,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 16),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_right,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildCreationDate(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today),
                const SizedBox(width: 8),
                Text(
                  'Fecha de Creación',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 16),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  DateFormat('dd MMMM, yyyy - HH:mm')
                      .format(_nation!.createdAt),
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
