import 'package:flutter/material.dart';

class DrawerContainer extends StatelessWidget {
  final Widget child;
  final Widget? bottomChild;
  const DrawerContainer({
    super.key,
    required this.child,
    this.bottomChild,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).viewPadding.top;
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: height),
            child: child,
          ),
          if (bottomChild != null) bottomChild!,
        ],
      ),
    );
  }
}
