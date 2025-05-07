import 'package:nation_forge/data/models/nation/event.dart';
import 'package:nation_forge/data/models/nation/politics_details.dart';
import 'package:nation_forge/data/models/nation/economy_details.dart';
import 'package:nation_forge/data/models/nation/population_details.dart';

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
  
  // Nuevos campos detallados
  final PoliticsDetails? politicsDetails;
  final EconomyDetails? economyDetails;
  final PopulationDetails? populationDetails;

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
    this.politicsDetails,
    this.economyDetails,
    this.populationDetails,
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
      politicsDetails: json['politicsDetails'] != null
          ? PoliticsDetails.fromJson(json['politicsDetails'])
          : null,
      economyDetails: json['economyDetails'] != null
          ? EconomyDetails.fromJson(json['economyDetails'])
          : null,
      populationDetails: json['populationDetails'] != null
          ? PopulationDetails.fromJson(json['populationDetails'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
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

    if (politicsDetails != null) {
      data['politicsDetails'] = politicsDetails!.toJson();
    }
    
    if (economyDetails != null) {
      data['economyDetails'] = economyDetails!.toJson();
    }
    
    if (populationDetails != null) {
      data['populationDetails'] = populationDetails!.toJson();
    }

    return data;
  }
}