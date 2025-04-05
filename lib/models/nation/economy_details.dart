class EconomyDetails {
  final String id;
  final String economicSystem;
  final List<KeySector> keySectors;
  final Currency currency;
  final List<NaturalResource> naturalResources;
  final EconomicLaw economicLaw;
  final TradePolicy tradePolicy;
  final Infrastructure infrastructure;
  final LaborForce laborForce;
  final String wealthDistribution;
  final String economicStability;
  final String inflationRate;

  EconomyDetails({
    required this.id,
    required this.economicSystem,
    required this.keySectors,
    required this.currency,
    required this.naturalResources,
    required this.economicLaw,
    required this.tradePolicy,
    required this.infrastructure,
    required this.laborForce,
    required this.wealthDistribution,
    required this.economicStability,
    required this.inflationRate,
  });

  factory EconomyDetails.fromJson(Map<String, dynamic> json) {
    return EconomyDetails(
      id: json['_id'],
      economicSystem: json['economicSystem'],
      keySectors: (json['keySectors'] as List)
          .map((sector) => KeySector.fromJson(sector))
          .toList(),
      currency: Currency.fromJson(json['currency']),
      naturalResources: (json['naturalResources'] as List)
          .map((resource) => NaturalResource.fromJson(resource))
          .toList(),
      economicLaw: EconomicLaw.fromJson(json['economicLaw']),
      tradePolicy: TradePolicy.fromJson(json['tradePolicy']),
      infrastructure: Infrastructure.fromJson(json['infrastructure']),
      laborForce: LaborForce.fromJson(json['laborForce']),
      wealthDistribution: json['wealthDistribution'],
      economicStability: json['economicStability'],
      inflationRate: json['inflationRate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'economicSystem': economicSystem,
      'keySectors': keySectors.map((sector) => sector.toJson()).toList(),
      'currency': currency.toJson(),
      'naturalResources': naturalResources.map((resource) => resource.toJson()).toList(),
      'economicLaw': economicLaw.toJson(),
      'tradePolicy': tradePolicy.toJson(),
      'infrastructure': infrastructure.toJson(),
      'laborForce': laborForce.toJson(),
      'wealthDistribution': wealthDistribution,
      'economicStability': economicStability,
      'inflationRate': inflationRate,
    };
  }
}

class KeySector {
  final String id;
  final String sectorName;
  final String importance;

  KeySector({
    required this.id,
    required this.sectorName,
    required this.importance,
  });

  factory KeySector.fromJson(Map<String, dynamic> json) {
    return KeySector(
      id: json['_id'],
      sectorName: json['sectorName'],
      importance: json['importance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'sectorName': sectorName,
      'importance': importance,
    };
  }
}

class Currency {
  final String id;
  final String currencyName;
  final String currencySymbol;
  final String stability;

  Currency({
    required this.id,
    required this.currencyName,
    required this.currencySymbol,
    required this.stability,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
        return Currency(
          id: json['_id'],
          currencyName: json['currencyName'],
          currencySymbol: json['currencySymbol'] ?? 'N/A',
          stability: json['stability'],
        );
      }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'currencyName': currencyName,
      'currencySymbol': currencySymbol,
      'stability': stability,
    };
  }
}

class NaturalResource {
  final String id;
  final String resourceName;
  final String abundance;

  NaturalResource({
    required this.id,
    required this.resourceName,
    required this.abundance,
  });

  factory NaturalResource.fromJson(Map<String, dynamic> json) {
    return NaturalResource(
      id: json['_id'],
      resourceName: json['resourceName'],
      abundance: json['abundance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'resourceName': resourceName,
      'abundance': abundance,
    };
  }
}

class EconomicLaw {
  final String id;
  final String propertyRights;
  final String contractLaw;
  final String taxSystem;
  final String regulationLevel;

  EconomicLaw({
    required this.id,
    required this.propertyRights,
    required this.contractLaw,
    required this.taxSystem,
    required this.regulationLevel,
  });

  factory EconomicLaw.fromJson(Map<String, dynamic> json) {
    return EconomicLaw(
      id: json['_id'],
      propertyRights: json['propertyRights'],
      contractLaw: json['contractLaw'],
      taxSystem: json['taxSystem'],
      regulationLevel: json['regulationLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'propertyRights': propertyRights,
      'contractLaw': contractLaw,
      'taxSystem': taxSystem,
      'regulationLevel': regulationLevel,
    };
  }
}

class TradePolicy {
  final String id;
  final String openness;
  final List<String> majorExports;
  final List<String> majorImports;
  final String tariffs;
  final List<TradeAgreement> tradeAgreements;

  TradePolicy({
    required this.id,
    required this.openness,
    required this.majorExports,
    required this.majorImports,
    required this.tariffs,
    required this.tradeAgreements,
  });

  factory TradePolicy.fromJson(Map<String, dynamic> json) {
    return TradePolicy(
      id: json['_id'],
      openness: json['openness'],
      majorExports: List<String>.from(json['majorExports']),
      majorImports: List<String>.from(json['majorImports']),
      tariffs: json['tariffs'],
      tradeAgreements: (json['tradeAgreements'] as List)
          .map((agreement) => TradeAgreement.fromJson(agreement))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'openness': openness,
      'majorExports': majorExports,
      'majorImports': majorImports,
      'tariffs': tariffs,
      'tradeAgreements': tradeAgreements.map((agreement) => agreement.toJson()).toList(),
    };
  }
}

class TradeAgreement {
  final String id;
  final String partnerNation;
  final String agreementType;

  TradeAgreement({
    required this.id,
    required this.partnerNation,
    required this.agreementType,
  });

  factory TradeAgreement.fromJson(Map<String, dynamic> json) {
    return TradeAgreement(
      id: json['_id'],
      partnerNation: json['partnerNation'],
      agreementType: json['agreementType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'partnerNation': partnerNation,
      'agreementType': agreementType,
    };
  }
}

class Infrastructure {
  final String id;
  final String transportation;
  final String energy;
  final String communication;

  Infrastructure({
    required this.id,
    required this.transportation,
    required this.energy,
    required this.communication,
  });

  factory Infrastructure.fromJson(Map<String, dynamic> json) {
    return Infrastructure(
      id: json['_id'],
      transportation: json['transportation'],
      energy: json['energy'],
      communication: json['communication'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'transportation': transportation,
      'energy': energy,
      'communication': communication,
    };
  }
}

class LaborForce {
  final String id;
  final String sizeEstimate;
  final String skillLevel;
  final String unemploymentRate;
  final List<String> dominantIndustries;

  LaborForce({
    required this.id,
    required this.sizeEstimate,
    required this.skillLevel,
    required this.unemploymentRate,
    required this.dominantIndustries,
  });

  factory LaborForce.fromJson(Map<String, dynamic> json) {
    return LaborForce(
      id: json['_id'],
      sizeEstimate: json['sizeEstimate'],
      skillLevel: json['skillLevel'],
      unemploymentRate: json['unemploymentRate'],
      dominantIndustries: List<String>.from(json['dominantIndustries']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'sizeEstimate': sizeEstimate,
      'skillLevel': skillLevel,
      'unemploymentRate': unemploymentRate,
      'dominantIndustries': dominantIndustries,
    };
  }
}