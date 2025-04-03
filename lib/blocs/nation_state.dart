import '../models/nation/nation.dart';

abstract class NationState {}

class NationInitial extends NationState {}

class NationLoading extends NationState {}

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