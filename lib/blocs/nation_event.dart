
abstract class NationEvent {}

class LoadNations extends NationEvent {}

class CreateNation extends NationEvent {
  final String nationName;
  final String governmentType;
  final String age;
  CreateNation(this.nationName, this.governmentType, this.age);
}

class AddEvent extends NationEvent  {
  final String type;
  final String event;
  AddEvent(this.type, this.event);
}