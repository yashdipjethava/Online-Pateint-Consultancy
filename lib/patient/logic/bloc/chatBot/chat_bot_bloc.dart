import 'dart:async';

import 'package:aarogyam/patient/data/models/bot_message_model.dart';
import 'package:aarogyam/patient/data/repository/chat_bot_repo.dart';
import 'package:bloc/bloc.dart';

part 'chat_bot_event.dart';

part 'chat_bot_state.dart';

class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  ChatBotBloc() : super(ChatSuccessState(messages: [])) {
    on<ChatBotEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent);
  }

  List<ChatMessageModel> messages = [];

  bool isGenerating = false;

  Future<FutureOr<void>> chatGenerateNewTextMessageEvent(
      ChatGenerateNewTextMessageEvent event, Emitter<ChatBotState> emit) async {
    messages.add(ChatMessageModel(
        role: "user", parts: [ChatPartModel(text: event.inputMessage)]));
    emit(ChatSuccessState(messages: messages));
    isGenerating = true;
    String generatedText = await ChatBotRepo.chatTextGenerationRepo(messages);
    if (generatedText.isNotEmpty) {
      messages.add(ChatMessageModel(
          role: 'model', parts: [ChatPartModel(text: generatedText)]));
      emit(ChatSuccessState(messages: messages));
    }
    isGenerating = false;
  }
}
