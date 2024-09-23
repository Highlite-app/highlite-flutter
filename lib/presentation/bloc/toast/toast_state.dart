import 'package:flutter/material.dart';

import '../../widgets/toaster/toast_alert.dart';


class ToasterState {
  ToasterState({
    this.displayedText = "",
    this.displayedTitle = "",
    this.icon = "",
    this.link = "",
    this.linkAction,
    this.state = ToastState.warning,
    this.disposed = true,
    this.visible = false,
    this.animDuration = const Duration(milliseconds: 300),
  });
  final String displayedText;
  final String displayedTitle;
  final String icon;
  final String link;
  final VoidCallback? linkAction;
  final ToastState state;
  final bool disposed;
  final bool visible;
  final Duration animDuration;
  ToasterState copyWith({
    String? displayedText,
    String? displayedTitle,
    String? icon,
    String? link,
    VoidCallback? linkAction,
    ToastState? state,
    bool? disposed,
    bool? visible,
    Duration? animDuration,
  }) =>
      ToasterState(
        displayedText: displayedText ?? this.displayedText,
        displayedTitle: displayedTitle ?? this.displayedTitle,
        icon: icon ?? this.icon,
        state: state ?? this.state,
        link: link ?? this.link,
        linkAction: linkAction ?? this.linkAction,
        disposed: disposed ?? this.disposed,
        visible: visible ?? this.visible,
        animDuration: animDuration ?? this.animDuration,
      );
}
