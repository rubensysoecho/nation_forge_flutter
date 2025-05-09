abstract class NationEvent {}

class LoadNations extends NationEvent {}

class LoadNationSketches extends NationEvent {}

class LoadNationDetails extends NationEvent {
  final String nationId;
  LoadNationDetails(this.nationId);
}

class CreateRandomNation extends NationEvent {
  CreateRandomNation();
}

class CreateNation extends NationEvent {
  final String nationName;
  final String governmentType;
  final String age;
  CreateNation(this.nationName, this.governmentType, this.age);
}

class CreateNationAdvanced extends NationEvent {
  final String nationName;
  final String governmentType;
  final String age;
  String? leaderName;
  double? politicalStability;
  String? economicSystem;
  String? currencyName;
  double? wealthDistribution;
  String? lifeExpectancy;
  double? populationGrowth;
  String? other;
  CreateNationAdvanced(
    this.nationName,
    this.governmentType,
    this.age,
    this.leaderName,
    this.politicalStability,
    this.economicSystem,
    this.currencyName,
    this.wealthDistribution,
    this.lifeExpectancy,
    this.populationGrowth,
    this.other,
  );
}

class AddEvent extends NationEvent {
  final String type;
  final String event;
  AddEvent(this.type, this.event);
}

class DeleteNation extends NationEvent {
  final String nationId;
  DeleteNation(this.nationId);
}
