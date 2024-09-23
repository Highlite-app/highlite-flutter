import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/svg/svg_asset.dart';
import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../../../core/services/location_service.dart';
import '../buttons/primary_button.dart';
import '../constants/text_style.dart';
import '../form/form_element.dart';

class LocationField extends StatefulWidget {
  final String? title;
  final TextInputAction? inputAction;
  final String? placeholderText;
  final String? captionText;
  final TextInputType? keyboardType;
  final bool hasErrors;
  final String submitText;
  final bool isEnabled;
  const LocationField({
    this.title,
    this.inputAction = TextInputAction.done,
    this.placeholderText,
    this.keyboardType = TextInputType.text,
    this.captionText,
    this.hasErrors = false,
    required this.submitText,
    this.isEnabled = true,
    super.key,
  });

  @override
  State<LocationField> createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  final TextEditingController? textController = TextEditingController();
  final focusNode = FocusNode();
  bool isFocused = false;

  final errorBorder = const UnderlineInputBorder(
    borderSide: BorderSide(width: 1, color: ColorConstant.destructive400),
  );

  final normalBorder =  UnderlineInputBorder(
    borderSide: BorderSide(width: 1, color: ColorConstant.neutral200),
  );

  final focusedBorder = UnderlineInputBorder(
    borderSide: BorderSide(width: 1, color: ColorConstant.primary500),
  );

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      isFocused = focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    focusNode.removeListener(_handleFocusChange);
    focusNode.dispose();
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormElement(
      title: widget.title,
      titleColor: ColorConstant.neutral900,
      captionText: widget.captionText,
      hasErrors: widget.hasErrors,
      child: TextFormField(
        readOnly: true,
        focusNode: focusNode,
        cursorColor: ColorConstant.primary500,

        controller: textController,
        textInputAction: widget.inputAction,
        keyboardType: widget.keyboardType,
        textAlignVertical: TextAlignVertical.top,
        textAlign: TextAlign.left,
        textCapitalization: TextCapitalization.words,
        maxLines: 1,
        style: BaseTextStyle(
          color: ColorConstant.neutral800 ,
          fontSize:  TypographyTheme.paragraph_p3,
          fontWeight: FontWeight.w500
        ),
        scrollPhysics: const NeverScrollableScrollPhysics(),
        decoration: InputDecoration(
          prefixIconConstraints: BoxConstraints(
            maxWidth: 25 ,
            minHeight: 25,
            maxHeight: 25,
            minWidth: 25
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0 , bottom: 5),
            child: SvgAsset(asset: AssetConstant.locationIcon,color: ColorConstant.primary900, ),
          ),
          suffix: isFocused
              ? Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: PrimaryButton(
              size: PrimaryButtonSize.small,
              onTap: widget.isEnabled == true
                  ? () async {
                final locationManager = LocationService();
                final placemark = await locationManager.getLocation();
                if (placemark != null) {
                  final location =
                      "${placemark.locality}, ${placemark.country}";
                  setState(() {
                    textController?.text = location;
                  });
                }
              }
                  : null,
              title: widget.submitText,
              autoGrow: false,
              curveStyle: CurveStyle.all,
            ),
          )
              : null,
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
