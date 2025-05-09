import 'package:flutter/material.dart';
import 'package:nation_forge/data/models/nation/population_details.dart';

class PopulationDetailsScreen extends StatelessWidget {
  final PopulationDetails? populationDetails;

  const PopulationDetailsScreen({super.key, required this.populationDetails});

  @override
  Widget build(BuildContext context) {
    if (populationDetails == null) {
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
              'No hay información demográfica detallada disponible',
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
          _buildGeneralPopulationSection(),
          const SizedBox(height: 24),
          _buildDemographicsSection(),
          const SizedBox(height: 24),
          _buildSocialSection(),
          const SizedBox(height: 24),
          _buildWorkforceSection(),
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

  Widget _buildGeneralPopulationSection() {
    final population = populationDetails!.population;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Información General'),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Población Total',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      population.totalPopulation,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Densidad',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      population.populationDensity,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Crecimiento',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            population.populationGrowthRate,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Edad Media',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            population.ageDistribution.medianAge,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 32),
                _buildUrbanRuralSplit(population.urbanRuralSplit),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUrbanRuralSplit(UrbanRuralSplit split) {
    final urbanPercent = double.tryParse(split.urbanPercentage.replaceAll('%', '')) ?? 50;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Distribución Urbana / Rural',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.location_city, color: Colors.blueGrey[700]),
            const SizedBox(width: 8),
            Text('Urbana: ${split.urbanPercentage}'),
            const Spacer(),
            Icon(Icons.nature_people, color: Colors.green[700]),
            const SizedBox(width: 8),
            Text('Rural: ${split.ruralPercentage}'),
          ],
        ),
        const SizedBox(height: 12),
        LinearProgressIndicator(
          value: urbanPercent / 100,
          backgroundColor: Colors.green[100],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey[700]!),
          minHeight: 10,
        ),
        const SizedBox(height: 12),
        if (split.majorCities.isNotEmpty) ...[
          const Text(
            'Ciudades Principales',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: split.majorCities.map((city) => Card(
              elevation: 0,
              color: Colors.blueGrey[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_city, size: 16, color: Colors.blueGrey[700]),
                    const SizedBox(width: 4),
                    Text(
                      city,
                      style: TextStyle(
                        color: Colors.blueGrey[800],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            )).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildDemographicsSection() {
    final population = populationDetails!.population;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Demografía'),
        
        // Distribución de edad
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
                    const Icon(Icons.cake),
                    const SizedBox(width: 8),
                    const Text(
                      'Distribución por Edad',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 16),
                
                // Grupos de edad
                ...population.ageDistribution.ageBrackets.map((bracket) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: _buildAgeBracketBar(bracket),
                )),
                
                const SizedBox(height: 8),
                _buildInfoRow(
                  'Relación de Dependencia', 
                  population.ageDistribution.dependencyRatio
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Expectativa de vida
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
                    const Icon(Icons.favorite),
                    const SizedBox(width: 8),
                    const Text(
                      'Expectativa de Vida',
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
                    Expanded(
                      child: _buildLifeExpectancy(
                        'Hombres',
                        population.lifeExpectancy.male,
                        Icons.male,
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildLifeExpectancy(
                        'Mujeres',
                        population.lifeExpectancy.female,
                        Icons.female,
                        Colors.pink,
                      ),
                    ),
                  ],
                ),
                
                const Divider(height: 24),
                Row(
                  children: [
                    const Text(
                      'General: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      population.lifeExpectancy.overall,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLifeExpectancy(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildAgeBracketBar(AgeBracket bracket) {
    final percentage = double.tryParse(bracket.percentage.replaceAll('%', '')) ?? 0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              bracket.bracket,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              bracket.percentage,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(_getAgeBracketColor(bracket.bracket)),
          minHeight: 8,
        ),
      ],
    );
  }

  Color _getAgeBracketColor(String bracket) {
    if (bracket.contains('0-14') || bracket.contains('joven')) {
      return Colors.green;
    } else if (bracket.contains('15-64') || bracket.contains('adulto')) {
      return Colors.blue;
    } else {
      return Colors.purple;
    }
  }

  Widget _buildSocialSection() {
    final population = populationDetails!.population;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Composición Social'),
        
        // Grupos étnicos
        if (population.ethnicGroups.isNotEmpty) ...[
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
                      const Icon(Icons.people),
                      const SizedBox(width: 8),
                      const Text(
                        'Grupos Étnicos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 16),
                  
                  ...population.ethnicGroups.map((group) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                group.groupName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              group.percentage,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        if (group.notes.isNotEmpty)
                          Text(
                            group.notes,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
        ],
        
        // Idiomas
        if (population.languages.isNotEmpty) ...[
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
                      const Icon(Icons.translate),
                      const SizedBox(width: 8),
                      const Text(
                        'Idiomas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 16),
                  
                  ...population.languages.map((language) => 
                    _buildStripWithStatus(
                      title: language.languageName,
                      value: language.percentageSpeakers,
                      status: language.status,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
        ],
        
        // Religiones
        if (population.religions.isNotEmpty) ...[
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
                      const Icon(Icons.church),
                      const SizedBox(width: 8),
                      const Text(
                        'Religiones',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 16),
                  
                  ...population.religions.map((religion) => 
                    _buildStripWithStatus(
                      title: religion.religionName,
                      value: religion.percentageAdherents,
                      status: religion.influence,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
        ],
        
        // Educación y Salud
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
                    const Icon(Icons.school),
                    const SizedBox(width: 8),
                    const Text(
                      'Educación y Salud',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 16),
                
                // Educación
                _buildInfoRow('Tasa de Alfabetización', population.literacyRate),
                _buildInfoRow('Nivel Educativo', population.educationLevel),
                
                const Divider(height: 24),
                
                // Salud
                Row(
                  children: [
                    const Icon(Icons.local_hospital, size: 18),
                    const SizedBox(width: 8),
                    const Text(
                      'Salud',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildInfoRow('Mortalidad Infantil', population.health.infantMortalityRate),
                _buildInfoRow('Acceso a Sanidad', population.health.accessToHealthcare),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStripWithStatus({
    required String title,
    required String value,
    required String status,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getStatusColor(status),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    final lowerStatus = status.toLowerCase();
    if (lowerStatus.contains('oficial') || lowerStatus.contains('alta')) {
      return Colors.blue;
    } else if (lowerStatus.contains('fuerte') || lowerStatus.contains('importante')) {
      return Colors.green;
    } else if (lowerStatus.contains('media') || lowerStatus.contains('moderada')) {
      return Colors.orange;
    } else if (lowerStatus.contains('baja') || lowerStatus.contains('débil')) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  Widget _buildWorkforceSection() {
    final population = populationDetails!.population;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Fuerza Laboral y Migración'),
        
        // Distribución de la fuerza laboral
        if (population.workforceDistribution.isNotEmpty) ...[
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
                        'Distribución de la Fuerza Laboral',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 16),
                  
                  ...population.workforceDistribution.map((sector) => 
                    _buildWorkforceSector(sector),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
        ],
        
        // Migración y clases sociales
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Migración
                Row(
                  children: [
                    const Icon(Icons.flight),
                    const SizedBox(width: 8),
                    const Text(
                      'Migración',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 16),
                
                _buildInfoRow('Inmigración', population.migration.immigrationRate),
                _buildInfoRow('Emigración', population.migration.emigrationRate),
                _buildInfoRow('Orígenes/Destinos Principales', population.migration.mainOriginsDestinations),
                
                const Divider(height: 24),
                
                // Clases sociales
                Row(
                  children: [
                    const Icon(Icons.social_distance),
                    const SizedBox(width: 8),
                    const Text(
                      'Clases Sociales',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(population.socialClasses),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkforceSector(WorkforceSector sector) {
    final percentage = double.tryParse(sector.percentage.replaceAll('%', '')) ?? 0;
    final sectorColor = _getSectorColor(sector.sector);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                sector.sector,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              sector.percentage,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(sectorColor),
          minHeight: 8,
        ),
        const SizedBox(height: 4),
        if (sector.dominantProfessions.isNotEmpty) ...[
          const SizedBox(height: 4), // Reducido de 8 a 4
          Wrap(
            spacing: 4, // Reducido de 6 a 4
            runSpacing: 4, // Reducido de 6 a 4
            children: sector.dominantProfessions.map((profession) => 
              Card(
                elevation: 0,
                margin: const EdgeInsets.only(right: 2, bottom: 2), // Añadido margen más pequeño
                color: sectorColor.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Reducido de 12 a 8
                  side: BorderSide(color: sectorColor.withOpacity(0.3), width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3), // Reducido de 8,4 a 6,3
                  child: Text(
                    profession,
                    style: TextStyle(
                      fontSize: 11, // Reducido de 12 a 11
                      fontWeight: FontWeight.w500, // Añadido para mejor legibilidad
                      color: sectorColor.withOpacity(0.9), // Aumentado de 0.8 a 0.9 para mejor contraste
                    ),
                  ),
                ),
              ),
            ).toList(),
          ),
        ],
        const SizedBox(height: 10), // Reducido de 16 a 10
      ],
    );
  }

  Color _getSectorColor(String sectorName) {
    final name = sectorName.toLowerCase();
    if (name.contains('primario')) {
      return Colors.green;
    } else if (name.contains('secundario')) {
      return Colors.blue;
    } else if (name.contains('terciario')) {
      return Colors.orange;
    } else if (name.contains('cuaternario')) {
      return Colors.purple;
    } else {
      return Colors.grey;
    }
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