import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../buttons/rippler.dart';
import '../text/iconized_text.dart';
import 'alert_modal.dart';

class SelectableOption {
  final String title;
  final String icon;

  const SelectableOption({required this.title, required this.icon});
}

class SelectableModal extends StatelessWidget {
  final String title;
  final List<SelectableOption> options;

  const SelectableModal({
    super.key,
    required this.title,
    required this.options,
  });

  static Future<String?> showModal(
    BuildContext context,
    String title,
    List<SelectableOption> options,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return SelectableModal(
          title: title,
          options: options,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertModal(
      title: title,
      child: Column(
        children: [
          const SizedBox(
            height: 16.0,
          ),
          Wrap(
            runSpacing: 16.0,
            spacing: 16.0,
            children: options
                .map(
                  (option) => Rippler(
                    onTap: () {
                      context.navigator.pop(option.title);
                    },
                    child: IconizedText(
                      icon: option.icon,
                      text: option.title,
                      iconColor: ColorConstant.neutral800,
                      iconSize: 24,
                      textColor: ColorConstant.neutral800,
                      textSize: TypographyTheme.paragraph_p3,
                      fontWeight: FontWeight.w500,
                      spacing: 8.0,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
