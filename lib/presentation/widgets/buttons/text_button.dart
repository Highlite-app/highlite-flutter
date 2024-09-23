import 'package:flutter/material.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';

class SecondaryTextButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color color;
  const SecondaryTextButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    Widget button = Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 8.0),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
          style: BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p2,
            color: color,
          ),
        ),
      ),
    );
    return button;
  }
}
