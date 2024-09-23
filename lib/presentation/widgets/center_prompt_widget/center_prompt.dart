import 'package:flutter/material.dart';

import '../../bloc/center_prompt/center_prompt_builder.dart';
import '../svg/svg_asset.dart';

class CenterPrompt extends StatelessWidget {
  const CenterPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return CenterPromptProviderWidget(
      child: CenterPromptBuilderWidget(
        builder: (context, state) {
          if (state.disposed) {
            return Container();
          }
          double scale = 1.5;
          if (state.visible) {
            scale = 1.0;
          }
          if (state.visibleIn) {
            scale = 1.1;
          }
          if (state.visibleOut) {
            scale = 0.5;
          }
          return Center(
            child: AnimatedScale(
              scale: scale,
              duration: state.animDuration,
              child: AnimatedOpacity(
                opacity: state.visible ? 1 : 0,
                duration: state.animDuration,
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: SvgAsset(
                    asset: state.asset,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
