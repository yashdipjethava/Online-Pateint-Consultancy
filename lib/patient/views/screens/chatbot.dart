import 'package:aarogyam/patient/data/models/bot_message_model.dart';
import 'package:aarogyam/patient/logic/bloc/chatBot/chat_bot_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  TextEditingController textEditingController = TextEditingController();
  late final chatBotBloc;

  @override
  void initState() {
    super.initState();
    chatBotBloc = ChatBotBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showMessageBox(context);
    });
  }

  Future<void> _showMessageBox(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // Dialog is not dismissible with outside touch
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Welcome to our healthcare assistant! 🏥 I\'m here to help you with any health-related questions or concerns you may have. Whether it\'s about symptoms, medication, appointments, or general wellness advice, feel free to ask me anything. Your health and well-being are my top priorities! Let\'s get started by typing your question',
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome to the health assistant app!'),
                Text('How can I assist you today?'),
              ],
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'ok',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.teal,
        title: const Text(
          'Your Digital Assistant',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<ChatBotBloc, ChatBotState>(
        bloc: chatBotBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatMessageModel> messages =
                  (state as ChatSuccessState).messages;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        if (messages[index].role == 'user') {
                          return Align(
                            alignment: FractionalOffset.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 60, bottom: 20, right: 10),
                              child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.teal.shade300
                                          .withOpacity(0.2)),
                                  child: Text(
                                    messages[index].parts.first.text,
                                    style: const TextStyle(color: Colors.black),
                                    textAlign: TextAlign.right,
                                  )),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 60, bottom: 20, left: 10),
                            child: Align(
                              alignment: FractionalOffset.centerLeft,
                              child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.teal.shade300
                                          .withOpacity(0.2)),
                                  child: Text(
                                    messages[index].parts.first.text,
                                    style:
                                        const TextStyle(color: Colors.black),
                                  )),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  if (chatBotBloc.isGenerating)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                            height: 50,
                            width: 50,
                            child: Lottie.asset(
                                'assets/animation/chat_loader.json')),
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 16),
                    child: SizedBox(
                      height: 90,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textEditingController,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              cursorColor: Colors.teal,
                              decoration: InputDecoration(
                                  hintText: 'Ask your Question to HealthAI',
                                  hintStyle:
                                      const TextStyle(color: Colors.black38),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.teal),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          InkWell(
                            onTap: () {
                              if (textEditingController.text.isNotEmpty) {
                                final text = textEditingController.text;
                                textEditingController.clear();
                                chatBotBloc.add(
                                    ChatGenerateNewTextMessageEvent(
                                        inputMessage: text));
                              }
                            },
                            child: CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                radius: 31,
                                backgroundColor: Colors.teal.shade400,
                                child: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            default:
              return const SizedBox(
                child: Center(
                  child: Text('something went wrong...!'),
                ),
              );
          }
        },
      ),
    );
  }
}
