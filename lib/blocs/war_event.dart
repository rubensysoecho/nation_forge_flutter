part of 'war_bloc.dart';

@immutable
sealed class WarEvent {}

class LoadWars extends WarEvent {}

class CreateWar extends WarEvent {
  final String nationA;
  final String nationB;
  final String casusBelli;
  final String age;
  CreateWar(this.nationA, this.nationB, this.casusBelli, this.age);
}
