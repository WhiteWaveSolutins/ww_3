import 'dart:convert';

import 'package:flagsmith/flagsmith.dart';

class FlagSmithService {
  static const _apikey = 'oC5UoRdQntEe4yiKxmnBDc';

  late FlagsmithClient _flagsmithClient;

  late final String _apphudKey;
  late final String _privacyLink;
  late final String _termsLink;
  late final String _aiApiKey;

  Future<FlagSmithService> init() async {
    _flagsmithClient = await FlagsmithClient.init(
      apiKey: _apikey,
      config: const FlagsmithConfig(
        caches: true,
      ),
    );
    await _flagsmithClient.getFeatureFlags(reload: true);

    final config = jsonDecode(
        await _flagsmithClient.getFeatureFlagValue(ConfigKey.config.name) ??
            '') as Map<String, dynamic>;

    _apphudKey = config[ConfigKey.apphudKey.name];
    _privacyLink = config[ConfigKey.privacyLink.name];
    _termsLink = config[ConfigKey.termsLink.name];
    _aiApiKey = config[ConfigKey.aiApiKey.name];

    return this;
  }

  void closeClient() => _flagsmithClient.close();

  String get apphudKey => _apphudKey;

  String get privacyLink => _privacyLink;

  String get termsLink => _termsLink;

  String get aiApiKey => _aiApiKey;
}

enum ConfigKey {
  config,
  apphudKey,
  privacyLink,
  termsLink,
  aiApiKey,
}
