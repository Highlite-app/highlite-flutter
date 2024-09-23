import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/edit_profile/form/profile_editor_form_item.dart';

import '../../../chat/chat_responder.dart';
import '../../../form/form.dart';
import '../../../text_field/form_field.dart';

class ProfileEditorFormField extends StatelessWidget {
  final String label;
  final String? caption;
  final String? title;
  final String? value;
  final MinMax<int>? minMaxLines;
  final TextInputAction? inputAction;
  final String? placeholderText;
  final String? captionText;
  final TextInputType? keyboardType;
  final MinMax<double>? height;
  final MinMax<int>? characterLimit;
  final bool hasErrors;
  final TextEditingController? textController;
  final TextCapitalization textCapitalization;
  final StringValidationCallback? validator;
  final ValueNotifier<FormProviderState>? formState;
  final CustomFormFieldType resultType;
  final List<TextInputFormatter>? formatter;
  final bool spaced;

  const ProfileEditorFormField({
    super.key,
    required this.label,
    this.caption,
    this.title,
    this.value,
    this.minMaxLines,
    this.inputAction = TextInputAction.done,
    this.keyboardType = TextInputType.multiline,
    this.placeholderText,
    this.height,
    this.characterLimit,
    this.captionText,
    this.hasErrors = false,
    this.textCapitalization = TextCapitalization.words,
    this.textController,
    this.validator,
    this.formState,
    this.resultType = CustomFormFieldType.normal,
    this.formatter,
    this.spaced = false,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileEditorFormItem(
      label: label,
      caption: caption,
      children: Padding(
        padding: EdgeInsets.only(top: spaced ? 8.0 : 0.0),
        child: CustomFormField(
          title: title,
          value: value,
          minMaxLines: minMaxLines,
          inputAction: inputAction,
          placeholderText: placeholderText,
          height: height,
          characterLimit: characterLimit,
          captionText: captionText,
          hasErrors: hasErrors,
          textCapitalization: textCapitalization,
          textController: textController,
          validator: validator,
          formState: formState,
          resultType: resultType,
          formatter: formatter,
        ),
      ),
    );
  }
}
