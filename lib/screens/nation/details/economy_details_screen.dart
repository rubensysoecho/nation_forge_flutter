import 'package:flutter/material.dart';
import 'package:nation_forge/models/nation/economy_details.dart';

class EconomyDetailsScreen extends StatelessWidget {
  final EconomyDetails? economyDetails;

  const EconomyDetailsScreen({super.key, required this.economyDetails});

  @override
  Widget build(BuildContext context) {
    if (economyDetails == null) {
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
              'No hay información económica detallada disponible',
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
          _buildSystemOverview(),
          const SizedBox(height: 24),
          _buildSectorsAndResources(),
          const SizedBox(height: 24),
          _buildTradeAndInfrastructure(),
          const SizedBox(height: 24),
          _buildLaborAndWealth(),
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

  Widget _buildSystemOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Sistema Económico'),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Sistema', economyDetails!.economicSystem),
                _buildInfoRow('Estabilidad', economyDetails!.economicStability),
                _buildInfoRow('Inflación', economyDetails!.inflationRate),
                const Divider(height: 24),
                Row(
                  children: [
                    const Icon(Icons.monetization_on),
                    const SizedBox(width: 8),
                    const Text(
                      'Moneda',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildInfoRow('Nombre', economyDetails!.currency.currencyName),
                _buildInfoRow('Símbolo', economyDetails!.currency.currencySymbol),
                _buildInfoRow('Estabilidad', economyDetails!.currency.stability),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectorsAndResources() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Sectores y Recursos'),
        
        // Sectores clave
        if (economyDetails!.keySectors.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0, left: 4.0),
            child: Text(
              'Sectores Clave',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _buildKeySectors(),
          const SizedBox(height: 20),
        ],
        
        // Recursos naturales
        if (economyDetails!.naturalResources.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0, left: 4.0),
            child: Text(
              'Recursos Naturales',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _buildNaturalResources(),
        ],
      ],
    );
  }

  Widget _buildKeySectors() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: economyDetails!.keySectors.map((sector) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getSectorColor(sector.sectorName),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getSectorIcon(sector.sectorName),
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sector.sectorName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Importancia: ${sector.importance}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNaturalResources() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: economyDetails!.naturalResources.map((resource) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.landscape,
                    color: _getResourceColor(resource.abundance),
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resource.resourceName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Abundancia: ${resource.abundance}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTradeAndInfrastructure() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Comercio e Infraestructura'),
        
        // Política comercial
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.public),
                    const SizedBox(width: 8),
                    const Text(
                      'Política Comercial',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 16),
                _buildInfoRow('Apertura', economyDetails!.tradePolicy.openness),
                _buildInfoRow('Aranceles', economyDetails!.tradePolicy.tariffs),
                const SizedBox(height: 8),
                
                if (economyDetails!.tradePolicy.majorExports.isNotEmpty) ...[
                  _buildListSection('Principales Exportaciones', economyDetails!.tradePolicy.majorExports),
                  const SizedBox(height: 8),
                ],
                
                if (economyDetails!.tradePolicy.majorImports.isNotEmpty) ...[
                  _buildListSection('Principales Importaciones', economyDetails!.tradePolicy.majorImports),
                  const SizedBox(height: 8),
                ],
                
                if (economyDetails!.tradePolicy.tradeAgreements.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      'Acuerdos Comerciales',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ...economyDetails!.tradePolicy.tradeAgreements.map((agreement) => 
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.handshake, size: 18, color: Colors.blueGrey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text('${agreement.partnerNation}: ${agreement.agreementType}'),
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Infraestructura
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.domain),
                    const SizedBox(width: 8),
                    const Text(
                      'Infraestructura',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 16),
                _buildInfoRow('Transporte', economyDetails!.infrastructure.transportation),
                _buildInfoRow('Energía', economyDetails!.infrastructure.energy),
                _buildInfoRow('Comunicaciones', economyDetails!.infrastructure.communication),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLaborAndWealth() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Fuerza Laboral y Distribución'),
        
        // Fuerza laboral
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.work),
                    const SizedBox(width: 8),
                    const Text(
                      'Fuerza Laboral',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 16),
                _buildInfoRow('Tamaño Estimado', economyDetails!.laborForce.sizeEstimate),
                _buildInfoRow('Nivel de Habilidad', economyDetails!.laborForce.skillLevel),
                _buildInfoRow('Tasa de Desempleo', economyDetails!.laborForce.unemploymentRate),
                
                if (economyDetails!.laborForce.dominantIndustries.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  const Text(
                    'Industrias Dominantes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ...economyDetails!.laborForce.dominantIndustries.map((industry) => 
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0, left: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.arrow_right, size: 18),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(industry),
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Leyes económicas
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.gavel),
                    const SizedBox(width: 8),
                    const Text(
                      'Marco Legal Económico',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 16),
                _buildInfoRow('Derechos de Propiedad', economyDetails!.economicLaw.propertyRights),
                _buildInfoRow('Ley de Contratos', economyDetails!.economicLaw.contractLaw),
                _buildInfoRow('Sistema Tributario', economyDetails!.economicLaw.taxSystem),
                _buildInfoRow('Nivel de Regulación', economyDetails!.economicLaw.regulationLevel),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Distribución de la riqueza
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.money),
                    const SizedBox(width: 8),
                    const Text(
                      'Distribución de la Riqueza',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 16),
                Text(
                  economyDetails!.wealthDistribution,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 4.0, left: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_right, size: 18),
              const SizedBox(width: 4),
              Expanded(
                child: Text(item),
              ),
            ],
          ),
        )),
      ],
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

  Color _getSectorColor(String sectorName) {
    final name = sectorName.toLowerCase();
    if (name.contains('agricult')) return Colors.green;
    if (name.contains('tecnolog') || name.contains('techn')) return Colors.blue;
    if (name.contains('minería') || name.contains('mining')) return Colors.brown;
    if (name.contains('energía') || name.contains('energy')) return Colors.orange;
    if (name.contains('manufactura') || name.contains('industry')) return Colors.indigo;
    if (name.contains('finanz') || name.contains('financ')) return Colors.purple;
    if (name.contains('turismo') || name.contains('tourism')) return Colors.teal;
    return Colors.blueGrey;
  }

  IconData _getSectorIcon(String sectorName) {
    final name = sectorName.toLowerCase();
    if (name.contains('agricult')) return Icons.agriculture;
    if (name.contains('tecnolog') || name.contains('techn')) return Icons.computer;
    if (name.contains('minería') || name.contains('mining')) return Icons.graphic_eq;
    if (name.contains('energía') || name.contains('energy')) return Icons.flash_on;
    if (name.contains('manufactura') || name.contains('industry')) return Icons.precision_manufacturing;
    if (name.contains('finanz') || name.contains('financ')) return Icons.account_balance;
    if (name.contains('turismo') || name.contains('tourism')) return Icons.beach_access;
    return Icons.business;
  }

  Color _getResourceColor(String abundance) {
    switch (abundance.toLowerCase()) {
      case 'alta':
      case 'abundante':
        return Colors.green;
      case 'media':
      case 'moderada':
        return Colors.amber;
      case 'baja':
      case 'escasa':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}