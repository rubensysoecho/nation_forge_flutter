
import '../../../../data/models/nation/nation.dart';
import '../../../../data/models/nation/nation_sketch.dart';

abstract class NationState {}

class NationInitial extends NationState {}

class NationLoading extends NationState {}

class NationDetailsLoaded extends NationState {
  final Nation nation;
  NationDetailsLoaded(this.nation);
}

class NationSketchesLoaded extends NationState {
  final List<NationSketch> nations;
  NationSketchesLoaded(this.nations);
}

class NationLoaded extends NationState {
  final List<Nation> nations;
  NationLoaded(this.nations);
}

class NationCreated extends NationState {
  final Nation newNation;
  NationCreated(this.newNation);
}

class NationError extends NationState {
  final String message;
  NationError(this.message);
}