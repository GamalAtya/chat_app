import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../auth/domain/entities/user.dart';
import '../../../domain/entities/chat.dart';
import '../../../domain/use_cases/get_user_chats_useCase.dart';
import '../../../domain/use_cases/get_users_data_use_case.dart';

part 'conversations_event.dart';
part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  final GetUserDataUseCase getUserDataUseCase ;
  final GetUserChatUseCase getUserChatUseCase ;
  late User? user ;
  ConversationsBloc({required this.getUserChatUseCase , required this.getUserDataUseCase}) : super(ConversationsInitial()) {
    on<ConversationsEvent>((event, emit) async{
      if(event is GetUserChatsEvent){
        emit(ConversationsLoading());
        final userOrFail = await getUserDataUseCase();
        userOrFail.fold((l){}, (r) => {user = r});
        final streamDocs = await getUserChatUseCase(user!);
        streamDocs.fold((l) => emit(ConversationsInitial()), (r) => emit(ConversationsLoaded(chats: r)));
      }
    });
  }
}
