import 'package:flutter/material.dart';

class FlagIcon extends StatelessWidget {
  final String country;
  const FlagIcon({
    super.key,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          image: DecorationImage(
            image: NetworkImage(headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            }, "https://flagsapi.com/$country/flat/64.png"),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
