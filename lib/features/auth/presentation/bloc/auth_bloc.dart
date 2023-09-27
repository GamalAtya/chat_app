import 'package:bloc/bloc.dart';
import 'package:chat_app/core/strings/app_strings.dart';
import 'package:chat_app/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/isLoggedIn_user_usecase.dart';
import '../../domain/usecases/signIn_user_usecase.dart';
import '../../domain/usecases/signUp_user_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUserUseCase signUpUserUseCase ;
  final SignInUserUseCase signInUserUseCase ;
  final IsLoggedInUserUseCase isLoggedInUserUseCase ;
  AuthBloc({required this.signUpUserUseCase ,required this.signInUserUseCase , required this.isLoggedInUserUseCase}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async{
      if(event is IsLoggedInEvent){
        emit(const AuthLoading());
        final response = await isLoggedInUserUseCase();
        response.fold(
                (l) => emit(AuthInitial()),
                (r) => emit(const AuthSuccess()));
      }
      if(event is SignUpEvent){
        emit(const AuthLoading());
        final response = await signUpUserUseCase(event.user);
        emit(_eitherDoneMessageOrErrorState(response));
      }
      if(event is SignInEvent){
        emit(const AuthLoading());
        final response = await signInUserUseCase(event.user);
        emit(_eitherDoneMessageOrErrorState(response));
      }
    });
  }


  AuthState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either) {
    return either.fold(
          (failure) => AuthError(msg: _mapFailureToMessage(failure),),
            (_) => const AuthSuccess());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return AppStrings.OFFLINE_FAILURE_MESSAGE;
        case NotFoundFailure:
        return AppStrings.NOT_FOUND_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
