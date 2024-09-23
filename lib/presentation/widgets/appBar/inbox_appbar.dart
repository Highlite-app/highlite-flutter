import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/appBar/searchable_appbar.dart';

import '../../../core/resources/asset_constants.dart';
import '../buttons/svg_button.dart';
import 'base_appbar.dart';

class InboxAppBar extends StatefulWidget with BaseAppBar {
  final GlobalKey<ScaffoldState> scaffoldState;
  final Function(String) onSearch;
  final FocusNode focusNode;

  InboxAppBar({
    super.key,
    required this.scaffoldState,
    required this.onSearch,
    required this.focusNode,
  });

  @override
  State<InboxAppBar> createState() => _InboxAppBarState();
}

class _InboxAppBarState extends State<InboxAppBar> {
  TextEditingController controller = TextEditingController();

  final AppBar appBar = AppBar();

  @override
  Widget build(BuildContext context) {
    return SearchableAppBar(
      focusNode: widget.focusNode,
      padding: const EdgeInsets.only(left: 16, top: 10.0 , bottom: 10),
      type: SearchFieldType.curved,
      actions: [
        SvgButton(
          asset: AssetConstant.dottedVerticalIcon,
          onTap: () {
            widget.scaffoldState.currentState!.openEndDrawer();
          },
        ),
      ],
      controller: controller,
    );
  }
}
