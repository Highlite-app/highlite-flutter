import 'package:flutter/material.dart';

class TopNotch extends StatelessWidget {
  final double width;
  final double height;
  const TopNotch({
    super.key,
    this.width = 30,
    this.height = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
        ),
      ],
    );
  }
}
