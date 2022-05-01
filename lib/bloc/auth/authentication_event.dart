part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class Initialize extends AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class LogoutEvent extends AuthenticationEvent {}
