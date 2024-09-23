import 'package:flutter/material.dart';

import '../../../app.dart';

class HomeNavigator extends StatelessWidget {
  final Widget Function(GlobalKey<NavigatorState>) builder;
  const HomeNavigator({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: dashboardNavKey,
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (_) => builder(dashboardNavKey),
      ),
    );
  }
}
