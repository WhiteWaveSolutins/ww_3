import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ai_translator/src/api_key.dart';
import 'package:ai_translator/src/models/auth/response/openai.dart';
import 'package:ai_translator/src/shared/utils/strings.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<Either<String, List<String>>> translateText(
      String text, String targetLanguage) async {
    const url = 'https://api.openai.com/v1/chat/completions';

    debugPrint('These are the requests:::: $kApiKey, $text, $targetLanguage');

    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $kApiKey',
          },
        ),
        data: jsonEncode({
          "model": "gpt-4",
          "messages": [
            {"role": "system", "content": prompt(text, targetLanguage)},
            {"role": "user", "content": text}
          ]
        }),
      );

      if (response.statusCode == 200) {
        debugPrint("This is the data:::${response.data}");
        final data = OpenAIResponse.fromJson(response.data);
        debugPrint('Open AI RESPONSE: $data');

        final res = data.choices[0].message.content;

        // Check if `res` is empty
        if (res.trim().isEmpty) {
          return const Left('Translation result is empty.');
        }

        // Proceed with speech generation if `res` is not empty
        final speech = await _getSpeech(res);

        return Right([res, speech]);
      } else {
        log('Failed to translate text: ${response.statusMessage}');
        const errorMessage =
            'Failed to translate text: An Error Occured, try again later';

        return const Left(errorMessage);
      }
    } catch (e) {
      log('An error occurred: ${e.toString()}');
      const errorMessage =
          'Failed to translate text: An Error Occured, try again later';
      return const Left(errorMessage);
    }
  }
}

Future<String> _getSpeech(String text) async {
  OpenAI.apiKey = kApiKey;
  Directory appDocDirectory = await getApplicationDocumentsDirectory();

  try {
    // Ensure the directory path
    final outputDir = Directory('${appDocDirectory.path}/dir');
    if (!await outputDir.exists()) {
      await outputDir.create(recursive: true);
    }

    File speechFile = await OpenAI.instance.audio.createSpeech(
      model: "tts-1",
      input: text,
      voice: "nova",
      responseFormat: OpenAIAudioSpeechResponseFormat.opus,
      outputDirectory: outputDir,
      outputFileName: DateTime.now().microsecondsSinceEpoch.toString(),
    );
    log('Speech file Saved::: ${speechFile.path}');
    return speechFile.path;
  } catch (e) {
    log('Speech file not Saved $e');
    return '';
  }
}
