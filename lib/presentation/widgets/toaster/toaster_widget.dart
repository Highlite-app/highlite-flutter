import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/toast/toast_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/toast/toast_state.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/toaster/toast_alert.dart';

class ToasterWidget extends StatelessWidget {
  const ToasterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToasterBloc>(
      lazy: true,
      create: (context)=>toaster,
      child: BlocBuilder<ToasterBloc , ToasterState>(builder: (context, state) {
        if (state.disposed) {
          return Container();
        }
        return ToastAlert(
          title: state.displayedTitle,
          text: state.displayedText,
          icon: state.icon,
          state: state.state,
          link: state.link,
          linkAction: state.linkAction,
          visible: state.visible,
          animDuration: state.animDuration,
        );
      }),
    );
  }
}
