import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/appBar/base_appbar.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/buttons/svg_button.dart';

import '../../../../widgets/appBar/searchable_appbar.dart';
import '../../../../widgets/buttons/text_button.dart';

class SearchAppBar extends StatefulWidget with BaseAppBar {
  final TextEditingController controller;
  final VoidCallback onTapFilter ;
  final Function(String?)? onTextChange;

  SearchAppBar({
    super.key,
    required this.onTapFilter ,
    this.onTextChange ,
    required this.controller,
  });

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: SearchableAppBar(
        focusNode: FocusNode(),
        controller: widget.controller,
        onTextChange:widget.onTextChange ,
        actions: [
          SvgButton(asset: AssetConstant.filterIcon,color: ColorConstant.neutral500, onTap:widget.onTapFilter)

        ],
      ),
    );
  }
}
