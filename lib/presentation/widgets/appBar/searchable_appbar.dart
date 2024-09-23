import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';


import '../form/search_field.dart';
import '../navigation/back_button.dart';


enum SearchFieldType {
  normal,
  curved;
}

class SearchableAppBar extends StatelessWidget {
  final SearchFieldType type;
  final List<Widget> actions;
  final FocusNode focusNode;
  final Function(String?)? onTextChange;

  final TextEditingController controller;
  final EdgeInsets padding;
  const SearchableAppBar({
    super.key,
    this.type = SearchFieldType.normal,
    this.actions = const [],
    required this.controller,
    this.onTextChange ,
    required this.focusNode,
    this.padding = const EdgeInsets.only(left: 16.0, top: 10.0,),
  });

  @override
  Widget build(BuildContext context) {
    final navigator = context.navigator;
    return AppBar(
      automaticallyImplyLeading: false,
      leading: navigator.canPop()
          ? BackNavigationButton(navigator: navigator)
          : null,
      centerTitle: false,
      titleSpacing: 2,
      title: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(
              focusNode: focusNode,
              controller: controller,
              borderRadius: type == SearchFieldType.normal ? 8.0 : 100.0,
              onTextChanged: onTextChange,
            ),
          ],
        ),
      ),
      actions: actions,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
