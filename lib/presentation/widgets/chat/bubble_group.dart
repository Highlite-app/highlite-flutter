import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';

import '../../../core/resources/spacing_theme.dart';
import 'chat_bubble.dart';


class BubbleGroup extends StatelessWidget {
  final List<ChatBubble> chatBubbles;
  const BubbleGroup({super.key, required this.chatBubbles});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            ...chatBubbles.mapIndexed((bubble, index) {
              final currentBubble = bubble;
              if (index == 0) {
                bubble.position = BubblePosition.start;
              } else if (index == chatBubbles.length - 1) {
                bubble.position = BubblePosition.end;
              } else {
                if (chatBubbles.length >= 2) {
                  bubble.position = BubblePosition.middle;
                }
              }
              return Column(
                children: [
                  currentBubble,
                  const SizedBox(height: Spacing.spacing_xx_sm),
                ],
              );
            }).toList(),
            const SizedBox(height: Spacing.spacing_md),
          ],
        ),
        const SizedBox(height: Spacing.spacing_md),
      ],
    );
  }
}
