part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccesful extends AuthState {
  final String token;
  AuthSuccesful(this.token);
}

final class AuthRejected extends AuthState {
  final String msg;
  AuthRejected(this.msg);
}
