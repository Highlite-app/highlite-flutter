import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../utils/initial.dart';

class FloatingCard extends StatelessWidget {
  final Widget child;
  final double height;
  final bool animated;
  const FloatingCard({
    super.key,
    required this.child,
    required this.height,
    this.animated = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: CardContainer(
        height: height,
        animated: animated,
        child: child,
      ),
    );
  }
}

class CardContainer extends StatefulWidget {
  final Widget child;
  final double height;
  final bool animated;
  const CardContainer({
    super.key,
    required this.child,
    required this.height,
    this.animated = false,
  });

  @override
  State<CardContainer> createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {
  bool visible = false;
  @override
  void initState() {
    super.initState();
    InitialStater.init().then((value) {
      setState(() {
        visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: const Duration(milliseconds: 300),
      child: Wrap(
        children: [
          PhysicalModel(
            elevation: 1,
            color: ColorConstant.shade00,
            borderRadius: BorderRadius.circular(12.0),
            clipBehavior: Clip.hardEdge,
            child: Container(
              height: widget.height,
              padding: const EdgeInsets.all(16.0),
              decoration:  const BoxDecoration(
                color: ColorConstant.shade00,
              ),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
