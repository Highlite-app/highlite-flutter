import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../core/resources/asset_constants.dart';
import '../form/form.dart';
import '../sectionable/heading.dart';
import '../svg/svg_asset.dart';
enum TitledTextFieldType { location, normal  , otp ,  currency}



class TitledTextField extends StatefulWidget {
  final StringValidationCallback? validator;
  final ValueNotifier<FormProviderState>? formProvider;
  final String? hinText;
  final bool readOnly ;
  final TextInputType? textInputType;
  final TextEditingController textController;
  final bool hasError;
  final String title;
  final TitledTextFieldType titledTextFieldType;

  const TitledTextField({
    required this.textController,
    this.validator,
    this.hasError = false,
    this.textInputType,
    this.readOnly = false  ,
    this.hinText,
    this.formProvider,

    this.titledTextFieldType = TitledTextFieldType.normal,
    required this.title,
    super.key,
  });

  @override
  State<TitledTextField> createState() => _TitledTextFieldState();
}

class _TitledTextFieldState extends State<TitledTextField> {


  List<TextInputFormatter> textFormatter = [];

  final currencyFormatter = CurrencyTextInputFormatter.currency(
      locale: 'en', decimalDigits: 2, symbol: '\$', enableNegative: false);

  @override
  void initState() {
    super.initState();

    if (widget.textInputType == TextInputType.number) {
      textFormatter = [currencyFormatter];
    }

  }

  @override
  Widget build(BuildContext context) {
    String validatorCall = '';
    if (widget.formProvider != null && widget.formProvider?.value != FormProviderState.empty) {
      validatorCall = widget.validator?.call(widget.textController.text) ?? '';
    }

    const errorBorder = UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: ColorConstant.destructive400),
    );

    final border = UnderlineInputBorder(
      borderSide: BorderSide(width: 1 , color: ColorConstant.neutral200, style: BorderStyle.solid),
    );

    final focusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: ColorConstant.primary500, style: BorderStyle.solid),
    );

    return Heading(
      spacing: 4.0,
      textStyle: BaseTextStyle(
          color: ColorConstant.shade100 ,
          fontWeight: FontWeight.w500 ,
          fontSize: TypographyTheme.paragraph_p3
      ),
      title: widget.title,
      child: TextFormField(
        inputFormatters:  textFormatter,
        validator: widget.validator,
        controller: widget.textController,
        readOnly:  widget.readOnly,
        style: BaseTextStyle(
            color: ColorConstant.neutral800 ,
            fontSize:  TypographyTheme.paragraph_p3,
            fontWeight: FontWeight.w500
        ),
        cursorColor: ColorConstant.primary500,
        keyboardType: widget.textInputType ??TextInputType.name ,
        decoration: InputDecoration(
          prefixIconConstraints: const BoxConstraints(
            minWidth: 20,
            maxWidth: 20,
            maxHeight: 20,
            minHeight: 20,
          ),
          prefixIcon: widget.titledTextFieldType == TitledTextFieldType.location
              ? SvgAsset(
                asset: AssetConstant.locationIcon,
                color: ColorConstant.shade100,
              )
              : null,
          hintText: widget.hinText ?? 'Kolkata',
          labelStyle: BaseTextStyle(
              color: ColorConstant.shade00 ,
              fontWeight: FontWeight.w500 ,
              fontSize: TypographyTheme.paragraph_p3
          ),
          hintStyle: BaseTextStyle(
            color: ColorConstant.neutral400 ,
            fontWeight: FontWeight.w500 ,
            fontSize: TypographyTheme.paragraph_p3
          ),
          enabledBorder: validatorCall != '' ? errorBorder : border,
          border: validatorCall != '' ? errorBorder : border,
          focusedBorder: validatorCall != '' ? errorBorder : focusedBorder,
        ),
      ),
    );
  }
}
