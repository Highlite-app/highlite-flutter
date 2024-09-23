import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

class ToastContainer extends StatefulWidget {
  final Widget body;
  final bool visible;
  final Animation<Offset>? offsetAnimation;
  const ToastContainer({
    super.key,
    required this.body,
    required this.visible,
    this.offsetAnimation,
  });

  @override
  State<ToastContainer> createState() => _ToastContainerState();
}

class _ToastContainerState extends State<ToastContainer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          AnimatedSlide(
            offset: widget.visible ? Offset.zero : Offset(Offset.zero.dx, -1),
            duration: const Duration(milliseconds: 300),
            child: AnimatedOpacity(
              opacity: widget.visible ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConstant.shade00,
                    border: Border.all(color: ColorConstant.neutral100, width: 1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: widget.body,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
