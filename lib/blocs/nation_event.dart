import '../models/nation.dart';

abstract class NationEvent {}

class LoadNations extends NationEvent {}

class CreateNation extends NationEvent {
  final Nation nation;
  CreateNation(this.nation);
}