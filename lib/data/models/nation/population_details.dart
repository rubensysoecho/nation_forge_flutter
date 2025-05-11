class PopulationDetails {
  final String id;
  final Population population;

  PopulationDetails({
    required this.id,
    required this.population,
  });

  factory PopulationDetails.fromJson(Map<String, dynamic> json) {
    return PopulationDetails(
      id: json['_id'],
      population: Population.fromJson(json['population']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'population': population.toJson(),
    };
  }
}

class Population {
  final String id;
  final String totalPopulation;
  final String populationDensity;
  final UrbanRuralSplit urbanRuralSplit;
  final AgeDistribution ageDistribution;
  final List<EthnicGroup> ethnicGroups;
  final List<Language> languages;
  final List<Religion> religions;
  final String literacyRate;
  final String educationLevel;
  final LifeExpectancy lifeExpectancy;
  final Health health;
  final String populationGrowthRate;
  final Migration migration;
  final List<WorkforceSector> workforceDistribution;
  final String socialClasses;

  Population({
    required this.id,
    required this.totalPopulation,
    required this.populationDensity,
    required this.urbanRuralSplit,
    required this.ageDistribution,
    required this.ethnicGroups,
    required this.languages,
    required this.religions,
    required this.literacyRate,
    required this.educationLevel,
    required this.lifeExpectancy,
    required this.health,
    required this.populationGrowthRate,
    required this.migration,
    required this.workforceDistribution,
    required this.socialClasses,
  });

  factory Population.fromJson(Map<String, dynamic> json) {
    return Population(
      id: json['_id'],
      totalPopulation: json['totalPopulation'],
      populationDensity: json['populationDensity'],
      urbanRuralSplit: UrbanRuralSplit.fromJson(json['urbanRuralSplit']),
      ageDistribution: AgeDistribution.fromJson(json['ageDistribution']),
      ethnicGroups: (json['ethnicGroups'] as List)
          .map((group) => EthnicGroup.fromJson(group))
          .toList(),
      languages: (json['languages'] as List)
          .map((language) => Language.fromJson(language))
          .toList(),
      religions: (json['religions'] as List)
          .map((religion) => Religion.fromJson(religion))
          .toList(),
      literacyRate: json['literacyRate'],
      educationLevel: json['educationLevel'],
      lifeExpectancy: LifeExpectancy.fromJson(json['lifeExpectancy']),
      health: Health.fromJson(json['health']),
      populationGrowthRate: json['populationGrowthRate'],
      migration: Migration.fromJson(json['migration']),
      workforceDistribution: (json['workforceDistribution'] as List)
          .map((sector) => WorkforceSector.fromJson(sector))
          .toList(),
      socialClasses: json['socialClasses'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'totalPopulation': totalPopulation,
      'populationDensity': populationDensity,
      'urbanRuralSplit': urbanRuralSplit.toJson(),
      'ageDistribution': ageDistribution.toJson(),
      'ethnicGroups': ethnicGroups.map((group) => group.toJson()).toList(),
      'languages': languages.map((language) => language.toJson()).toList(),
      'religions': religions.map((religion) => religion.toJson()).toList(),
      'literacyRate': literacyRate,
      'educationLevel': educationLevel,
      'lifeExpectancy': lifeExpectancy.toJson(),
      'health': health.toJson(),
      'populationGrowthRate': populationGrowthRate,
      'migration': migration.toJson(),
      'workforceDistribution': workforceDistribution.map((sector) => sector.toJson()).toList(),
      'socialClasses': socialClasses,
    };
  }
}

class UrbanRuralSplit {
  final String id;
  final String urbanPercentage;
  final String ruralPercentage;
  final List<String> majorCities;

  UrbanRuralSplit({
    required this.id,
    required this.urbanPercentage,
    required this.ruralPercentage,
    required this.majorCities,
  });

  factory UrbanRuralSplit.fromJson(Map<String, dynamic> json) {
    return UrbanRuralSplit(
      id: json['_id'],
      urbanPercentage: json['urbanPercentage'],
      ruralPercentage: json['ruralPercentage'],
      majorCities: List<String>.from(json['majorCities']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'urbanPercentage': urbanPercentage,
      'ruralPercentage': ruralPercentage,
      'majorCities': majorCities,
    };
  }
}

class AgeDistribution {
  final String id;
  final String medianAge;
  final List<AgeBracket> ageBrackets;
  final String dependencyRatio;

  AgeDistribution({
    required this.id,
    required this.medianAge,
    required this.ageBrackets,
    required this.dependencyRatio,
  });

  factory AgeDistribution.fromJson(Map<String, dynamic> json) {
    return AgeDistribution(
      id: json['_id'],
      medianAge: json['medianAge'],
      ageBrackets: (json['ageBrackets'] as List)
          .map((bracket) => AgeBracket.fromJson(bracket))
          .toList(),
      dependencyRatio: json['dependencyRatio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'medianAge': medianAge,
      'ageBrackets': ageBrackets.map((bracket) => bracket.toJson()).toList(),
      'dependencyRatio': dependencyRatio,
    };
  }
}

class AgeBracket {
  final String id;
  final String bracket;
  final String percentage;

  AgeBracket({
    required this.id,
    required this.bracket,
    required this.percentage,
  });

  factory AgeBracket.fromJson(Map<String, dynamic> json) {
    return AgeBracket(
      id: json['_id'],
      bracket: json['bracket'],
      percentage: json['percentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'bracket': bracket,
      'percentage': percentage,
    };
  }
}

class EthnicGroup {
  final String id;
  final String groupName;
  final String percentage;
  final String notes;

  EthnicGroup({
    required this.id,
    required this.groupName,
    required this.percentage,
    required this.notes,
  });

  factory EthnicGroup.fromJson(Map<String, dynamic> json) {
    return EthnicGroup(
      id: json['_id'],
      groupName: json['groupName'],
      percentage: json['percentage'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'groupName': groupName,
      'percentage': percentage,
      'notes': notes,
    };
  }
}

class Language {
  final String id;
  final String languageName;
  final String status;
  final String percentageSpeakers;

  Language({
    required this.id,
    required this.languageName,
    required this.status,
    required this.percentageSpeakers,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['_id'],
      languageName: json['languageName'],
      status: json['status'],
      percentageSpeakers: json['percentageSpeakers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'languageName': languageName,
      'status': status,
      'percentageSpeakers': percentageSpeakers,
    };
  }
}

class Religion {
  final String id;
  final String religionName;
  final String influence;
  final String percentageAdherents;

  Religion({
    required this.id,
    required this.religionName,
    required this.percentageAdherents,
    required this.influence,
  });

  factory Religion.fromJson(Map<String, dynamic> json) {
    return Religion(
      id: json['_id'],
      religionName: json['religionName'],
      percentageAdherents: json['percentageAdherents'],
      influence: json['influence'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'religionName': religionName,
      'percentageAdherents': percentageAdherents,
      'influence': influence,
    };
  }
}

class LifeExpectancy {
  final String id;
  final String male;
  final String female;
  final String overall;

  LifeExpectancy({
    required this.id,
    required this.male,
    required this.female,
    required this.overall,
  });

  factory LifeExpectancy.fromJson(Map<String, dynamic> json) {
    return LifeExpectancy(
      id: json['_id'],
      male: json['male'],
      female: json['female'],
      overall: json['overall'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'male': male,
      'female': female,
      'overall': overall,
    };
  }
}

class Health {
  final String id;
  final String infantMortalityRate;
  final String accessToHealthcare;

  Health({
    required this.id,
    required this.infantMortalityRate,
    required this.accessToHealthcare,
  });

  factory Health.fromJson(Map<String, dynamic> json) {
    return Health(
      id: json['_id'],
      infantMortalityRate: json['infantMortalityRate'],
      accessToHealthcare: json['accessToHealthcare'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'infantMortalityRate': infantMortalityRate,
      'accessToHealthcare': accessToHealthcare,
    };
  }
}

class Migration {
  final String id;
  final String immigrationRate;
  final String emigrationRate;
  final String mainOriginsDestinations;

  Migration({
    required this.id,
    required this.immigrationRate,
    required this.emigrationRate,
    required this.mainOriginsDestinations,
  });

  factory Migration.fromJson(Map<String, dynamic> json) {
    return Migration(
      id: json['_id'],
      immigrationRate: json['immigrationRate'],
      emigrationRate: json['emigrationRate'],
      mainOriginsDestinations: json['mainOriginsDestinations'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'immigrationRate': immigrationRate,
      'emigrationRate': emigrationRate,
      'mainOriginsDestinations': mainOriginsDestinations,
    };
  }
}

class WorkforceSector {
  final String id;
  final String sector;
  final String percentage;
  final List<String> dominantProfessions;

  WorkforceSector({
    required this.id,
    required this.sector,
    required this.percentage,
    required this.dominantProfessions,
  });

  factory WorkforceSector.fromJson(Map<String, dynamic> json) {
    return WorkforceSector(
      id: json['_id'],
      sector: json['sector'],
      percentage: json['percentage'],
      dominantProfessions: List<String>.from(json['dominantProfessions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'sector': sector,
      'percentage': percentage,
      'dominantProfessions': dominantProfessions,
    };
  }
}