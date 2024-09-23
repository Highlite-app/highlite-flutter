import 'dart:io';

import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/candidate/resume%20/upload%20_resume.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/company/upload%20information/upload_information.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/dialogs/upload_dialog.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/navigation/base_navigator.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/text_field/location_field.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/resources/asset_constants.dart';
import '../../../../../core/resources/color_constants.dart';
import '../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../core/resources/typography_theme.dart';
import '../../../../../data/models/onboarding/file_model.dart';
import '../../../../widgets/buttons/primary_button.dart';
import '../../../../widgets/chip/preselected_chip_with_heading.dart';
import '../../../../widgets/constants/text_style.dart';
import '../../../../widgets/form/form.dart';
import '../../../../widgets/form/tags_selection.dart';
import '../../../../widgets/indicator/upload_indicator.dart';
import '../../../../widgets/sectionable/heading.dart';
import '../../../../widgets/text_field/titled_text_field.dart';
import '../../../../widgets/utils/file.dart';
import '../../../../widgets/utils/thumnail_generator.dart';

class UploadCompany extends StatefulWidget {
  const UploadCompany({super.key});

  @override
  State<UploadCompany> createState() => _UploadCompanyState();
}

class _UploadCompanyState extends State<UploadCompany> {
  bool isVideo = false;
  FileModel? pickVideo;
  String thumbnailUrl = '';
  final TextEditingController _descriptionController = TextEditingController();
  final ValueNotifier<FormProviderState> formProvider =
      ValueNotifier(FormProviderState.empty);
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final TextEditingController locationController = TextEditingController();

  final TextEditingController positionController = TextEditingController();

  final TextEditingController salaryController = TextEditingController();

