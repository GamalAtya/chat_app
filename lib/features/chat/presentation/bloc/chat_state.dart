part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class LoadingChatMessages extends ChatState {
  @override
  List<Object> get props => [];
}


class LoadedChatMessages extends ChatState{
  final Stream<Chat> chat ;
  const LoadedChatMessages({required this.chat});
  @override
  List<Object?> get props => [chat];
}
