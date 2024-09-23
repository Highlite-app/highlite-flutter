import 'package:flutter/material.dart';

enum FormProviderState {
  empty,
  submitted;
}

class FormProvider extends StatefulWidget {
  final ValueNotifier<FormProviderState> formState;
  final Widget Function(ValueNotifier<FormProviderState>) builder;
  final GlobalKey<FormState> formKey;
  const FormProvider(
      {super.key,
      required this.formKey,
      required this.builder,
      required this.formState});

  @override
  State<FormProvider> createState() => _FormProviderState();
}

class _FormProviderState extends State<FormProvider> {
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: widget.formKey,
      child: widget.builder(widget.formState),
    );
  }
}
