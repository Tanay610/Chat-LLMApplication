import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:chat_gpt/constants/api_constants.dart';
import 'package:chat_gpt/models/chat_models.dart';
import 'package:chat_gpt/models/models_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
          Uri.parse("https://api.openai.com/v1/models"),
          headers: {'Authorization': 'Bearer $API_KEY'});

      /// this is a  map string it takes key and value,

      Map jsonResponse = jsonDecode(response.body);

      /// to give error if we didnt give it any input
      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      // print("jsonResponse $jsonResponse");
      List temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
        //  log("temp ${value["id"]}");
      }

      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

  // send messages fact

  static Future<List<ChatModel>> sendMessages(
      {required String message, required String modelId}) async {
    try {
      log("modelId $modelId");
      var response = await http.post(
          Uri.parse("https://api.openai.com/v1/completions"),
          headers: {
            'Authorization': 'Bearer $API_KEY',
            "Content-Type": "application/json"
          },
          body: jsonEncode(
              {"model": modelId, "prompt": message, "max_tokens": 100}));

      /// this is a  map string it takes key and value,

      Map jsonResponse = jsonDecode(response.body);

      /// to give error if we didnt give it any input
      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      // print("jsonResponse $jsonResponse");
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        // log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
              msg: jsonResponse["choices"][index]["text"], chatIndex: 1),
        );
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
