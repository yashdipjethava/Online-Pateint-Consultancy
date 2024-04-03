part of 'chat_bot_bloc.dart';

abstract class ChatBotEvent{
  const ChatBotEvent();
}

class ChatGenerateNewTextMessageEvent extends ChatBotEvent {
  final String inputMessage;

  ChatGenerateNewTextMessageEvent({required this.inputMessage});
}
