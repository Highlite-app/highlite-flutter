import 'package:flutter/material.dart';

class FeedContentContainer extends StatelessWidget {
  final Widget child;
  const FeedContentContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: child,
      ),
    );
  }
}
