import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/utils/assets.dart';
import '../../../../../shared/utils/size_utils.dart';
import '../../../../../shared/utils/strings.dart';
import '../../../../../shared/utils/text_theme.dart';
import '../../../../../shared/utils/theme.dart';
import '../../../../../shared/widgets/bottom_sheet.dart';
import '../../../../../shared/widgets/buttons.dart';
import '../../../../../shared/widgets/drop_down.dart';
import '../../../../../shared/widgets/textfields.dart';
import '../../../../settings/ui/settings.dart';
import '../../../../subscription/cubit/subscription_cubit.dart';
import '../../../../translate/logic/viewmodel.dart';
import '../../../data/model.dart';
import '../../viewmodel/history_viewmodel.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        context.read<SubscriptionCubit>().checkHasPremiumAccess();
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => const TranslatorSettingsScreen(),
          ),
        );
      },
      child: IconBackgroundWidget(
        svgIcon: sSettings,
      ),
    );
  }
}

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({
    super.key,
    required this.historyItem,
    this.onOptionPressed,
    this.isHistory = false,
  });
  final HistoryItem historyItem;
  final void Function()? onOptionPressed;
  final bool? isHistory;
  @override
  Widget build(BuildContext context) {
    return Consumer<RecordingViewModel>(
      builder: (context, value, child) => Consumer<HistoryViewmodel>(
        builder: (__, viewmodel, _) => GestureDetector(
          onTap: () {
            if (isHistory!) {
              showHistoryItemSheet(context, value, historyItem);
            }

            viewmodel.toggleMenu(viewmodel.emptyHistoryItem);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: verticalPadding),
            padding: const EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(bigBorderRadius),
              color: kSecondaryFade1.withValues(alpha: .05),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        height: 20,
                        child: CupertinoButton(
                          onPressed: () {
                            viewmodel.toggleMenu(historyItem);
                          },
                          padding: EdgeInsets.zero,
                          child: SvgPicture.asset(sMore),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isHistory!)
                          Row(
                            children: [
                              Text(
                                value.inputLang['flag']!,
                                style: context.displayLarge,
                              ),
                              HorizontalPadding(
                                child: Text(
                                  value.outputLang['flag']!,
                                  style: context.displayLarge,
                                ),
                              )
                            ],
                          ),
                        const VerticalSpacer(),
                        if (isHistory!)
                          Text(
                            value.inputLang['flag']!,
                            style: context.displayLarge,
                          ),
                        const VerticalSpacer(),
                        Text(historyItem.word),
                        if (isHistory!)
                          if (historyItem.translations.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                VerticalPadding(
                                    child: AppDivider(
                                  color: kTabFade1.withOpacity(0.3),
                                )),
                                Text(
                                  value.outputLang['flag']!,
                                  style: context.displayLarge,
                                ),
                                const VerticalSpacer(),
                                Text(historyItem.translations.first),
                              ],
                            ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: AppFabButton(
                        icon: CupertinoIcons.play_fill,
                        onPressed: () async {
                          await value.playTranslatedText(
                              textAndSound: historyItem.translations);
                        },
                      ),
                    )
                  ],
                ),
                if (historyItem == viewmodel.historyItem)
                  Align(
                      alignment: Alignment.topRight,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: 1,
                        child: Container(
                          margin: EdgeInsets.all(smallVerticalPadding),
                          padding: EdgeInsets.symmetric(
                            vertical: verticalPadding,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(bigBorderRadius),
                            color: kBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: kTabFade1.withValues(alpha: .02),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              HorizontalPadding(
                                child: CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    showHistoryItemSheet(
                                        context, value, historyItem);
                                    viewmodel
                                        .toggleMenu(viewmodel.emptyHistoryItem);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Open',
                                        style: context.bodyMedium,
                                      ),
                                      SvgPicture.asset(sEdit),
                                    ],
                                  ),
                                ),
                              ),
                              const VerticalPadding(
                                  isSmallPadding: true, child: AppDivider()),
                              HorizontalPadding(
                                child: CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    value.copyToClipboard(
                                        historyItem.translations.first);
                                    viewmodel
                                        .toggleMenu(viewmodel.emptyHistoryItem);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Copy',
                                        style: context.bodyMedium,
                                      ),
                                      const RotatedBox(
                                        quarterTurns: 1,
                                        child: Icon(
                                          CupertinoIcons.square_arrow_left,
                                          color: CupertinoColors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const VerticalPadding(
                                  isSmallPadding: true, child: AppDivider()),
                              HorizontalPadding(
                                child: CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    context
                                        .read<HistoryViewmodel>()
                                        .deleteHistoryItem(historyItem);
                                    viewmodel
                                        .toggleMenu(viewmodel.emptyHistoryItem);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Delete',
                                        style: context.bodyMedium,
                                      ),
                                      const Icon(
                                        CupertinoIcons.delete,
                                        color: CupertinoColors.systemRed,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainActionButton extends StatelessWidget {
  const MainActionButton({
    super.key,
    required this.language,
    this.icon,
    this.height,
    this.width,
    this.onPressed,
    this.iconWidget,
  });

  final String language;
  final String? icon;
  final double? height, width;
  final VoidCallback? onPressed;
  final Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    assert(icon != null || iconWidget != null);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        height: height ?? 40,
        width: width ?? 120,
        padding: EdgeInsets.only(
          left: horizontalPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: kSecondaryFade1.withValues(alpha: .15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            iconWidget == null ? Text(icon!) : iconWidget!,
            HorizontalSpacer(
              space: smallHorizontalPadding,
            ),
            Expanded(
              child: Text(
                language,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.bodySmall.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getNameByCode(String code) {
  try {
    return supportedLanguages
        .firstWhere((language) => language['code'] == code)['name'] as String;
  } catch (e) {
    return 'N/A';
  }
}

String getFlagByCode(String code) {
  try {
    return supportedLanguages
        .firstWhere((language) => language['code'] == code)['flag'] as String;
  } catch (e) {
    return 'N/A';
  }
}

Future<dynamic> showHistoryItemSheet(
  BuildContext context,
  RecordingViewModel value,
  HistoryItem item,
) {
  DateFormat formatter = DateFormat('MMM d, HH:mm');

//  formatter.format(now);
  return showAppBottomSheet(context,
      isDismissible: true,
      child: Padding(
        padding: EdgeInsets.only(top: bigPadding),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${getNameByCode(item.countries.first)} - ${getNameByCode(item.countries.last)}',
                    style: context.displayLarge,
                  ),
                  Text(formatter
                      .format(DateTime.tryParse(item.date) ?? DateTime.now()))
                ],
              ),
              PlayWidget(
                value: value,
                item: item,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: verticalPadding),
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(bigBorderRadius),
              color: kSecondaryFade1.withValues(alpha: .02),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${getFlagByCode(item.countries.first)}  ${getNameByCode(item.countries.first)}',
                          style: context.bodyLarge,
                        ),
                        const VerticalSpacer(),
                        Text(item.word),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            VerticalPadding(
                              child: AppDivider(
                                color: kTabFade1.withValues(alpha: .3),
                              ),
                            ),
                            Text(
                              '${getFlagByCode(item.countries.last)}  ${getNameByCode(item.countries.last)}',
                              style: context.bodyLarge,
                            ),
                            const VerticalSpacer(),
                            Text(
                              item.translations.first,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ));
}

class PlayWidget extends StatelessWidget {
  const PlayWidget({
    super.key,
    required this.value,
    required this.item,
  });
  final RecordingViewModel value;
  final HistoryItem item;

  @override
  Widget build(BuildContext context) {
    return AppFabButton(
      icon: !value.isPlayingAudio
          ? CupertinoIcons.play_fill
          : CupertinoIcons.pause,
      onPressed: () async {
        await value.playTranslatedText(textAndSound: item.translations);
      },
    );
  }
}
