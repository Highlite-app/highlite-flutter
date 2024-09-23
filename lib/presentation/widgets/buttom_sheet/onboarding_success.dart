// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';
// import '../../../app.dart';
// import '../../../core/resources/spacing_theme.dart';
//
// Future<void> showOnboardingSuccess(String firstName, VoidCallback completion) =>
//     showModalBottomSheet(
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(Spacing.spacing_big),
//           topRight: Radius.circular(Spacing.spacing_big),
//         ),
//       ),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       context: globalNavKey.currentContext!,
//       useRootNavigator: true,
//       builder: (BuildContext context) {
//         return OnboardingSuccessView(
//           name: firstName,
//           onComplete: () async {
//             context.navigator.pop();
//             completion();
//           },
//         );
//       },
//     );
//
// class OnboardingSuccessView extends StatelessWidget {
//   final String name;
//   final VoidCallback onComplete;
//
//   const OnboardingSuccessView(
//       {super.key, required this.name, required this.onComplete});
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       children: [
//         Container(
//           decoration: const BoxDecoration(
//             color: ColorTheme.shade00,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(
//               top: Spacing.spacing_lg,
//               bottom: 60.0
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 8.0),
//                   child: Image.asset("$iconsPath/checkmark-circle-02.png"),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Text(
//                     currentLocalizations.onboardingSuccessViewTitle(name),
//                     textAlign: TextAlign.center,
//                     style: const BaseTextStyle(
//                       fontSize: TypographyTheme.heading_H5,
//                       fontWeight: FontWeight.w600,
//                       color: ColorTheme.neutral900,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       top: 10.0, bottom: Spacing.spacing_x_big),
//                   child: Text(
//                     currentLocalizations.onboardingSuccessViewDescription,
//                     style: const BaseTextStyle(
//                       fontSize: TypographyTheme.paragraph_p3,
//                       color: ColorTheme.neutral600,
//                     ),
//                   ),
//                 ),
//                 PrimaryButton(title: currentLocalizations.letsGo, onTap: onComplete, horizontalPadding: 20.0,)
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
