import 'package:flutter/material.dart';
import '../../../../../widgets/form/form.dart';

class CompanyUploadInfoState {
  final TextEditingController aboutController;
  final TextEditingController websiteController;
  final TextEditingController ourServiceController;
  final TextEditingController minCompanySizeController;
  final TextEditingController maxCompanySizeController;
  final GlobalKey<FormState> formKey;
  final ValueNotifier<FormProviderState> formState;
  final List<String> selectedLanguages;
  final bool onNextAbout;

  CompanyUploadInfoState({
    TextEditingController? aboutController,
    GlobalKey<FormState>? formKey,
    ValueNotifier<FormProviderState>? formState,
    this.selectedLanguages = const <String>[],
    this.onNextAbout = false,
    TextEditingController? websiteController,
    TextEditingController? ourServiceController,
    TextEditingController? minCompanySizeController,
    TextEditingController? maxCompanySizeController,
  })  : aboutController = aboutController ?? TextEditingController(),
        formState = formState ?? ValueNotifier(FormProviderState.empty),
        formKey = formKey ?? GlobalKey<FormState>(),
        websiteController = websiteController ?? TextEditingController(),
        ourServiceController = ourServiceController ?? TextEditingController(),
        minCompanySizeController = minCompanySizeController ?? TextEditingController(),
        maxCompanySizeController = maxCompanySizeController ?? TextEditingController();

  CompanyUploadInfoState copyWith({
    TextEditingController? aboutController,
    GlobalKey<FormState>? formKey,
    ValueNotifier<FormProviderState>? formState,
    List<String>? selectedLanguages,
    bool? onNextAbout,
    TextEditingController? websiteController,
    TextEditingController? ourServiceController,
    TextEditingController? minCompanySizeController,
    TextEditingController? maxCompanySizeController,
  }) {
    return CompanyUploadInfoState(
      aboutController: aboutController ?? this.aboutController,
      formKey: formKey ?? this.formKey,
      formState: formState ?? this.formState,
      selectedLanguages: selectedLanguages ?? this.selectedLanguages,
      onNextAbout: onNextAbout ?? this.onNextAbout,
      websiteController: websiteController ?? this.websiteController,
      ourServiceController: ourServiceController ?? this.ourServiceController,
      minCompanySizeController: minCompanySizeController ?? this.minCompanySizeController,
      maxCompanySizeController: maxCompanySizeController ?? this.maxCompanySizeController,
    );
  }
}
