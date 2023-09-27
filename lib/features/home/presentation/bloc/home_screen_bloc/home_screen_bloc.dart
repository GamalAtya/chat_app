import 'package:chat_app/features/home/domain/entities/chat.dart';
import 'package:chat_app/features/home/presentation/bloc/conversations_bloc/conversations_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../auth/domain/entities/user.dart';
import '../../../domain/use_cases/LogOut_user_useCase.dart';
import '../../../domain/use_cases/get_user_chats_useCase.dart';
import '../../../domain/use_cases/get_users_data_use_case.dart';
import '../../../domain/use_cases/seach_users_by_email_use_case.dart';

part 'home_screen_event.dart';

part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final SearchUsersByEmailUseCase searchUsersByEmailUseCase;

  final GetUserDataUseCase getUserDataUseCase;

  final LogOutUserUseCase logOutUserUseCase;

  final controller = TextEditingController();
  late User? user;

  HomeScreenBloc(
      {required this.searchUsersByEmailUseCase,
      required this.getUserDataUseCase,
      required this.logOutUserUseCase})
      : super(const HomeScreenInitial(tabIndex: 1)) {
    on<HomeScreenEvent>((event, emit) async {
      if (event is GetUserDataEvent) {
        final userOrFail = await getUserDataUseCase();
        userOrFail.fold((l) {}, (r) => {user = r});
        await FirebaseMessaging.instance.subscribeToTopic(user!.uid!);
      }
      if (event is ChangeHomeTabEvent) {
        emit(HomeScreenInitial(tabIndex: event.tabIndex));
      }
      if (event is SearchUserByEmailEvent) {
        emit(const HomeScreenLoading());
        final user = await searchUsersByEmailUseCase(event.email);
        emit(user.fold((l) => const HomeScreenInitial(tabIndex: 0),
            (user) => SearchUserByEmailState(user: user)));
      }

      if (event is LogOutEvent) {
        final logoutOrFail = await logOutUserUseCase();
        logoutOrFail.fold((l) => null, (r) => emit(const LogOutState()));
      }
    });
  }
}
