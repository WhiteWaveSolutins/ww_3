import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/assets.dart';
import '../../../../shared/utils/size_utils.dart';
import '../../../../shared/widgets/animated_column_and_row.dart';
import '../../../../shared/widgets/scaffold.dart';
import '../../../../shared/widgets/textfields.dart';
import '../../../settings/ui/settings.dart';
import '../viewmodel/history_viewmodel.dart';
import 'widgets/widgets.dart';

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
      builder: (context, value, child) => AppBackground(
        imageBg: sMainBg,
        child: SafeArea(
          child: VerticalPadding(
            child: HorizontalPadding(
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppBackButton(),
                      HeaderText(text: 'History'),
                      SettingsButton(),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding:
                          const EdgeInsets.symmetric(vertical: verticalPadding),
                      child: value.getHistoryItem().histories.isNotEmpty
                          ? TranslatorAnimatedColumn(
                              children: [
                                ...value.getHistoryItem().histories.map(
                                      (e) => HistoryWidget(
                                        historyItem: e,
                                        isHistory: true,
                                      ),
                                    )
                              ],
                            )
                          : Center(
                              child: SvgPicture.asset(sMain),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
