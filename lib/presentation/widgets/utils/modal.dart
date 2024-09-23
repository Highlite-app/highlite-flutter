import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/spacing_theme.dart';

extension Modal on BuildContext {
  Future<dynamic> showModalOnBottom<T>(Widget child) {
    return showModalBottomSheet<T>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Spacing.spacing_big),
          topRight: Radius.circular(Spacing.spacing_big),
        ),
      ),
      backgroundColor: ColorConstant.transparent,
      clipBehavior: Clip.none,
      context: this,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return child;
      },
    );
  }
}
