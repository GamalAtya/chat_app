part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class IsLoggedInEvent extends AuthEvent{
  const IsLoggedInEvent();
  @override
  List<Object?> get props => [];
}

class SignUpEvent extends AuthEvent{
  final User user ;

  const SignUpEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class SignInEvent extends AuthEvent{
  final User user ;

  const SignInEvent({required this.user});

  @override
  List<Object?> get props => [user];
}
