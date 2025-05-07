import 'package:flutter/material.dart';
import 'package:nation_forge/data/models/nation/politics_details.dart';

class PoliticsDetailsScreen extends StatelessWidget {
  final PoliticsDetails? politicsDetails;

  const PoliticsDetailsScreen({super.key, required this.politicsDetails});

  @override
  Widget build(BuildContext context) {
    if (politicsDetails == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.info_outline,
              size: 60,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No hay información política detallada disponible',
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Política Interior'),
          _buildInteriorPolitics(politicsDetails!.interior),
          const SizedBox(height: 24),
          _buildSectionTitle('Política Exterior'),
          _buildExteriorPolitics(politicsDetails!.exterior),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInteriorPolitics(InteriorPolitics interior) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoCard(
          title: 'Gobierno',
          icon: Icons.account_balance,
          children: [
            _buildInfoRow('Tipo de Gobierno', interior.governmentType),
            _buildInfoRow('Estabilidad Política', interior.politicalStability),
            _buildInfoRow('Ideología Política', interior.politicalIdeology),
          ],
        ),
        const SizedBox(height: 16),
        
        _buildInfoCard(
          title: 'Líder',
          icon: Icons.person,
          children: [
            _buildInfoRow('Nombre', interior.leader.name),
            _buildInfoRow('Título', interior.leader.title),
            _buildInfoRow('Partido Gobernante', interior.leader.rulingParty),
            _buildInfoRow('Sucesión', interior.leader.succession),
          ],
        ),
        const SizedBox(height: 16),

        _buildInfoCard(
          title: 'Poder Legislativo',
          icon: Icons.gavel,
          children: [
            _buildInfoRow('Nombre', interior.legislativeBranch.name),
            _buildInfoRow('Estructura', interior.legislativeBranch.structure),
            _buildInfoRow('Poderes', interior.legislativeBranch.powers),
          ],
        ),
        const SizedBox(height: 16),

        _buildInfoCard(
          title: 'Poder Judicial',
          icon: Icons.balance,
          children: [
            _buildInfoRow('Nombre', interior.judicialBranch.name),
            _buildInfoRow('Estructura', interior.judicialBranch.structure),
            _buildInfoRow('Poderes', interior.judicialBranch.powers),
          ],
        ),
        const SizedBox(height: 16),

        _buildTensionsSection(interior.tensions),
      ],
    );
  }

  Widget _buildExteriorPolitics(ExteriorPolitics exterior) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGeopoliticsSection(exterior.geopolitics),
        const SizedBox(height: 16),
        _buildInfluencesSection(exterior.influences),
      ],
    );
  }

  Widget _buildGeopoliticsSection(Geopolitics geopolitics) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Geopolítica',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        
        // Guerras
        if (geopolitics.wars.isNotEmpty) ...[
          const Text(
            'Guerras',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          ...geopolitics.wars.map((war) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.flag, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            war.nation,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            war.date,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      _buildInfoRow('Razón', war.reason),
                      _buildInfoRow('Resultado', war.outcome),
                    ],
                  ),
                ),
              )),
          const SizedBox(height: 16),
        ],

        // Alianzas
        if (geopolitics.alliances.isNotEmpty) ...[
          const Text(
            'Alianzas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          ...geopolitics.alliances.map((alliance) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.handshake, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            alliance.nation,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            alliance.date,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      _buildInfoRow('Propósito', alliance.purpose),
                    ],
                  ),
                ),
              )),
        ],
      ],
    );
  }

  Widget _buildInfluencesSection(List<Influence> influences) {
    if (influences.isEmpty) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Influencias Extranjeras',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...influences.map((influence) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.compare_arrows, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            influence.nation,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    _buildInfoRow('Tipo de Influencia', influence.type),
                    _buildInfoRow('Intensidad', influence.strength),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildTensionsSection(Tensions tensions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tensiones Internas',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        
        // Tensiones culturales
        if (tensions.cultural.isNotEmpty) ...[
          const Text(
            'Tensiones Culturales',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          ...tensions.cultural.map((tension) => _buildTensionCard(
                group: tension.group,
                issue: tension.issue,
                severity: tension.severity,
                icon: Icons.people,
              )),
          const SizedBox(height: 16),
        ],

        // Tensiones políticas
        if (tensions.political.isNotEmpty) ...[
          const Text(
            'Tensiones Políticas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          ...tensions.political.map((tension) => _buildTensionCard(
                group: tension.party,
                issue: tension.issue,
                severity: tension.severity,
                icon: Icons.how_to_vote,
              )),
        ],
      ],
    );
  }

  Widget _buildTensionCard({
    required String group,
    required String issue,
    required String severity,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    group,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getSeverityColor(severity),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    severity,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            Text(
              issue,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'alta':
        return Colors.red;
      case 'media':
        return Colors.orange;
      case 'baja':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  Widget _buildInfoCard({
    required String title, 
    required IconData icon, 
    required List<Widget> children
  }) {
    return Card(
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}