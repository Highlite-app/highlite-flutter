import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../../widgets/navigation/base_navigator.dart';
import '../../../../widgets/search/sections/filtered_bottom_sheet.dart';
import '../appbar/search_appbar.dart';

class BaseSearchPage extends StatelessWidget {
  final Function(String) onSearch;
  final Widget initialSearch;
  final Widget currentSearch;

  final String searchQuery;
  final VoidCallback onTapFilter;

  final TextEditingController controller;

  const BaseSearchPage({
    super.key,
    required this.onSearch,
    required this.currentSearch,
    required this.initialSearch,
    required this.searchQuery,
    required this.onTapFilter,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BaseNavigator(
      builder: (navKey) => Scaffold(
          backgroundColor: ColorConstant.shade00,
          appBar: SearchAppBar(
            onTextChange: (query) {
              if(query!=null && query.isNotEmpty) {
                onSearch(query) ;
              }else {
                onSearch('');
              }
            },
            onTapFilter: onTapFilter,
            controller: controller,
          ),
          body: searchQuery == "" ? initialSearch : currentSearch),
    );
  }
}

void showFilter(BuildContext context,
    {required Function() onTapFilter, required Function() onResetFilter}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: FilterBottomSheet(
            onTapFilter: onTapFilter,
            onResetFilter: onResetFilter,
          )));
}
