import 'package:flutter/material.dart';

class BaseNavigator extends StatefulWidget {
  final Widget Function(GlobalKey<NavigatorState>) builder;
  const BaseNavigator({super.key, required this.builder});

  @override
  State<BaseNavigator> createState() => _BaseNavigatorState();
}

class _BaseNavigatorState extends State<BaseNavigator> {
  final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navKey,
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (_) => widget.builder(_navKey),
      ),
    );
  }
}
