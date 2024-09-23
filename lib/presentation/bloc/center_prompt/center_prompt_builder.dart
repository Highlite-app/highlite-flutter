import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/injection_container.dart';
import 'center_prompt_bloc.dart';
import 'center_prompt_state.dart';

final centerPrompt = sl.get<CenterPromptBloc>();

class CenterPromptBuilderWidget extends StatelessWidget {
  final Widget Function(BuildContext, CenterPromptState) builder;
  const CenterPromptBuilderWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CenterPromptBloc, CenterPromptState>(builder: builder);
  }
}

class CenterPromptProviderWidget extends StatelessWidget {
  final Widget child;
  const CenterPromptProviderWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CenterPromptBloc>(
      lazy: true,
      create: (ctx) {
        return centerPrompt;
      },
      child: child,
    );
  }
}
