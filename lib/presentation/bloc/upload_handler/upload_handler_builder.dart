import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/injection_container.dart';
import 'upload_handler_bloc.dart';
import 'upload_handler_state.dart';

final uploadHandler = sl.get<UploadHandlerBloc>();

class UploadHandlerBuilderWidget extends StatelessWidget {
  final Widget Function(BuildContext, UploadHandlerState) builder;
  const UploadHandlerBuilderWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadHandlerBloc, UploadHandlerState>(builder: builder);
  }
}

class UploadHandlerProviderWidget extends StatelessWidget {
  final Widget child;
  const UploadHandlerProviderWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UploadHandlerBloc>(
      lazy: true,
      create: (ctx) {
        return uploadHandler;
      },
      child: child,
    );
  }
}
