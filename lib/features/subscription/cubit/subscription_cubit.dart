import 'dart:ui';

import 'package:apphud/models/apphud_models/apphud_paywall.dart';
import 'package:apphud/models/apphud_models/apphud_paywalls.dart';
import 'package:apphud/models/apphud_models/apphud_product.dart';
import 'package:bloc/bloc.dart';
import 'package:gaimon/gaimon.dart';
import 'package:get_it/get_it.dart';

import '../../../core/services/subscription_service.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(SubscriptionState.initial());

  static final _subscriptionService = GetIt.instance<SubscriptionService>();

  Future<void> checkHasPremiumAccess() async {
    final hasPremium = await _subscriptionService.hasPremiumAccess();
    emit(state.copyWith(hasPremium: hasPremium));
  }

  Future<void> makePurchase(
      String productId, {
        VoidCallback? onDone,
        VoidCallback? onError,
      }) async {
    try {
      final result = await _subscriptionService.purchase(productId);
      if (result.error != null) {
        onError?.call();
      } else {
        await checkHasPremiumAccess();
        Gaimon.success();
        onDone?.call();
      }
    } catch (e) {
      Gaimon.error();
      onError?.call();
    }
  }

  Future<void> restore({
    VoidCallback? onDone,
    VoidCallback? onError,
  }) async {
    try {
      final result = await _subscriptionService.restore();
      if (result.error != null) {
        onError?.call();
      } else {
        await checkHasPremiumAccess();
        onDone?.call();
      }
    } catch (e) {
      onError?.call();
    }
  }


  void mockUpdate() => emit(state.copyWith(hasPremium: true));
}