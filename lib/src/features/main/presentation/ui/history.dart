import 'package:ai_translator/src/features/main/presentation/viewmodel/history_viewmodel.dart';
import 'package:ai_translator/src/features/main/presentation/ui/widgets/widgets.dart';
import 'package:ai_translator/src/features/settings/ui/settings.dart';
import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/widgets/animated_column_and_row.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  static const routeName = '/history';

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    context.read<HistoryViewmodel>().getHistoryItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryViewmodel>(
      builder: (context, value, child) => TranslatorScaffold(
          appBar: CupertinoNavigationBar(
            leading: const AppbackButton(),
            middle: Text(
              'History',
              style: context.displayLarge,
            ),
            trailing: const SettingsButton(),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
            child: (value.historyItemList.histories.isEmpty)
                ? TranslatorAnimatedColumn(
                    children: [
                      ...value.historyItemList.histories
                          .map((e) => HistoryWidget(
                                historyItem: e,
                                isHistory: true,
                              ))
                    ],
                  )
                : Center(
                    child: SvgPicture.asset(sMain),
                  ),
          )),
    );
  }
}
