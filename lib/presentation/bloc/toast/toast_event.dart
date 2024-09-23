import 'package:flutter/material.dart';

import '../../widgets/toaster/toast_alert.dart';

abstract class ToasterEvent {
  const ToasterEvent();
}

class ShowToastEvent extends ToasterEvent {
  const ShowToastEvent({
    required this.text,
    this.title,
    this.icon,
    this.link,
    this.linkAction,
    required this.state,
    required this.duration,
    this.animDuration,
  });
  final String? title;
  final String text;
  final String? icon;
  final String? link;
  final VoidCallback? linkAction;
  final ToastState state;
  final Duration duration;
  final Duration? animDuration;
}
