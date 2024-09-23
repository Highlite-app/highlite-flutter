import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import '../../../core/resources/color_constants.dart';
import '../animated/sliding_opacity.dart';
import '../utils/initial.dart';

class EmojiKeyboard extends StatefulWidget {
  final TextEditingController controller;
  const EmojiKeyboard({
    super.key,
    required this.controller,
  });

  @override
  State<EmojiKeyboard> createState() => _EmojiKeyboardState();
}

class _EmojiKeyboardState extends State<EmojiKeyboard> {
  bool visible = false;
  @override
  void initState() {
    super.initState();
    InitialStater.init().then((value) {
      setState(() {
        visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlidingOpacity(
      visible: visible,
      duration: 230,
      child: Offstage(
        offstage: false,
        child: SizedBox(
          height: 300,
          child: EmojiPicker(
            onEmojiSelected: (Category? category, Emoji emoji) {
              setState(() {});
            },
            onBackspacePressed: () {
              setState(() {});
            },
            textEditingController: widget.controller,
            config:  Config(
              columns: 9,
              emojiSizeMax: 32,
              verticalSpacing: 5,
              horizontalSpacing: 5,
              gridPadding: const EdgeInsets.all(15),
              initCategory: Category.RECENT,
              bgColor: ColorConstant.shade00,
              indicatorColor: ColorConstant.primary500,
              iconColor: ColorConstant.neutral500,
              iconColorSelected: ColorConstant.primary500,
              backspaceColor: ColorConstant.primary500,
              skinToneDialogBgColor: ColorConstant.shade00,
              skinToneIndicatorColor: ColorConstant.neutral100,
              enableSkinTones: true,
              recentTabBehavior: RecentTabBehavior.RECENT,
              recentsLimit: 28,
              noRecents: const Text(
                'No Recents',
                style: TextStyle(fontSize: 20, color: Colors.black26),
                textAlign: TextAlign.center,
              ),
              loadingIndicator: const SizedBox.shrink(),
              tabIndicatorAnimDuration: kTabScrollDuration,
              categoryIcons: const CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL,
            ),
          ),
        ),
      ),
    );
  }
}
