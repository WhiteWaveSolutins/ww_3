import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// These are the Viewport values of your Figma Design.
// These are used in the code as a reference to create your UI Responsively.
// const num _figmaDesignWidth = 375;
// const num _figmaDesignHeight = 812;
// const num _figmaDesignViewPort = 0;

final horizontalPadding = 14.w;
final verticalPadding = 14.h;
final largeTextSize = 28.sp;
final mediumTextSize = 18.sp;
final textSize = 14.sp;
final smallTextSize = 10.h;
final smallVerticalPadding = 6.h;
final smallHorizontalPadding = 6.w;
final textFieldBorderRadius = 6.w;
final bigBorderRadius = 16.w;
final bigPadding = 32.sp;
final buttonHeight = 50.sp;

Size kAppsize(BuildContext context) => MediaQuery.of(context).size;

// typedef ResponsiveBuild = Widget Function(
//   BuildContext context,
//   Orientation orientation,
//   DeviceType deviceType,
// );

// class Sizer extends StatelessWidget {
//   const Sizer({
//     super.key,
//     required this.builder,
//   });

//   /// Builds the widget whenever the orientation changes.
//   final ResponsiveBuild builder;

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       return OrientationBuilder(builder: (context, orientation) {
//         SizeUtils.setScreenSize(constraints, orientation);
//         return builder(context, orientation, SizeUtils.deviceType);
//       });
//     });
//   }
// }

// class SizeUtils {
//   /// Device's BoxConstraints
//   static late BoxConstraints boxConstraints;

//   /// Device's Orientation
//   static late Orientation orientation;

//   /// Type of Device
//   ///
//   /// This can either be mobile or tablet
//   static late DeviceType deviceType;

//   /// Device's Height
//   static late double height;

//   /// Device's Width
//   static late double width;

//   static void setScreenSize(
//     BoxConstraints constraints,
//     Orientation currentOrientation,
//   ) {
//     // Sets boxConstraints and orientation
//     boxConstraints = constraints;
//     orientation = currentOrientation;

//     // Sets screen width and height
//     if (orientation == Orientation.portrait) {
//       width =
//           boxConstraints.maxWidth.isNonZero(defaultValue: _figmaDesignWidth);
//       height = boxConstraints.maxHeight.isNonZero();
//     } else {
//       width =
//           boxConstraints.maxHeight.isNonZero(defaultValue: _figmaDesignWidth);
//       height = boxConstraints.maxWidth.isNonZero();
//     }
//     deviceType = DeviceType.mobile;
//   }
// }

// extension ResponsiveExtension on num {
//   /// This method is used to get device viewport width.
//   double get _width => SizeUtils.width;

//   /// This method is used to get device viewport height.
//   double get _height => SizeUtils.height;

//   /// This method is used to set padding/margin (for the left and Right side) &
//   /// width of the screen or widget according to the Viewport width.
//   double get w => ((this * _width) / _figmaDesignWidth);

//   /// This method is used to set padding/margin (for the top and bottom side) &
//   /// height of the screen or widget according to the Viewport height.
//   double get h =>
//       (this * _height) / (_figmaDesignHeight - _figmaDesignViewPort);

//   /// This method is used to set smallest px in image height and width
//   double get adaptSize {
//     var height = h;
//     var width = w;
//     return height < width ? height.toDoubleValue() : width.toDoubleValue();
//   }

//   /// This method is used to set text font size according to Viewport
//   double get fSize => adaptSize;
// }

// extension FormatExtension on double {
//   /// Return a [double] value with formatted according to provided fractionDigits
//   double toDoubleValue({int fractionDigits = 2}) {
//     return double.parse(toStringAsFixed(fractionDigits));
//   }

//   double isNonZero({num defaultValue = 0.0}) {
//     return this > 0 ? this : defaultValue.toDouble();
//   }
// }

// enum DeviceType { mobile, tablet, desktop }
