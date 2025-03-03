class Nation {
  final String id;
  final String nationName;
  final String historicalContext;
  final String geopoliticalContext;
  final String politics;
  final String population;
  final List<String> historicalCuriosities;
  final List<String> importantCharacters;
  final DateTime createdAt;

  Nation({
    required this.id,
    required this.nationName,
    required this.historicalContext,
    required this.geopoliticalContext,
    required this.politics,
    required this.population,
    required this.historicalCuriosities,
    required this.importantCharacters,
    required this.createdAt,
  });

  factory Nation.fromJson(Map<String, dynamic> json) {
    return Nation(
      id: json['_id'],
      nationName: json['nation_name'],
      historicalContext: json['historical_context'],
      geopoliticalContext: json['geopolitical_context'],
      politics: json['politics'],
      population: json['population'],
      historicalCuriosities: List<String>.from(json['historical_curiosities']),
      importantCharacters: List<String>.from(json['important_characters']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nation_name': nationName,
      'historical_context': historicalContext,
      'geopolitical_context': geopoliticalContext,
      'politics': politics,
      'population': population,
      'historical_curiosities': historicalCuriosities,
      'important_characters': importantCharacters,
      'created_at': createdAt.toIso8601String(),
    };
  }
}