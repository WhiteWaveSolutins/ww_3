import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'features/subscription/cubit/subscription_cubit.dart';
import 'features/subscription/presentation/main_paywall/bloc/main_paywall_bloc.dart';
import 'features/subscription/presentation/onboarding_paywall/bloc/onboarding_paywall_bloc.dart';
import 'service-locators/app.dart';
import 'shared/utils/app_providers.dart';

Future<void> main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  await AppServiceLocator.initialize();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    AppInfo(
      data: await AppInfoData.get(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SubscriptionCubit>(
              create: (context) =>
                  SubscriptionCubit()..checkHasPremiumAccess()),
          BlocProvider<OnboardingPaywallBloc>(create: (context) => OnboardingPaywallBloc()),
          BlocProvider<MainPaywallBloc>(create: (context) => MainPaywallBloc()),
        ],
        child: MultiProvider(
          providers: [...appProviders],
          child: const MyApp(),
        ),
      ),
    ),
  );
}
