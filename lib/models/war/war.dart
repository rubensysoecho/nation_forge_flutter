class War {
  final String name;
  final AggressorCountry aggressorCountry;
  final DefenderCountry defenderCountry;
  final List<WarProgress> warProgress;
  final String soldierView;
  final List<String> kia;
  final String results;
  final String winner;

  War({
    required this.name,
    required this.aggressorCountry,
    required this.defenderCountry,
    required this.warProgress,
    required this.soldierView,
    required this.kia,
    required this.results,
    required this.winner,
  });

  factory War.fromJson(Map<String, dynamic> json) {
    return War(
      name: json['name'],
      aggressorCountry: AggressorCountry.fromJson(json['aggressorCountry']),
      defenderCountry: DefenderCountry.fromJson(json['defenderCountry']),
      warProgress: (json['warProgress'] as List)
          .map((e) => WarProgress.fromJson(e))
          .toList(),
      soldierView: json['soldierView'],
      kia: List<String>.from(json['kia']),
      results: json['results'],
      winner: json['winner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'aggressorCountry': aggressorCountry.toJson(),
      'defenderCountry': defenderCountry.toJson(),
      'warProgress': warProgress.map((e) => e.toJson()).toList(),
      'soldierView': soldierView,
      'kia': kia,
      'results': results,
      'winner': winner,
    };
  }
}

class AggressorCountry {
  final String name;
  final String troops;
  final List<String> advantages;
  final List<String> disadvantages;
  final List<String> equipment;
  final String casusBelli;

  AggressorCountry({
    required this.name,
    required this.troops,
    required this.advantages,
    required this.disadvantages,
    required this.equipment,
    required this.casusBelli,
  });

  factory AggressorCountry.fromJson(Map<String, dynamic> json) {
    return AggressorCountry(
      name: json['name'],
      troops: json['troops'],
      advantages: List<String>.from(json['advantages']),
      disadvantages: List<String>.from(json['disadvantages']),
      equipment: List<String>.from(json['equipment']),
      casusBelli: json['casusBelli'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'troops': troops,
      'advantages': advantages,
      'disadvantages': disadvantages,
      'equipment': equipment,
      'casusBelli': casusBelli,
    };
  }
}

class DefenderCountry {
  final String name;
  final String troops;
  final List<String> advantages;
  final List<String> disadvantages;
  final List<String> equipment;

  DefenderCountry({
    required this.name,
    required this.troops,
    required this.advantages,
    required this.disadvantages,
    required this.equipment,
  });

  factory DefenderCountry.fromJson(Map<String, dynamic> json) {
    return DefenderCountry(
      name: json['name'],
      troops: json['troops'],
      advantages: List<String>.from(json['advantages']),
      disadvantages: List<String>.from(json['disadvantages']),
      equipment: List<String>.from(json['equipment']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'troops': troops,
      'advantages': advantages,
      'disadvantages': disadvantages,
      'equipment': equipment,
    };
  }
}

class WarProgress {
  final String day;
  final List<String> events;

  WarProgress({
    required this.day,
    required this.events,
  });

  factory WarProgress.fromJson(Map<String, dynamic> json) {
    return WarProgress(
      day: json['day'],
      events: List<String>.from(json['events']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'events': events,
    };
  }
}