part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthLoginGoogle extends AuthEvent {
  AuthLoginGoogle();
}

class AuthLoginMailEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginMailEvent({required this.email, required this.password});
}
