class PoliticsDetails {
  final String id;
  final ExteriorPolitics exterior;
  final InteriorPolitics interior;

  PoliticsDetails({
    required this.id,
    required this.exterior,
    required this.interior,
  });

  factory PoliticsDetails.fromJson(Map<String, dynamic> json) {
    return PoliticsDetails(
      id: json['_id'],
      exterior: ExteriorPolitics.fromJson(json['exterior']),
      interior: InteriorPolitics.fromJson(json['interior']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'exterior': exterior.toJson(),
      'interior': interior.toJson(),
    };
  }
}

class ExteriorPolitics {
  final Geopolitics geopolitics;
  final List<Influence> influences;

  ExteriorPolitics({
    required this.geopolitics,
    required this.influences,
  });

  factory ExteriorPolitics.fromJson(Map<String, dynamic> json) {
    return ExteriorPolitics(
      geopolitics: Geopolitics.fromJson(json['geopolitics']),
      influences: (json['influences'] as List)
          .map((influence) => Influence.fromJson(influence))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'geopolitics': geopolitics.toJson(),
      'influences': influences.map((influence) => influence.toJson()).toList(),
    };
  }
}

class Geopolitics {
  final List<War> wars;
  final List<Alliance> alliances;

  Geopolitics({
    required this.wars,
    required this.alliances,
  });

  factory Geopolitics.fromJson(Map<String, dynamic> json) {
    return Geopolitics(
      wars: (json['wars'] as List)
          .map((war) => War.fromJson(war))
          .toList(),
      alliances: (json['alliances'] as List)
          .map((alliance) => Alliance.fromJson(alliance))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wars': wars.map((war) => war.toJson()).toList(),
      'alliances': alliances.map((alliance) => alliance.toJson()).toList(),
    };
  }
}

class War {
  final String id;
  final String nation;
  final String date;
  final String reason;
  final String outcome;

  War({
    required this.id,
    required this.nation,
    required this.date,
    required this.reason,
    required this.outcome,
  });

  factory War.fromJson(Map<String, dynamic> json) {
    return War(
      id: json['_id'],
      nation: json['nation'],
      date: json['date'],
      reason: json['reason'],
      outcome: json['outcome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nation': nation,
      'date': date,
      'reason': reason,
      'outcome': outcome,
    };
  }
}

class Alliance {
  final String id;
  final String nation;
  final String date;
  final String purpose;

  Alliance({
    required this.id,
    required this.nation,
    required this.date,
    required this.purpose,
  });

  factory Alliance.fromJson(Map<String, dynamic> json) {
    return Alliance(
      id: json['_id'],
      nation: json['nation'],
      date: json['date'],
      purpose: json['purpose'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nation': nation,
      'date': date,
      'purpose': purpose,
    };
  }
}

class Influence {
  final String id;
  final String nation;
  final String type;
  final String strength;

  Influence({
    required this.id,
    required this.nation,
    required this.type,
    required this.strength,
  });

  factory Influence.fromJson(Map<String, dynamic> json) {
    return Influence(
      id: json['_id'],
      nation: json['nation'],
      type: json['type'],
      strength: json['strength'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nation': nation,
      'type': type,
      'strength': strength,
    };
  }
}

class InteriorPolitics {
  final String governmentType;
  final Leader leader;
  final LegislativeBranch legislativeBranch;
  final JudicialBranch judicialBranch;
  final String politicalStability;
  final String politicalIdeology;
  final List<dynamic> separatism; // Puede estar vacío
  final Tensions tensions;

  InteriorPolitics({
    required this.governmentType,
    required this.leader,
    required this.legislativeBranch,
    required this.judicialBranch,
    required this.politicalStability,
    required this.politicalIdeology,
    required this.separatism,
    required this.tensions,
  });

