part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {

  const AuthLoading();
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  final String msg ;

  const AuthError({required this.msg});
  @override
  List<Object?> get props => [msg];
}

class AuthSuccess extends AuthState {

  const AuthSuccess();
  @override
  List<Object?> get props => [];
}
