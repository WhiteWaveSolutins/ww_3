import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/authentication/presentation/viewmodel/authentication_viewmodel.dart';
import '../../features/authentication/presentation/viewmodel/user_provider.dart';
import '../../features/main/presentation/viewmodel/history_viewmodel.dart';
import '../../features/translate/logic/viewmodel.dart';
import '../../service-locators/app.dart';

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
