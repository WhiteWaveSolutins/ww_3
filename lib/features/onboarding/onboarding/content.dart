import '../../../shared/utils/assets.dart';

class OnboardingContent {
  final String title;
  final String description;
  final String image;

  OnboardingContent(
      {required this.title, required this.description, required this.image});
}

final onboardingContents = [
  OnboardingContent(
      description:
          'VoiceTranslate instantly translates your conversations and audio into the language you need.',
      image: sOnboarding1,
      title: 'Welcome to VoiceTranslate Clear!'),
  OnboardingContent(
      description:
          'Get accurate translations instantly. Perfect for travel, business, and connecting with new people.',
      image: sOnboarding2,
      title: 'Real-Time Translation: Speak and Understand'),
  OnboardingContent(
      description:
          'Explore a world of possibilities with support for a wide range of languages. Speak freely and connect globally.',
      image: sOnboarding3,
      title: 'Multiple Languages: Communicate'),
];
