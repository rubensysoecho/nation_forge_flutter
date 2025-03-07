part of 'war_bloc.dart';

@immutable
sealed class WarState {}

final class WarInitial extends WarState {}

final class WarLoading extends WarState {}

final class WarLoaded extends WarState {
  final List<War> wars;
  WarLoaded(this.wars);
}

final class WarError extends WarState {
  final String msg;
  WarError(this.msg);
}
