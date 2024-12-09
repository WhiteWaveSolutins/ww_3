// import 'package:ai_translator/src/features/settings/logic/settings_controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class SettingsView extends StatefulWidget {
//   const SettingsView({super.key, required this.controller});

//   static const routeName = '/settings';

//   final SettingsController controller;

//   @override
//   State<SettingsView> createState() => _SettingsViewState();
// }

// class _SettingsViewState extends State<SettingsView> {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: const CupertinoNavigationBar(
//         middle: Text('Theme Settings'),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CupertinoSegmentedControl<ThemeMode>(
//               children: const {
//                 ThemeMode.system: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: Text('System Theme'),
//                 ),
//                 ThemeMode.light: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: Text('Light Theme'),
//                 ),
//                 ThemeMode.dark: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: Text('Dark Theme'),
//                 ),
//               },
//               onValueChanged: (ThemeMode value) {
//                 widget.controller.updateThemeMode(value);
//               },
//               groupValue: widget.controller.themeMode,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
