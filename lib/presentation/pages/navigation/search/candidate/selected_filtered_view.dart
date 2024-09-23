import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../../widgets/chip/filtered_chip.dart';

class SelectedFiltered extends StatelessWidget {
  final List<String> selectedFilters;

  SelectedFiltered({required this.selectedFilters});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8.0,),
        Container(width: double.infinity , height: 1 , color: ColorConstant.neutral300),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 8,
                  children: selectedFilters.map((filter) {
                    return CustomFilterChip(label: filter, isSelected: false, onSelected: (bool value) {  } ,  );
                  }).toList(),
                ),
              ),
             Container(width: 2,height: 50, color: ColorConstant.neutral200, ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Text('Filter (${selectedFilters.length})'),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(width: double.infinity , height: 1 , color: ColorConstant.neutral300),
      ],
    );
  }
}
