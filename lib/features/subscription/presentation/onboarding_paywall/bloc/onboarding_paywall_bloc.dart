import 'dart:developer';

import 'package:apphud/models/apphud_models/apphud_product.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../../core/services/subscription_service.dart';

part 'onboarding_paywall_event.dart';
part 'onboarding_paywall_state.dart';

class OnboardingPaywallBloc extends Bloc<OnboardingPaywallEvent, OnboardingPaywallState> {
  OnboardingPaywallBloc() : super(const OnboardingPaywallInitial()) {
    on<GetOnboardingPaywallEvent>(_getOnboardingPaywallHandler);

    add(GetOnboardingPaywallEvent());
  }

  final _subscriptionService = GetIt.instance<SubscriptionService>();

  void _getOnboardingPaywallHandler(
      GetOnboardingPaywallEvent event, Emitter<OnboardingPaywallState> emit) async {
    try {
      emit(const LoadingState());
      var onboardingPaywall = await _subscriptionService.getOnboardingPaywall();

      var product = onboardingPaywall.products!.first;


      emit(LoadOnboardingPaywallState(
        product: product,
      ));
    } catch (e) {
      log(e.toString());
      emit(const ErrorState());
    }
  }
}