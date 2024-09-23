import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../widgets/form/form.dart';

class CandidateUploadAboutState {
  final TextEditingController aboutController;
  final GlobalKey<FormState> formKey;
  final ValueNotifier<FormProviderState> formState ;
  final List<String> selectedLanguages ;
  final bool onNextAbout;

  CandidateUploadAboutState({
    TextEditingController? aboutController,
    GlobalKey<FormState>? formKey,
    ValueNotifier<FormProviderState>? formState ,
     this.selectedLanguages = const <String>[] ,
    this.onNextAbout = false,
  })  : this.aboutController = aboutController ?? TextEditingController(),
        formState = formState ?? ValueNotifier(FormProviderState.empty) ,
        formKey = formKey ?? GlobalKey<FormState>();

  CandidateUploadAboutState copyWith({
    TextEditingController? aboutController,
    GlobalKey<FormState>? formKey,
    ValueNotifier<FormProviderState>? formState ,
    List<String>? selectedLanguages ,
    final bool? onNextAbout,
  }) =>
      CandidateUploadAboutState(
          aboutController: aboutController ?? this.aboutController,
          formKey: formKey ?? this.formKey,
          formState: formState ?? this.formState,
          selectedLanguages:  selectedLanguages ?? this.selectedLanguages,
          onNextAbout: onNextAbout ?? this.onNextAbout);
}
