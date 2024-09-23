import 'package:flutter/material.dart';

import '../../../../../../data/models/apis/dashboard/cadidate/upload/video/mux_response.dart';
import '../../../../../widgets/form/form.dart';

class UploadCompanyState {
  final String thumbnailUrl;
  final TextEditingController descriptionController;
  final TextEditingController locationController;
  final TextEditingController positionController;
  final TextEditingController salaryController;
  final ValueNotifier<FormProviderState> formProvider;
  final MuxResponse? muxResponse  ;
  final GlobalKey<FormState> formState;
  final List<String> tools;
  final List<String> skills;
  final String thumbnailWidth;
  final String thumbnailHeight;

  UploadCompanyState({
    String? thumbnailUrl,
    TextEditingController? descriptionController,
    TextEditingController? locationController,
    TextEditingController? positionController,
    TextEditingController? salaryController,
    ValueNotifier<FormProviderState>? formProvider,
    GlobalKey<FormState>? formState,
    List<String>? tools,
    List<String>? skills,
    this.thumbnailWidth = '125',
    this.thumbnailHeight = '150',
    this.muxResponse
  })  : descriptionController =
            descriptionController ?? TextEditingController(),
        locationController = locationController ?? TextEditingController(),
        positionController = positionController ?? TextEditingController(),
        salaryController = salaryController ?? TextEditingController(),
        formProvider = formProvider ?? ValueNotifier(FormProviderState.empty),
        formState = formState ?? GlobalKey<FormState>(),
        thumbnailUrl = thumbnailUrl ?? '',
        tools = tools ?? <String>[],
        skills = skills ?? <String>[];

  // copyWith method for updating specific fields
  UploadCompanyState copyWith({
    String? thumbnailUrl,
    MuxResponse? muxResponse ,
    TextEditingController? descriptionController,
    TextEditingController? locationController,
    TextEditingController? positionController,
    TextEditingController? salaryController,
    ValueNotifier<FormProviderState>? formProvider,
    GlobalKey<FormState>? formState,
    List<String>? tools,
    List<String>? skills,
    String? thumbnailWidth,
    String? thumbnailHeight,
  }) {
    return UploadCompanyState(
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      muxResponse:  muxResponse ?? this.muxResponse,
      descriptionController:
          descriptionController ?? this.descriptionController,
      locationController: locationController ?? this.locationController,
      positionController: positionController ?? this.positionController,
      salaryController: salaryController ?? this.salaryController,
      formProvider: formProvider ?? this.formProvider,
      formState: formState ?? this.formState,
      tools: tools ?? this.tools,
      skills: skills ?? this.skills,
      thumbnailWidth: thumbnailWidth ?? this.thumbnailWidth,
      thumbnailHeight: thumbnailHeight ?? this.thumbnailHeight,
    );
  }
}
