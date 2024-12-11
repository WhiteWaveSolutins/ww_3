import 'dart:convert';

import 'package:ai_translator/src/api_key.dart';
import 'package:ai_translator/src/models/auth/response/openai.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class TranslationService {
  final Dio _dio = Dio();

  Future<void> fetchChatGPTModels(String apiKey) async {
    const String apiUrl = "https://api.openai.com/v1/models";

    try {
      final response = await _dio.get(apiUrl,
          options: Options(
            headers: {
              'Authorization': 'Bearer $apiKey',
              'Content-Type': 'application/json',
            },
          ));

      if (response.statusCode == 200) {
        final models = response.data['data'] as List;
        for (var model in models) {
          debugPrint(model['id']);
        }
      } else {
        debugPrint(
            "Failed to fetch models. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching models: $e");
    }
  }

  Future<String> translateText(String text, String targetLanguage) async {
    const url = 'https://api.openai.com/v1/chat/completions';

    debugPrint('These are the requests:::: $kApiKey,$text, $targetLanguage');

    final response = await _dio.post(
      url,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $kApiKey',
        },
      ),
      data: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "system",
            "content":
                "Your role is to translate the following text to $targetLanguage, nothing more. Do not do more than specified. If you do not understand the prompt, just return the translation of the text."
          },
          {"role": "user", "content": text}
        ]
      }),
    );

    if (response.statusCode == 200) {
      debugPrint("This is the data:::${response.data}");
      final data = OpenAIResponse.fromJson(response.data);
      debugPrint('Open AI RESPONSE$data');

      return data.choices[0].message.content;
    } else {
      throw Exception('Failed to translate text');
    }
  }
}
