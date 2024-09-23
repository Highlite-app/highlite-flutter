// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';

class CheckBoxForm extends StatefulWidget {
  final String? title;
  final Function(bool?) onChanged;
  final bool isChecked;
  const CheckBoxForm({
    super.key,
    this.title,
    required this.onChanged,
    this.isChecked = false,
  });

  @override
  State<CheckBoxForm> createState() => _CheckBoxFormState();
}

class _CheckBoxFormState extends State<CheckBoxForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.start,
        direction: Axis.horizontal,
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: RoundCheckBox(
              size: 30,
              checkedWidget: const Padding(
                padding: EdgeInsets.all(6.0),
                child: SvgAsset(asset: AssetConstant.checkMarkIcon, size: 10),
              ),
              checkedColor: ColorConstant.primary500,
              uncheckedColor: ColorConstant.shade00,
              isChecked: widget.isChecked,
              onTap: widget.onChanged,
              animationDuration: const Duration(
                milliseconds: 100,
              ),
            ),
          ),
          if (widget.title != null)
            Text(
              widget.title!,
              style:  BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p3,
                color: ColorConstant.neutral600,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}

class RoundCheckBox extends StatefulWidget {
  const RoundCheckBox({
    Key? key,
    this.isChecked,
    this.checkedWidget,
    this.uncheckedWidget,
    this.checkedColor,
    this.uncheckedColor,
    this.disabledColor,
    this.border,
    this.borderColor,
    this.size,
    this.animationDuration,
    this.isRound = true,
    required this.onTap,
  }) : super(key: key);
  final bool? isChecked;
  final Widget? checkedWidget;
  final Widget? uncheckedWidget;
  final Color? checkedColor;
  final Color? uncheckedColor;
  final Color? disabledColor;
  final Border? border;
  final Color? borderColor;
  final double? size;
  final Function(bool?)? onTap;
  final Duration? animationDuration;

  final bool isRound;

  @override
  _RoundCheckBoxState createState() => _RoundCheckBoxState();
}

class _RoundCheckBoxState extends State<RoundCheckBox> {
  bool? isChecked;
  late Duration animationDuration;
  double? size;
  Widget? checkedWidget;
  Widget? uncheckedWidget;
  Color? checkedColor;
  Color? uncheckedColor;
  Color? disabledColor;
  late Color borderColor;

  @override
  void initState() {
    isChecked = widget.isChecked ?? false;
    animationDuration =
        widget.animationDuration ?? const Duration(milliseconds: 500);
    size = widget.size ?? 40.0;
    checkedColor = widget.checkedColor ?? Colors.green;
    uncheckedColor = widget.uncheckedColor;
    borderColor = widget.borderColor ?? Colors.grey;
    checkedWidget =
        widget.checkedWidget ?? const Icon(Icons.check, color: Colors.white);
    uncheckedWidget = widget.uncheckedWidget ?? const SizedBox.shrink();
    super.initState();
  }

  @override
  void didUpdateWidget(RoundCheckBox oldWidget) {
    uncheckedColor =
        widget.uncheckedColor ?? Theme.of(context).scaffoldBackgroundColor;
    if (isChecked != widget.isChecked) {
      isChecked = widget.isChecked ?? false;
    }
    if (animationDuration != widget.animationDuration) {
      animationDuration =
          widget.animationDuration ?? const Duration(milliseconds: 500);
    }
    if (size != widget.size) {
      size = widget.size ?? 40.0;
    }
    if (checkedColor != widget.checkedColor) {
      checkedColor = widget.checkedColor ?? Colors.green;
    }
    if (borderColor != widget.borderColor) {
      borderColor = widget.borderColor ?? Colors.grey;
    }
    if (checkedWidget != widget.checkedWidget) {
      checkedWidget =
          widget.checkedWidget ?? const Icon(Icons.check, color: Colors.white);
    }
    if (uncheckedWidget != widget.uncheckedWidget) {
      uncheckedWidget = widget.uncheckedWidget ?? const SizedBox.shrink();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.onTap != null
        ? GestureDetector(
            onTap: () {
              setState(() => isChecked = !isChecked!);
              widget.onTap!(isChecked);
            },
            child: ClipRRect(
              borderRadius: borderRadius,
              child: AnimatedContainer(
                duration: animationDuration,
                height: size,
                width: size,
                decoration: BoxDecoration(
                  color: isChecked! ? checkedColor : uncheckedColor,
                  border: widget.border ??
                      Border.all(
                        color: borderColor,
                      ),
                  borderRadius: borderRadius,
                ),
                child: isChecked! ? checkedWidget : uncheckedWidget,
              ),
            ),
          )
        : ClipRRect(
            borderRadius: borderRadius,
            child: AnimatedContainer(
              duration: animationDuration,
              height: size,
              width: size,
              decoration: BoxDecoration(
                color: widget.disabledColor ?? Theme.of(context).disabledColor,
                border: widget.border ??
                    Border.all(
                      color: widget.disabledColor ??
                          Theme.of(context).disabledColor,
                    ),
                borderRadius: borderRadius,
              ),
              child: isChecked! ? checkedWidget : uncheckedWidget,
            ),
          );
  }

  BorderRadius get borderRadius {
    if (widget.isRound) {
      return BorderRadius.circular(size! / 2);
    } else {
      return BorderRadius.zero;
    }
  }
}