  factory InteriorPolitics.fromJson(Map<String, dynamic> json) {
    return InteriorPolitics(
      governmentType: json['governmentType'],
      leader: Leader.fromJson(json['leader']),
      legislativeBranch: LegislativeBranch.fromJson(json['legislativeBranch']),
      judicialBranch: JudicialBranch.fromJson(json['judicialBranch']),
      politicalStability: json['politicalStability'],
      politicalIdeology: json['politicalIdeology'],
      separatism: json['separatism'] ?? [],
      tensions: Tensions.fromJson(json['tensions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'governmentType': governmentType,
      'leader': leader.toJson(),
      'legislativeBranch': legislativeBranch.toJson(),
      'judicialBranch': judicialBranch.toJson(),
      'politicalStability': politicalStability,
      'politicalIdeology': politicalIdeology,
      'separatism': separatism,
      'tensions': tensions.toJson(),
    };
  }
}

class Leader {
  final String id;
  final String name;
  final String title;
  final String rulingParty;
  final String succession;

  Leader({
    required this.id,
    required this.name,
    required this.title,
    required this.rulingParty,
    required this.succession,
  });

  factory Leader.fromJson(Map<String, dynamic> json) {
    return Leader(
      id: json['_id'],
      name: json['name'],
      title: json['title'],
      rulingParty: json['rulingParty'],
      succession: json['succession'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'title': title,
      'rulingParty': rulingParty,
      'succession': succession,
    };
  }
}

class LegislativeBranch {
  final String id;
  final String name;
  final String structure;
  final String powers;

  LegislativeBranch({
    required this.id,
    required this.name,
    required this.structure,
    required this.powers,
  });

  factory LegislativeBranch.fromJson(Map<String, dynamic> json) {
    return LegislativeBranch(
      id: json['_id'],
      name: json['name'],
      structure: json['structure'],
      powers: json['powers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'structure': structure,
      'powers': powers,
    };
  }
}

class JudicialBranch {
  final String id;
  final String name;
  final String structure;
  final String powers;

  JudicialBranch({
    required this.id,
    required this.name,
    required this.structure,
    required this.powers,
  });

  factory JudicialBranch.fromJson(Map<String, dynamic> json) {
    return JudicialBranch(
      id: json['_id'],
      name: json['name'],
      structure: json['structure'],
      powers: json['powers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'structure': structure,
      'powers': powers,
    };
  }
}

class Tensions {
  final List<TensionGroup> cultural;
  final List<dynamic> religious; // Puede estar vacío
  final List<PoliticalTension> political;

  Tensions({
    required this.cultural,
    required this.religious,
    required this.political,
  });

  factory Tensions.fromJson(Map<String, dynamic> json) {
    return Tensions(
      cultural: (json['cultural'] as List)
          .map((tension) => TensionGroup.fromJson(tension))
          .toList(),
      religious: json['religious'] ?? [],
      political: (json['political'] as List)
          .map((tension) => PoliticalTension.fromJson(tension))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cultural': cultural.map((tension) => tension.toJson()).toList(),
      'religious': religious,
      'political': political.map((tension) => tension.toJson()).toList(),
    };
  }
}

class TensionGroup {
  final String id;
  final String group;
  final String issue;
  final String severity;

  TensionGroup({
    required this.id,
    required this.group,
    required this.issue,
    required this.severity,
  });

  factory TensionGroup.fromJson(Map<String, dynamic> json) {
    return TensionGroup(
      id: json['_id'],
      group: json['group'],
      issue: json['issue'],
      severity: json['severity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'group': group,
      'issue': issue,
      'severity': severity,
    };
  }
}

class PoliticalTension {
  final String id;
  final String party;
  final String issue;
  final String severity;

  PoliticalTension({
    required this.id,
    required this.party,
    required this.issue,
    required this.severity,
  });

  factory PoliticalTension.fromJson(Map<String, dynamic> json) {
    return PoliticalTension(
      id: json['_id'],
      party: json['party'],
      issue: json['issue'],
      severity: json['severity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'party': party,
      'issue': issue,
      'severity': severity,
    };
  }
}