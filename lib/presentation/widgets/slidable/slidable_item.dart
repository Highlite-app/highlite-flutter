import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';

enum SlidableDirection {
  start,
  end,
  both;
}

class SlidableActionItem {
  final String icon;
  final String title;
  final BorderRadius? borderRadius;
  final Color background;
  final Color foreground;
  const SlidableActionItem({
    required this.icon,
    required this.title,
    required this.background,
    this.borderRadius,
    required this.foreground,
  });
}

class SlidableItem extends StatelessWidget {
  final String id;
  final Widget child;
  final List<SlidableActionItem> actions;
  final SlidableDirection direction;
  final Function(String) onSelect;
  const SlidableItem({
    super.key,
    required this.id,
    required this.child,
    required this.actions,
    this.direction = SlidableDirection.end,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final pane = ActionPane(
      extentRatio: actions.length > 1 ? actions.length * 0.25 : 0.24,
      motion: const ScrollMotion(),
      children: actions
          .map(
            (action) => _slidableAction(action),
          )
          .toList(),
    );
    return Slidable(
      key: ValueKey(id),
      endActionPane: direction == SlidableDirection.end ||
              direction == SlidableDirection.both
          ? pane
          : null,
      startActionPane: direction == SlidableDirection.start ||
              direction == SlidableDirection.both
          ? pane
          : null,
      child: child,
    );
  }

  CustomSlidableAction _slidableAction(SlidableActionItem action) {
    return CustomSlidableAction(
      onPressed: (context) {
        onSelect(action.title);
      },
      backgroundColor: action.background,
      borderRadius: action.borderRadius ??
          const BorderRadius.only(
              topLeft: Radius.circular(0), bottomLeft: Radius.circular(0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgAsset(
            asset: action.icon,
            size: 24.0,
            color: action.foreground,
          ),
          Text(
            action.title,
            style: BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p4,
              color: action.foreground,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
