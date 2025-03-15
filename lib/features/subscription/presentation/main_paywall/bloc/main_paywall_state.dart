part of 'main_paywall_bloc.dart';

@immutable
sealed class MainPaywallState {
  final ApphudProduct? product;

  const MainPaywallState({this.product});
}

final class MainPaywallInitial extends MainPaywallState {
  const MainPaywallInitial({super.product});
}

final class LoadMainPaywallState extends MainPaywallState {

  const LoadMainPaywallState(
      {super.product});
}

final class LoadingState extends MainPaywallState {
  const LoadingState() : super();
}

final class ErrorState extends MainPaywallState {
  const ErrorState() : super();
}