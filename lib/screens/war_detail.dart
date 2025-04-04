import 'package:flutter/material.dart';

import '../models/war/war.dart';

class WarDetailPage extends StatelessWidget {
  final War war;

  WarDetailPage({required this.war});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles de la guerra',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildOffensiveSection(context, 'Aggressor', war.aggressorCountry, war.aggressorCountry.casusBelli),
            _buildDefenderSection(context, 'Defender', war.defenderCountry),
            _buildWarProgressSection(context),
            _buildInfoSection(context, icon: Icons.person, title: 'Soldier View', content: war.soldierView),
            _buildListSection(context, icon: Icons.local_hospital, title: 'Casualties', items: war.kia),
            _buildInfoSection(context, icon: Icons.flag, title: 'Results', content: war.results),
            _buildInfoSection(context, icon: Icons.emoji_events, title: 'Winner', content: war.winner),
          ],
        ),
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
            Icons.military_tech,
            size: 60,
          ),
          const SizedBox(height: 8),
          Text(
            '${war.aggressorCountry.name} vs ${war.defenderCountry.name}',
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

  Widget _buildOffensiveSection(BuildContext context, String role, AggressorCountry country, [String? casusBelli]) {
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
                Icon(Icons.flag),
                const SizedBox(width: 8),
                Text(
                  '$role: ${country.name}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 16),
            if (casusBelli != null) _buildInfoSection(context, icon: Icons.warning, title: 'Casus Belli', content: casusBelli),
            _buildInfoSection(context, icon: Icons.group, title: 'Troops', content: country.troops),
            _buildListSection(context, icon: Icons.check, title: 'Advantages', items: country.advantages),
            _buildListSection(context, icon: Icons.close, title: 'Disadvantages', items: country.disadvantages),
            _buildListSection(context, icon: Icons.build, title: 'Equipment', items: country.equipment),
          ],
        ),
      ),
    );
  }

  Widget _buildDefenderSection(BuildContext context, String role, DefenderCountry country, [String? casusBelli]) {
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
                Icon(Icons.flag),
                const SizedBox(width: 8),
                Text(
                  '$role: ${country.name}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 16),
            if (casusBelli != null) _buildInfoSection(context, icon: Icons.warning, title: 'Casus Belli', content: casusBelli),
            _buildInfoSection(context, icon: Icons.group, title: 'Troops', content: country.troops),
            _buildListSection(context, icon: Icons.check, title: 'Advantages', items: country.advantages),
            _buildListSection(context, icon: Icons.close, title: 'Disadvantages', items: country.disadvantages),
            _buildListSection(context, icon: Icons.build, title: 'Equipment', items: country.equipment),
          ],
        ),
      ),
    );
  }

  Widget _buildWarProgressSection(BuildContext context) {
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
                Icon(Icons.timeline),
                const SizedBox(width: 8),
                Text(
                  'War Progress',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 16),
            ...war.warProgress.map((progress) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Day ${progress.day}:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  ...progress.events.map((event) => Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                    child: Text('- $event', style: TextStyle(fontSize: 14)),
                  )),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, {required IconData icon, required String title, required String content}) {
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
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(height: 16),
            Text(content, style: const TextStyle(fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }

  Widget _buildListSection(BuildContext context, {required IconData icon, required String title, required List<String> items}) {
    return _buildInfoSection(context, icon: icon, title: title, content: items.join(', '));
  }
}