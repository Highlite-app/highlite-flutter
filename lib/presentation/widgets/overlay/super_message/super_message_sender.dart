import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../../app.dart';
import '../../../../core/resources/spacing_theme.dart';
import '../../../../core/resources/typography_theme.dart';
import '../../chat/chat_input.dart';
import '../../chat/chat_responder.dart';
import '../../constants/text_style.dart';
import '../../form/dropdown_control.dart';
import '../../modal/multiple_selection_modal.dart';
import '../../modal/top_notch.dart';
import '../../svg/svg_asset.dart';

class SuperMessageSendResponse {
  final IDValue? idValue;
  final String message;
  const SuperMessageSendResponse({this.idValue, required this.message});
}

class SuperMessageSenderOverlay extends StatefulWidget {
  final List<IDValue> idValues;
  const SuperMessageSenderOverlay({
    super.key,
    this.idValues = const [],
  });

  @override
  State<SuperMessageSenderOverlay> createState() =>
      _SuperMessageSenderOverlayState();

  static Future<SuperMessageSendResponse?> showSuperMessage(
      List<IDValue> idValues) async {
    return showModalBottomSheet<SuperMessageSendResponse>(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Spacing.spacing_big),
          topRight: Radius.circular(Spacing.spacing_big),
        ),
      ),
      backgroundColor: ColorConstant.transparent,
      clipBehavior: Clip.none,
      context: globalNavKey.currentContext!,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SuperMessageSenderOverlay(
            idValues: idValues,
          ),
        );
      },
    );
  }
}

class _SuperMessageSenderOverlayState extends State<SuperMessageSenderOverlay> {
  FocusNode node = FocusNode();
  IDValue? selected;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      node.requestFocus();
      setState(() {
        if (widget.idValues.isNotEmpty) {
          selected = widget.idValues.first;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 30),
          decoration: const BoxDecoration(
            color: ColorConstant.shade00,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Spacing.spacing_big),
              topRight: Radius.circular(Spacing.spacing_big),
            ),
          ),
          child: Wrap(
            children: [
              SuperMessageContents(
                name: "Srijan",
                node: node,
                selected: selected,
                items: widget.idValues,
                onChangeSelection: (value) {
                  setState(() {
                    selected = value;
                  });
                },
                sendMessage: (message) {
                  context.navigator.pop(
                    SuperMessageSendResponse(
                        idValue: selected, message: message),
                  );
                },
              ),
            ],
          ),
        ),
         Positioned(
          top: 23,
          left: 0,
          right: 0,
           child: TopNotch(),
        ),
         Positioned(
          top: -18,
          left: 0,
          right: 0,
          child: SvgAsset(asset:AssetConstant.lightningInitialIcon),
        ),
      ],
    );
  }
}

class SuperMessageContents extends StatelessWidget {
  final String name;
  final FocusNode node;
  final IDValue? selected;
  final List<IDValue> items;
  final Function(IDValue) onChangeSelection;
  final Function(String) sendMessage;
  const SuperMessageContents({
    super.key,
    required this.name,
    required this.node,
    this.selected,
    required this.items,
    required this.onChangeSelection,
    required this.sendMessage,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: [
            if (selected != null)
              DropdownControl(
                title: "Select your job post",
                selected: selected!,
                items: items,
                onChangeSelection: onChangeSelection,
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Super Message",
                    style: BaseTextStyle(
                      fontSize: TypographyTheme.heading_H5,
                      fontWeight: FontWeight.w600,
                      color: ColorConstant.neutral900,
                    ),
                  ),
                  Text(
                    "Your message will be sent to $name",
                    style:  BaseTextStyle(
                      fontSize: TypographyTheme.paragraph_p3,
                      fontWeight: FontWeight.w400,
                      color: ColorConstant.neutral700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Column(
              children: [
                ChatInput(
                  placeholderText: "Type a message...",
                  sendMessage: sendMessage,
                  initialValue: "",
                  sendAttachments: (attachment) {},
                  sendFile: (file) {},
                  focusNode: node,
                  keyboardType: TextInputType.text,
                  inputType: InputType.normal,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
