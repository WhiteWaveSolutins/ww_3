import 'package:ai_translator/src/features/main/ui/main.dart';
import 'package:ai_translator/src/features/settings/ui/settings.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/strings.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/widgets/animated_column_and_row.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:flutter/cupertino.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static const routeName = '/history';

  @override
  Widget build(BuildContext context) {
    return TranslatorScaffold(
        appBar: CupertinoNavigationBar(
            leading: const AppbackButton(),
            middle: Text(
              'History',
              style: context.displayLarge,
            ),
            trailing: const SettingsButton()),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          child: TranslatorAnimatedColumn(
            children: [
              ...historyItems.map((e) => HistoryWidget(
                    historyItem: e,
                    isHistory: true,
                  ))
            ],
          ),
        ));
  }
}