  List<String> tools = [];
  List<String> skills = [];
  String salary = '';

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   UploadDialog.showUploadDialog(context: context,
    //       onTapUploadVideo: (){},
    //       onTapUploadResume: (){}) ;
    // });
    return BaseNavigator(
      builder: (navKey) => Scaffold(
        backgroundColor: isVideo ? Colors.white : Colors.black,
        appBar: isVideo
            ? AppBar(
                title: Text(
                  'New Job Post',
                  style: BaseTextStyle(
                      color: ColorConstant.shade100,
                      fontSize: TypographyTheme.paragraph_p3),
                ),
                centerTitle: true,
              )
            : AppBar(backgroundColor: isVideo ? Colors.white : Colors.black),
        body:
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: FormProvider(
              formState: formProvider,
              formKey: formState,
              builder: (formProvider) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isVideo) ...[
                     const SizedBox(height: 16),
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Expanded(
                           flex: 2,
                           child: TextField(
                             controller: _descriptionController,
                             style: BaseTextStyle(
                               color: ColorConstant.neutral900,
                               fontSize: TypographyTheme.paragraph_p3,
                               fontWeight: FontWeight.w500,
                             ),
                             maxLines: 8,
                             decoration:  InputDecoration(
                               enabledBorder: InputBorder.none,
                               focusedErrorBorder: InputBorder.none,
                               hintText: 'Add job description...',
                               hintStyle: BaseTextStyle(
                                 color: ColorConstant.neutral500 ,
                                 fontSize: TypographyTheme.paragraph_p3,
                                 fontWeight: FontWeight.w600,
                               ),
                               border: InputBorder.none,
                             ),
                           ),
                         ),
                         const SizedBox(width: 24.0),
                         Expanded(
                           flex: 1,
                           child: Stack(
                             children: [
                               thumbnailUrl.isNotEmpty
                                   ? ClipRRect(
                                 borderRadius: BorderRadius.circular(6),
                                 child: Image.file(
                                   File(thumbnailUrl),
                                   width: 125,
                                   height: 150,
                                   fit: BoxFit.cover,
                                 ),
                               )
                                   : Container(
                                 width: 125,
                                 height: 150,
                                 decoration: BoxDecoration(
                                     color: Colors.grey[300],
                                   borderRadius:  BorderRadius.circular(6)
                                 ),

                                 child: const Center(
                                     child: Text('Edit cover')),
                               ),
                               // Positioned(
                               //   bottom: 8,
                               //   right: 25,
                               //   child: Container(
                               //     color: Colors.black54,
                               //     padding: const EdgeInsets.symmetric(
                               //         vertical: 4, horizontal: 8),
                               //     child: const Text(
                               //       'Edit cover',
                               //       style: TextStyle(
                               //         color: Colors.white,
                               //       ),
                               //     ),
                               //   ),
                               // ),
                             ],
                           ),
                         ),
                       ],
                     ),
                      const LocationField(
                       title: 'Location',
                       submitText: ' Add Location') ,
                     const SizedBox(height: 16.0),
                     TitledTextField(
                       textController: positionController,
                       title: 'Position',
                       hinText: 'Eg : UI/UX Designer',
                     ),
                     const SizedBox(height: 16.0),
                     Heading(
                       title: 'Skills',
                       child: TagsSelection(
                         title: 'Skills',
                         selection: skills,
                         maxCount: 3,
                         errorMessage: 'Cannot add more skills',
                         placeholderText: 'Skills',
                         onSelect: (selectedSkills) {
                           setState(() {
                             skills = selectedSkills;
                           });
                         },
                       ),
                     ),
                     const SizedBox(height: 16.0),
                     Heading(
                       title: 'Tools',
                       child: TagsSelection(
                         maxCount: 3,
                         title: 'Tools',
                         errorMessage: 'Cannot add more tools',
                         selection: tools,
                         placeholderText: 'Tools',
                         onSelect: (selectedSkills) {
                           setState(() {
                             tools = selectedSkills;
                           });
                         },
                       ),
                     ),
                     const SizedBox(height: 16.0),
                     _getWorkTypeChip(),
                     const SizedBox(height: 16.0),
                     _getJobDurationChip(),
                     const SizedBox(height: 16.0),
                     TitledTextField(
                       textController: salaryController,
                       title: 'Hourly Rate',
                       titledTextFieldType: TitledTextFieldType.currency,
                       textInputType: TextInputType.number,
                       hinText: '\$12',
                     ),
                     const SizedBox(height: 16.0),
                     _getCurrentStatusChip(),
                     const SizedBox(height: 36.0),
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              buttonStyle: PrimaryButtonStyle.bordered,
                              borderWidth: 1,
                              autoGrow: true,
                              autoExpand: true,
                              expandType: ExpandButtonType.horizontal,
                              borderColor: ColorConstant.neutral300,
                              state: PrimaryButtonState.normal,
                              size: PrimaryButtonSize.custom,
                              iconSize: 18,
                              iconAsset: AssetConstant.draftIcon,
                              iconColor: ColorConstant.neutral800,
                              textColor: ColorConstant.neutral700,

                              title: 'Drafts',
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => Center(
                                        child: Container(
                                            padding: const EdgeInsets.all(20),
                                            color: ColorConstant.warning200,
                                            child: const Text('Coming Soon'))));
                              },
                              curveStyle: CurveStyle.all,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: PrimaryButton(
                              buttonStyle: PrimaryButtonStyle.normal,
                              size: PrimaryButtonSize.custom,
                              verticalButtonPadding: 9,
                              autoGrow: true,
                              autoExpand: true,
                              expandType: ExpandButtonType.horizontal,
                              iconAsset: AssetConstant.uploadCircleIcon,
                              title: 'Upload',
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => const UploadIndicator(
                                          progressProfile: 10.0,
                                          isUploadingProfile: false,
                                          millisProfile: 20,
                                          isUploadingVideo: true,
                                          progressVideo: 100.0,
                                          millisVideo: 10,
                                        ));
                              },
                              curveStyle: CurveStyle.all,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (!isVideo)
                      Align(
                        alignment: Alignment.center,
                        child: Center(
                          child: SizedBox(
                            width: 300,
                            height: 220,
                            child: UploadDialogWidget(
                              detailText: "Upload Information",
                              onTapUploadVideo: () async {
                                setState(() {
                                  isVideo = true;
                                });
                                FileModel? saveVideo = await FileManager()
                                    .pickVideoWithModel(ImageSource.camera);
                                if (saveVideo != null && saveVideo.file != null) {
                                  if (context.mounted) {
                                    setState(() {
                                      pickVideo = saveVideo;
                                    });
                                    String generatedThumbnail =
                                        await ThumbnailGenerator()
                                            .generateThumbnail(pickVideo!.file!);
                                    setState(() {
                                      thumbnailUrl = generatedThumbnail;
                                    });
                                    debugPrint("Thumbnail URL is $thumbnailUrl");
                                  }
                                }
                              },
                              onTapDetails: () {
                                navKey.currentState?.push(MaterialPageRoute(
                                    builder: (_) => const UploadInformation()));
                              },
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getWorkTypeChip() {
    return PreSelectedChipWithHeading(
      heading: TranslationKeys.workType,
      preSelected: true,
      chips: const ['Remote', 'On-site' , 'Hybrid'],
      onSubmitSelectedItem: (String selectedItem) {},
    );
  }

  Widget _getJobDurationChip() {
    return PreSelectedChipWithHeading(
      heading: TranslationKeys.jobDuration,
      preSelected: true,
      chips: const ['Full-time', 'Part-time' , 'Hybrid'] ,
      onSubmitSelectedItem: (String selectedItem) {},
    );
  }

  Widget _getCurrentStatusChip() {
    return PreSelectedChipWithHeading(
      heading: TranslationKeys.currentStatus,
      preSelected: true,
      chips: const ['Active', 'Inactive'],
      onSubmitSelectedItem: (String selectedItem) {},
    );
  }
}
