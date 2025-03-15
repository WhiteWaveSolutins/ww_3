import 'dart:developer';

import 'package:apphud/models/apphud_models/apphud_product.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../../core/services/subscription_service.dart';

part 'main_paywall_event.dart';

part 'main_paywall_state.dart';

class MainPaywallBloc extends Bloc<MainPaywallEvent, MainPaywallState> {
  MainPaywallBloc() : super(const MainPaywallInitial()) {
    on<GetMainPaywallEvent>(_getMainPaywallHandler);

    add(GetMainPaywallEvent());
  }

  final _subscriptionService = GetIt.instance<SubscriptionService>();

  void _getMainPaywallHandler(
      GetMainPaywallEvent event, Emitter<MainPaywallState> emit) async {
    try {
      emit(const LoadingState());
      var mainPaywall = await _subscriptionService.getMainPaywall();

      var product = mainPaywall.products!.first;

      emit(LoadMainPaywallState(
        product: product,
      ));
    } catch (e) {
      log(e.toString());
      emit(const ErrorState());
    }
  }
}
