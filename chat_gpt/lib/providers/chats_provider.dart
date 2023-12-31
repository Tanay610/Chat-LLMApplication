import 'package:chat_gpt/models/chat_models.dart';
import 'package:chat_gpt/services/api_services.dart';
import 'package:flutter/cupertino.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String chosenModelId}) async {
    chatList.addAll(
        await ApiService.sendMessages(message: msg, modelId: chosenModelId));
    notifyListeners();
  }
}
