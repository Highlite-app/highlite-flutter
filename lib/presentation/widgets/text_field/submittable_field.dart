import 'package:flutter/material.dart';

import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../buttons/primary_button.dart';
import '../buttons/tag_item.dart';
import '../constants/text_style.dart';
import '../form/form_element.dart';

enum SubmittableFieldType { underlined, outlined }

class SubmittableField extends StatefulWidget {
  final String? title;
  final TextInputAction? inputAction;
  final String? placeholderText;
  final String? captionText;
  final TextInputType? keyboardType;
  final bool hasErrors;
  final String submitText;
  final TagWrap? group;
  final SubmittableFieldType submittableFieldType;

  final Function(String) onSubmit;
  final bool isEnabled;

  const SubmittableField({
    super.key,
    this.title,
    this.inputAction = TextInputAction.done,
    this.placeholderText,
    this.keyboardType = TextInputType.text,
    this.captionText,
    this.submittableFieldType = SubmittableFieldType.outlined,
    this.hasErrors = false,
    required this.submitText,
    this.group,
    required this.onSubmit,
    this.isEnabled = true,
  });

  @override
  State<SubmittableField> createState() => _SubmittableFieldState();
}

class _SubmittableFieldState extends State<SubmittableField> {
  final TextEditingController? textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final errorBorder =    UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: ColorConstant.destructive400),
    );

    final normalBorder =  UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: ColorConstant.neutral200),
    );

    final focusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: ColorConstant.primary500),
    );
    return
      FormElement(
      title: widget.title,
      titleColor: ColorConstant.neutral900,
      captionText: widget.captionText,
      hasErrors: widget.hasErrors,
      child: TextFormField(
        cursorColor: ColorConstant.primary500,
        controller: textController,
        textInputAction: widget.inputAction,
        keyboardType: widget.keyboardType,
        textAlignVertical: TextAlignVertical.top,
        textAlign: TextAlign.left,
        style: BaseTextStyle(
            color: ColorConstant.neutral800 ,
            fontSize:  TypographyTheme.paragraph_p3,
            fontWeight: FontWeight.w500
        ),
        textCapitalization: TextCapitalization.words,
        maxLines: 1,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        decoration: InputDecoration(
          suffix: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: PrimaryButton(
              size: PrimaryButtonSize.normal,
              onTap: widget.isEnabled == true
                  ? () {
                      widget.onSubmit(textController?.value.text ?? "");
                      setState(() {
                        textController?.text = "";
                      });
                    }
                  : null,
              title: widget.submitText,
              autoGrow: false,
              curveStyle: CurveStyle.all,
            ),
          ),
          hintText: widget.placeholderText,
          hintStyle: BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p3,
            color: ColorConstant.neutral500,
          ),
          hintMaxLines: 1,
          filled: false,
          fillColor: ColorConstant.neutral50,
          contentPadding: EdgeInsets.zero,
          enabledBorder: widget.hasErrors ? errorBorder : normalBorder,
          border: widget.hasErrors ? errorBorder : normalBorder,
          focusedBorder: widget.hasErrors ? errorBorder : focusedBorder,
        ),
      ),
    );
  }
}
