import 'package:ai_translator/src/features/authentication/presentation/viewmodel/authentication_viewmodel.dart';
import 'package:ai_translator/src/features/authentication/presentation/viewmodel/user_provider.dart';
import 'package:ai_translator/src/features/main/logic/history_viewmodel.dart';
import 'package:ai_translator/src/features/translate/logic/viewmodel.dart';
import 'package:ai_translator/src/service-locators/app.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

final appProviders = <SingleChildWidget>[
  ChangeNotifierProvider<RecordingViewModel>(
    create: (_) => serviceLocator<RecordingViewModel>(),
  ),
  ChangeNotifierProvider<UserStateProvider>(
    create: (_) => serviceLocator<UserStateProvider>(),
  ),
  ChangeNotifierProvider<AuthenticationViewModel>(
    create: (_) => serviceLocator<AuthenticationViewModel>(),
  ),
  ChangeNotifierProvider<HistoryViewmodel>(
    create: (_) => serviceLocator<HistoryViewmodel>(),
  ),
];
