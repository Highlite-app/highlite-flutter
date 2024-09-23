

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chat/chat_responder.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/string.dart';

import '../buttons/checkbox_button.dart';
import '../form/form.dart';
import '../utils/iterable.dart';

enum TextFieldType { normal, datePicker, bottomSheet }

enum Skill {
  accountant("accountant", "Accountant"),
  administrativeAssistant(
      "administrativeAssistant", "Administrative Assistant"),
  animation("animation", "Animation"),
  appointmentSetter("appointmentSetter", "Appointment Setter"),
  bookkeeper("bookkeeper", "Bookkeeper"),
  copywriter("copywriter", "Copywriter"),
  dataEntry("dataEntry", "Data Entry"),
  customerSupport("customerSupport", "Customer Support"),
  dataScraper("dataScraper", "Data Scraper"),
  seo("seo", "Seo"),
  digitalMarketer("digitalMarketer", "Digital Marketer"),
  graphicDesign("graphicDesign", "Graphic Design"),
  ui("ui", "UI"),
  photoEditor("photoEditor", "Photo Editor"),
  ux("ux", "UX"),
  softwareDeveloper("softwareDeveloper", "Software Developer"),
  salesRepresentative("salesRepresentative", "Sales Representative"),
  transactionManager("transactionManager", "Transaction Manager"),
  taxPreparation("taxPreparation", "Tax Preparation"),
  other("other", "Other");

  const Skill(this.id, this.title);

  final String id;
  final String title;
}

class UnderlinedTextFieldWithButton extends StatefulWidget {
  final TextEditingController controller;
  final String hinText;
  final bool isButtonEnable;
  final MinMax<double>? characterLimit;
  final void Function(String)? onSubmit;

  final StringValidationCallback? validator;

  final String? value;

  final ValueNotifier<FormProviderState>? formState;

  final VoidCallback? onTapNext;

  final String? labelText;
  final TextFieldType textFieldType;

  const UnderlinedTextFieldWithButton(
      {required this.controller,
      this.labelText,
      this.validator,
      this.formState,
      this.hinText = '',
      this.characterLimit,
      this.onSubmit,
      this.isButtonEnable = false,
      this.onTapNext,
      this.value = '',
      this.textFieldType = TextFieldType.normal,
      super.key});

  @override
  State<UnderlinedTextFieldWithButton> createState() =>
      _UnderlinedTextFieldWithButtonState();
}

