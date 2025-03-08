
abstract class NationEvent {}

class LoadNations extends NationEvent {}

class CreateNation extends NationEvent {
  final String nationName;
  final String governmentType;
  final String age;
  CreateNation(this.nationName, this.governmentType, this.age);
}