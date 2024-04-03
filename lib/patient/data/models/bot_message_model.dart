import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel {
  final String role;
  final List<ChatPartModel> parts;

  ChatMessageModel({required this.role, required this.parts});

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'parts': parts.map((part) => part.toMap()).toList(),
    };
  }

  ChatMessageModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : role = doc.data()?['role'],
        parts = (doc.data()?['parts'] as List<Map<String, dynamic>>)
            .map((partData) => ChatPartModel.fromMap(partData))
            .toList();
}

class ChatPartModel {
  final String text;

  ChatPartModel({required this.text});

  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }

  static ChatPartModel fromMap(Map<String, dynamic> map) {
    return ChatPartModel(
      text: map['text'],
    );
  }
}
