import 'package:get_it/get_it.dart';

import '../flag_smith_service.dart';

mixin ConfigMixin {
  final _flagsmithService = GetIt.instance<FlagSmithService>();

  String get apphudKey => _flagsmithService.apphudKey;

  String get privacyLink => _flagsmithService.privacyLink;

  String get termsLink => _flagsmithService.termsLink;

  String get aiApiKey => _flagsmithService.aiApiKey;

}