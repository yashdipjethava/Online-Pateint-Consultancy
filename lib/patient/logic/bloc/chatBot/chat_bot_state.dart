part of 'chat_bot_bloc.dart';

abstract class ChatBotState {
  const ChatBotState();
}

class ChatBotInitial extends ChatBotState {}

class ChatSuccessState extends ChatBotState {
  final List<ChatMessageModel> messages;

  ChatSuccessState({required this.messages});
}
