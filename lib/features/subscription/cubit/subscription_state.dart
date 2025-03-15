
part of 'subscription_cubit.dart';

class SubscriptionState {
  final bool hasPremium;

  const SubscriptionState({required this.hasPremium});

  factory SubscriptionState.initial() =>
      const SubscriptionState(hasPremium: false);

  SubscriptionState copyWith({
    bool? hasPremium,
  }) {
    return SubscriptionState(
      hasPremium: hasPremium ?? this.hasPremium,
    );
  }
}
