import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';

import '../../../../../widgets/navigation/navigated_page.dart';

class ProfileEditorPage extends StatelessWidget {
  final List<Widget> children;
  const ProfileEditorPage({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return NavigatedPage(
      includesBorder: true,
      title: TranslationKeys.editProfile,
      backgroundColor: ColorConstant.neutral50,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Wrap(
          spacing: 20.0,
          runSpacing: 20.0,
          children: children,
        ),
      ),
    );
  } 
}
