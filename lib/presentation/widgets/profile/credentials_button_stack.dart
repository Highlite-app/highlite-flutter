import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';

import '../buttons/button_stack.dart';
import '../buttons/default_button.dart';

class CredentialsButtonStack extends StatelessWidget {
  final VoidCallback cancelAction;
  final VoidCallback saveAction;
  final bool isRequestButton;
  const CredentialsButtonStack({
    super.key,
    this.isRequestButton = true,
    required this.cancelAction,
    required this.saveAction,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonStack(
      widgets: [
        DefaultButton(
            title: TranslationKeys.cancel, onTap: cancelAction),
        DefaultButton(
            title: isRequestButton
                ? TranslationKeys.request
                : TranslationKeys.save,
            plain: false,
            onTap: saveAction),
      ],
      alignment: MainAxisAlignment.end,
      direction: Axis.horizontal,
    );
  }
}