class _UnderlinedTextFieldWithButtonState
    extends State<UnderlinedTextFieldWithButton> {
  bool _showButton = false;
  FocusNode focusNode = FocusNode();
  Color labelTextColor = ColorConstant.neutral400;
  String? validatorError;

  double labelFontSize = TypographyTheme.paragraph_p3;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_handleFocusChange);
    widget.controller.addListener(_handleTextChange);
    widget.formState?.addListener(_handleFormState);
  }

  void _handleFormState() {
    if (mounted) {
      setState(() {});
    }
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {
        if (focusNode.hasFocus) {
          labelTextColor = ColorConstant.primary500;
          labelFontSize = TypographyTheme.paragraph_p3;
        } else {
          labelTextColor = ColorConstant.neutral400;
          labelFontSize = TypographyTheme.paragraph_p4;
        }
      });
    }
  }

  void _handleTextChange() {
    if (mounted) {
      setState(() {
        _showButton = widget.controller.text.isNotEmpty;
      });
    }
  }

  @override
  void dispose() {
    focusNode.removeListener(_handleFocusChange);
    widget.controller.removeListener(_handleTextChange);
    widget.formState?.removeListener(_handleFocusChange);
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    validatorError = widget.formState?.value == FormProviderState.submitted
        ? widget.validator?.call(widget.controller.text)
        : null;

    const errorBorder = UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: ColorConstant.destructive400),
    );

    final border = UnderlineInputBorder(
      borderSide:
          BorderSide(color: ColorConstant.neutral200, style: BorderStyle.solid),
    );

    final focusedBorder = UnderlineInputBorder(
        borderSide: BorderSide(
            color: ColorConstant.primary500, style: BorderStyle.solid));

    void showDatePicker(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return SizedBox(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            child: CupertinoDatePicker(
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  widget.controller.text = formatDate(newDate);
                  widget.onSubmit?.call(widget.controller.text) ;
                });
              },
              mode: CupertinoDatePickerMode.date,
            ),
          );
        },
      );
    }

    void showBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24)),
                color: ColorConstant.neutral50),
            child: Padding(
              padding: const EdgeInsets.only(top: 36),
              child: SizedBox(
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 5,
                      color: ColorConstant.neutral400,
                    ),
                    const SizedBox(height: 24.0),
                    CheckBoxButton(
                      checkbox: sort(Skill.values
                          .toList()
                          .map((skill) => skill.title)
                          .toList()),
                      maxSelection: MinMax(0, 3),
                      onSubmit: (List<String> selectedChips) {
                        widget.controller.text =
                            selectedChips.map((item) => item).toString();
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(height: 40.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    void handleOnTap(BuildContext context , String value  ) {
      switch (widget.textFieldType) {
        case TextFieldType.datePicker:
          showDatePicker(context);
          break;
        case TextFieldType.bottomSheet:
          showBottomSheet(context);
          break;
        case TextFieldType.normal:
          null;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          focusNode: focusNode,
          validator: widget.validator != null
              ? (value) {
                  final validationResult = widget.validator!(value ?? '');
                  return validationResult == null ? null : '';
                }
              : null,
          readOnly: (widget.textFieldType == TextFieldType.datePicker) ||
              (widget.textFieldType == TextFieldType.bottomSheet),
          onTap: () {
            handleOnTap(context , widget.controller.text);
          },
          controller: widget.controller,
          maxLines: widget.characterLimit?.max.toInt() ?? 1,
          minLines: 1,
          maxLength: widget.characterLimit?.max.toInt(),
          cursorColor: ColorConstant.primary500,
          style: BaseTextStyle(
            color: ColorConstant.neutral800,
            fontSize: TypographyTheme.paragraph_p4,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
              counterText: (widget.characterLimit != null)
                  ? "${widget.controller.text.length}/${widget.characterLimit?.max.toInt()}"
                  : '',
              counterStyle: BaseTextStyle(
                  color: ColorConstant.neutral600,
                  fontSize: TypographyTheme.paragraph_p4,
                  fontWeight: FontWeight.w400),
              contentPadding: focusNode.hasFocus
                  ? const EdgeInsets.only(bottom: 5)
                  : EdgeInsets.zero,
              labelText: widget.labelText,
              labelStyle: BaseTextStyle(
                color: labelTextColor,
                fontSize: labelFontSize,
                fontWeight: FontWeight.w500,
              ),
              hintText: widget.hinText,
              hintMaxLines: 1,
              hintFadeDuration: const Duration(milliseconds: 300),
              hintStyle: BaseTextStyle(
                  color: ColorConstant.neutral400,
                  fontSize: TypographyTheme.paragraph_p4,
                  fontWeight: FontWeight.w600),
              floatingLabelBehavior:
                  (widget.textFieldType == TextFieldType.datePicker)
                      ? FloatingLabelBehavior.always
                      : FloatingLabelBehavior.auto,
              enabledBorder: validatorError != null ? errorBorder : border,
              border: validatorError != null ? errorBorder : border,
              errorText: null,
              errorStyle: const TextStyle(height: 0),
              errorBorder: validatorError != null ? errorBorder : border,
              focusedErrorBorder: validatorError != null ? errorBorder : border,
              focusedBorder:
                  validatorError != null ? errorBorder : focusedBorder),
        ),
        if (validatorError != null) ...[
          const SizedBox(height: 8.0),
          Text(
            validatorError!,
            style: BaseTextStyle(
              color: ColorConstant.destructive500,
              fontSize: TypographyTheme.paragraph_p5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        if (_showButton && widget.isButtonEnable)
          AnimatedOpacity(
            opacity: (_showButton && widget.isButtonEnable) ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 700),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              child: Padding(
                padding: const EdgeInsets.only(top: 36.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: widget.onTapNext != null
                        ? () {
                            widget.onTapNext!();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primary500),
                    child: Text(
                      "Next",
                      style: BaseTextStyle(
                        color: ColorConstant.shade00,
                        fontSize: TypographyTheme.paragraph_p3,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
