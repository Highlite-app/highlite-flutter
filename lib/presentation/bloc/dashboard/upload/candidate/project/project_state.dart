import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../../../../../widgets/form/form.dart';

class UploadProjectState {
  final TextEditingController projectTitleController;
  final TextEditingController clientDetailsController;
  final TextEditingController projectDetailsController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final TextEditingController sizeOfTeamController;
  final TextEditingController roleInProjectController;
  final TextEditingController roleDescriptionController;
  final TextEditingController skillController;
  final TextEditingController toolController;
  final bool showMoreDetails;
  final String projectStatus;
  final GlobalKey<FormState> formKey;
  final ValueNotifier<FormProviderState> formProvider;
  final GlobalKey<FormState> addDetailsFormKey;
  final ValueNotifier<FormProviderState> addDetailsFormProvider;

  // Store data from API or Local Database
  final List<String> employmentType;
  final List<String> taggedProject;
  final List<String> projectStatusList;
  final List<String> projectSite;

  UploadProjectState({
    TextEditingController? projectTitleController,
    TextEditingController? clientDetailsController,
    TextEditingController? projectDetailsController,
    TextEditingController? startDateController,
    TextEditingController? endDateController,
    TextEditingController? sizeOfTeamController,
    TextEditingController? roleInProjectController,
    TextEditingController? roleDescriptionController,
    TextEditingController? skillController,
    TextEditingController? toolController ,
    this.projectStatus = '',
    this.showMoreDetails = false,
    GlobalKey<FormState>? formKey,
    ValueNotifier<FormProviderState>? formProvider,
    GlobalKey<FormState>? addDetailsFormKey,
    ValueNotifier<FormProviderState>? addDetailsFormProvider,
    this.employmentType = const ["Full-time", "Part-time", "Contractual"],
    this.taggedProject = const ["UI UX and Graphic Designer", "UG-Civil"],
    this.projectSite = const ["Off site", "On site"],
    this.projectStatusList = const ["In progress", "Finished"],
  })  : projectTitleController =
      projectTitleController ?? TextEditingController(),
        clientDetailsController =
            clientDetailsController ?? TextEditingController(),
        projectDetailsController =
            projectDetailsController ?? TextEditingController(),
        startDateController = startDateController ?? TextEditingController(),
        endDateController = endDateController ?? TextEditingController(),
        sizeOfTeamController = sizeOfTeamController ?? TextEditingController(),
        roleInProjectController =
            roleInProjectController ?? TextEditingController(),
        roleDescriptionController =
            roleDescriptionController ?? TextEditingController(),
        skillController = skillController ?? TextEditingController(),
        formKey = formKey ?? GlobalKey<FormState>(),
        formProvider = formProvider ??
            ValueNotifier<FormProviderState>(FormProviderState.empty),
        addDetailsFormKey = addDetailsFormKey ?? GlobalKey<FormState>(),
        toolController = toolController ?? TextEditingController(),
        addDetailsFormProvider = addDetailsFormProvider ??
            ValueNotifier<FormProviderState>(FormProviderState.empty);

  UploadProjectState copyWith({
    TextEditingController? projectTitleController,
    TextEditingController? clientDetailsController,
    TextEditingController? projectDetailsController,
    TextEditingController? startDateController,
    TextEditingController? endDateController,
    TextEditingController? sizeOfTeamController,
    TextEditingController? roleInProjectController,
    TextEditingController? roleDescriptionController,
    TextEditingController? skillController,
    TextEditingController? toolController ,
    bool? showMoreDetails,
    String? projectStatus,
    GlobalKey<FormState>? formKey,
    ValueNotifier<FormProviderState>? formProvider,
    GlobalKey<FormState>? addDetailsFormKey,
    ValueNotifier<FormProviderState>? addDetailsFormProvider,
    List<String>? employmentType,
    List<String>? taggedProject,
    List<String>? projectStatusList,
    List<String>? projectSite,
  }) {
    return UploadProjectState(
      projectTitleController:
      projectTitleController ?? this.projectTitleController,
      clientDetailsController:
      clientDetailsController ?? this.clientDetailsController,
      projectDetailsController:
      projectDetailsController ?? this.projectDetailsController,
      startDateController: startDateController ?? this.startDateController,
      endDateController: endDateController ?? this.endDateController,
      sizeOfTeamController: sizeOfTeamController ?? this.sizeOfTeamController,
      roleInProjectController:
      roleInProjectController ?? this.roleInProjectController,
      roleDescriptionController:
      roleDescriptionController ?? this.roleDescriptionController,
      skillController: skillController ?? this.skillController,
      toolController:  toolController ?? this.toolController,
      showMoreDetails: showMoreDetails ?? this.showMoreDetails,
      projectStatus: projectStatus ?? this.projectStatus,
      formKey: formKey ?? this.formKey,
      formProvider: formProvider ?? this.formProvider,
      addDetailsFormKey: addDetailsFormKey ?? this.addDetailsFormKey,
      addDetailsFormProvider: addDetailsFormProvider ?? this.addDetailsFormProvider,
      employmentType: employmentType ?? this.employmentType,
      taggedProject: taggedProject ?? this.taggedProject,
      projectStatusList: projectStatusList ?? this.projectStatusList,
      projectSite: projectSite ?? this.projectSite,
    );
  }
}
