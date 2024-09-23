import 'package:flutter/material.dart';

class PaginateResponder extends StatefulWidget {
  final VoidCallback onPaginate;
  const PaginateResponder({super.key, required this.onPaginate});

  @override
  State<PaginateResponder> createState() => _PaginateResponderState();
}

class _PaginateResponderState extends State<PaginateResponder> {
  @override
  void initState() {
    super.initState();
    widget.onPaginate();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
