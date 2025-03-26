import 'package:nation_forge/models/event.dart';

class Nation {
  final String id;
  final String nationName;
  final String historicalContext;
  final String geopoliticalContext;
  final String politics;
  final String population;
  final List<String> historicalCuriosities;
  final List<String> importantCharacters;
  final List<Event> events;

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
    required this.events,
    required this.createdAt,
  });

  factory Nation.fromJson(Map<String, dynamic> json) {
    return Nation(
      id: json['_id'],
      nationName: json['name'],
      historicalContext: json['historicalContext'],
      geopoliticalContext: json['geopoliticalContext'],
      politics: json['politics'],
      population: json['population'],
      historicalCuriosities: List<String>.from(json['historicalCuriosities']),
      importantCharacters: List<String>.from(json['importantCharacters']),
      events: (json['events'] as List)
          .map((eventJson) => Event.fromJson(eventJson))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nationName': nationName,
      'historicalContext': historicalContext,
      'geopoliticalContext': geopoliticalContext,
      'politics': politics,
      'population': population,
      'historicalCuriosities': historicalCuriosities,
      'importantCharacters': importantCharacters,
      // 'events': events, // Comentado porque no se está utilizando por ahora.
      'created_at': createdAt.toIso8601String(),
    };
  }
}