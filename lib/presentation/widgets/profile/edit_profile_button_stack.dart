import 'package:flutter/material.dart';
import '../../../core/resources/l10n/translation_key.dart';
import '../buttons/button_stack.dart';
import '../buttons/default_button.dart';

class EditProfileButtonStack extends StatelessWidget {
  final VoidCallback cancelAction;
  final VoidCallback saveAction;
  final bool isRequestButton;
  const EditProfileButtonStack({
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
            title: TranslationKeys.save,
            plain: false,
            onTap: saveAction),
      ],
      alignment: MainAxisAlignment.end,
      direction: Axis.horizontal,
      padding: const EdgeInsets.only(right: 6.0),
    );
  }
}
