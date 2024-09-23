import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:intl/intl.dart';

import '../../../core/resources/typography_theme.dart';
import '../chat/chat_responder.dart';
import '../constants/text_style.dart';
import '../form/form.dart';
import '../form/form_element.dart';

enum CustomFormFieldType {
  normal,
  date;
}

class CustomFormField extends StatefulWidget {
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

  const CustomFormField({
    super.key,
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
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  final FocusNode focus = FocusNode();

  @override
  void initState() {
    super.initState();

    focus.addListener(() {
      setState(() {});
    });

    if (widget.value != null) {
      widget.textController?.text = widget.value!;
    }
    widget.textController?.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    widget.formState?.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }


  @override
  void dispose() {
    super.dispose();
    widget.textController?.removeListener(() {
      setState(() {});
    });
    widget.formState?.removeListener(() {
      setState(() {});
    });
    focus.dispose();
    focus.removeListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String validatorCall = "";
    if (widget.formState != null &&
        widget.formState?.value != FormProviderState.empty) {
      validatorCall =
          widget.validator?.call(widget.textController?.text ?? "") ?? "";
    }
    return FormElement(
      title: widget.title,
      captionText: widget.captionText,
      footer: widget.characterLimit != null && focus.hasFocus
          ? Text(
              "Character Limit ${widget.textController?.text.length ?? 0}/${widget.characterLimit?.max ?? 1}.",
              style: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p3,
                color: widget.hasErrors ||
                        (widget.textController?.text.length ?? 0) >
                            widget.characterLimit!.max
                    ? ColorConstant.destructive400
                    : ColorConstant.primary500,
                fontWeight: FontWeight.w500,
              ),
            )
          : null,
      hasErrors: widget.hasErrors || validatorCall != "",
      errorText: validatorCall != "" ? validatorCall : null,
      child: _textField(),
    );
  }

  Widget _textField() {
    String validatorCall = "";
    if (widget.formState != null &&
        widget.formState?.value != FormProviderState.empty) {
      validatorCall =
          widget.validator?.call(widget.textController?.text ?? "") ?? "";
    }
    final errorBorder = OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: ColorConstant.destructive400),
      borderRadius: BorderRadius.circular(8.0),
    );
    final normalBorder = OutlineInputBorder(
      borderSide:const  BorderSide(width: 0, color: ColorConstant.light2),
      borderRadius: BorderRadius.circular(8.0),
    );
    double addedHeight = 0;
    return Container(
      constraints: BoxConstraints(
          minHeight: (widget.height?.min ?? 50) + addedHeight,
          maxHeight: (widget.height?.max ?? 50) + addedHeight),
      child: TextFormField(
        focusNode: focus,
        controller: widget.textController,
        initialValue: null,
        maxLines: widget.minMaxLines?.max,
        minLines: widget.minMaxLines?.min,
        textInputAction: widget.inputAction,
        keyboardType: widget.keyboardType,
        textCapitalization: widget.textCapitalization,
        expands: widget.minMaxLines?.max == null ? true : false,
        textAlignVertical: TextAlignVertical.top,
        validator: widget.validator,
        inputFormatters: widget.formatter ?? [],
        onTap: () {
          if (widget.resultType == CustomFormFieldType.date) {
            _showDatePicker();
            focus.unfocus();
          }
        },
        style: BaseTextStyle(
          fontSize: TypographyTheme.paragraph_p3,
          color: ColorConstant.neutral800,
          fontWeight: FontWeight.w500,
          height: 1.2,
        ),
        decoration: InputDecoration(
          errorStyle: const TextStyle(
            height: -1,
            color: Colors.transparent,
            fontSize: 0,
          ),
          hintText: widget.placeholderText,
          hintStyle: BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p3,
            color: ColorConstant.neutral500,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
          hintMaxLines: widget.minMaxLines?.max,
          filled: true,
          fillColor: ColorConstant.neutral50,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 16.0,
          ),
          enabledBorder: widget.hasErrors || validatorCall != ""
              ? errorBorder
              : normalBorder,
          border: widget.hasErrors || validatorCall != ""
              ? errorBorder
              : normalBorder,
          focusedBorder: widget.hasErrors || validatorCall != ""
              ? errorBorder
              : normalBorder,
          focusedErrorBorder: widget.hasErrors || validatorCall != ""
              ? errorBorder
              : normalBorder,
          errorBorder: widget.hasErrors || validatorCall != ""
              ? errorBorder
              : normalBorder,
        ),
      ),
    );
  }

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate: DateTime(0),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      widget.textController?.text = DateFormat('MMMM yyyy').format(pickedDate);
    }
  }
}
