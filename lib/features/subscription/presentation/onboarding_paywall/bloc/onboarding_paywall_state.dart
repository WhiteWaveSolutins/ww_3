part of 'onboarding_paywall_bloc.dart';

@immutable
sealed class OnboardingPaywallState {
  final ApphudProduct? product;

  const OnboardingPaywallState({this.product});
}

final class OnboardingPaywallInitial extends OnboardingPaywallState {
  const OnboardingPaywallInitial({super.product});
}

final class LoadOnboardingPaywallState extends OnboardingPaywallState {


  const LoadOnboardingPaywallState(
      {super.product});
}

final class LoadingState extends OnboardingPaywallState {
  const LoadingState() : super();
}

final class ErrorState extends OnboardingPaywallState {
  const ErrorState() : super();
}