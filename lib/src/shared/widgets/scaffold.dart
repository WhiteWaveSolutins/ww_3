import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/loaders.dart';
import 'package:flutter/cupertino.dart';

class TranslatorScaffold extends StatefulWidget {
  const TranslatorScaffold({
    super.key,
    required this.body,
    this.backgroundColor,
    this.isLoading = false,
    this.appBar,
    this.floatingActionButton,
    this.isUnavailableFeatureScreen = false,
    this.bottomsheet,
    this.bottomAppBar,
    this.drawer,
  });

  final Widget body;
  final Color? backgroundColor;
  final bool isLoading;
  final ObstructingPreferredSizeWidget? appBar;
  final Widget? bottomsheet, drawer;
  final Widget? floatingActionButton, bottomAppBar;
  final bool isUnavailableFeatureScreen;

  @override
  State<TranslatorScaffold> createState() => _TranslatorScaffoldState();
}

class _TranslatorScaffoldState extends State<TranslatorScaffold> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: CupertinoPageScaffold(
        backgroundColor: widget.backgroundColor ?? kBackgroundColor,
        navigationBar: widget.appBar,
        resizeToAvoidBottomInset: false,
        child: Stack(
          children: [
            SafeArea(child: widget.body),
            if (widget.isLoading) const AppLoader(),
          ],
        ),
      ),
    );
  }
}

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar(
//       {super.key,
//       this.title,
//       this.leading,
//       this.actions,
//       this.backgroundColor,
//       this.centerTitle,
//       this.isLoading = false});
//   final Widget? title;
//   final Widget? leading;
//   final List<Widget>? actions;
//   final Color? backgroundColor;
//   final bool? centerTitle;
//   final bool isLoading;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: context.background,
//       title: title != null
//           ? AbsorbPointer(absorbing: isLoading, child: title)
//           : null,
//       leading: leading != null
//           ? AbsorbPointer(absorbing: isLoading, child: leading)
//           : null,
//       actions: actions != null
//           ? [
//               ...actions!.map((action) => AbsorbPointer(
//                     absorbing: isLoading,
//                     child: action,
//                   ))
//             ]
//           : actions,
//       centerTitle: centerTitle,
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
// }
