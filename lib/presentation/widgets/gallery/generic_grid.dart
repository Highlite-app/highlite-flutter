import 'package:flutter/material.dart';

class GenericGrid<Data> extends StatelessWidget {
  final bool isAddEnabled;
  final Widget? addWidget;
  final double horizontalPadding;
  final double verticalPadding;
  final double spacing;
  final int perColumn;
  final List<Data> items;
  final double? maxHeight;
  final Function(BuildContext, Data, int) itemBuilder;
  final VoidCallback? onAdd;
  const GenericGrid({
    super.key,
    this.isAddEnabled = false,
    this.addWidget,
    this.horizontalPadding = 4.0,
    this.verticalPadding = 0,
    this.spacing = 5.0,
    this.perColumn = 3,
    this.maxHeight,
    required this.items,
    required this.itemBuilder,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    SliverGridDelegateWithFixedCrossAxisCount delegate =
        SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
      crossAxisCount: perColumn,
    );
    if (maxHeight != null) {
      delegate = SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        crossAxisCount: perColumn,
        mainAxisExtent: maxHeight!,
      );
    }
    return SliverPadding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      sliver: SliverGrid.builder(
        gridDelegate: delegate,
        itemCount: isAddEnabled ? items.length + 1 : items.length,
        itemBuilder: (context, index) {
          if (index == items.length && this.addWidget != null) {
            return addWidget;
          }
          return itemBuilder(context, items[index], index);
        },
      ),
    );
  }
}
