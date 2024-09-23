import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/app.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/core/services/push_notification_service.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/video/upload_candidate_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/video/upload_candidate_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/video/upload_candidate_state.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/buttons/primary_button.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/dropdown/custom_dropdown.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/form/form.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/form/tags_selection.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/navigation/base_navigator.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/sectionable/heading.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/svg/svg_asset.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../bloc/toast/toast_bloc.dart';
import '../../../../bloc/toast/toast_event.dart';
import '../../../../widgets/indicator/upload_indicator.dart';
import '../../../../widgets/text_field/location_field.dart';
import '../../../../widgets/toaster/toast_alert.dart';
import '../../../../widgets/utils/file.dart';
import '../../../dashboard/candidate_dashboard.dart';

class UploadCandidate extends StatefulWidget {
  const UploadCandidate({super.key});

  @override
  State<UploadCandidate> createState() => _UploadCandidateState();
}

class _UploadCandidateState extends State<UploadCandidate> {
  @override
  Widget build(BuildContext context) {
    context.read<UploadCandidateBloc>().add(ResetIsVideoStateEvent()) ;
    return BlocBuilder<UploadCandidateBloc, UploadCandidateState>(
        builder: (context, state) {
      return BaseNavigator(
          builder: (navKey) => Scaffold(
              backgroundColor: ColorConstant.shade00,
              appBar: AppBar(
                backgroundColor: ColorConstant.shade00,
                title: Text(
                  'Upload Video',
                  style: BaseTextStyle(
                      color: ColorConstant.shade100,
                      fontSize: TypographyTheme.paragraph_p3),
                ),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: FormProvider(
                  formState: state.formProvider,
                  formKey: state.formState,
                  builder: (formProvider) => SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextField(
                                controller: state.descriptionController,
                                style: BaseTextStyle(
                                  color: ColorConstant.shade100,
                                  fontSize: TypographyTheme.paragraph_p3,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 8,
                                decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  hintText: 'Enter description...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(width: 24.0),
                            Expanded(
                              flex: 1,
                              child: Stack(
                                children: [
                                  if (state.thumbnailUrl.isNotEmpty)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        File(state.thumbnailUrl),
                                        width:
                                            double.parse(state.thumbnailWidth),
                                        height:
                                            double.parse(state.thumbnailHeight),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  else
                                    UploadVideo(
                                      text: TranslationKeys.uploadVideo,
                                      onTap: () async {
                                        var saveVideo = await FileManager()
                                            .pickVideoWithModel(
                                                ImageSource.camera);
                                        if (saveVideo != null &&
                                            saveVideo.file != null) {
                                          if (context.mounted) {
                                            context
                                                .read<UploadCandidateBloc>()
                                                .add(PickVideoEvent(
                                                    video: saveVideo.file ??
                                                        File('')));
                                          }
                                        }
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const LocationField(
                            title: 'Location', submitText: ' Add Location'),
                        const SizedBox(height: 16.0),
                        Heading(
                          title: "Add Tags (optional)",
                          child: TagsSelection(
                            placeholderText: "Add tags",
                            title: "Enter a comma after each tag",
                            selection: state.tags,
                            onSelect: (selected) {
                              context
                                  .read<UploadCandidateBloc>()
                                  .add(UpdateTagsEvent(selectedTags: selected));
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Heading(
                          title: 'Category (optional)',
                          child: CustomDropdown(
                            items: state.categoryList,
                            style: DropdownStyle.underlined,
                            onSelected: (items) {
                              if (items != null && items.isNotEmpty) {
                                context.read<UploadCandidateBloc>().add(
                                    UpdateCategoryEvent(category: [items]));
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 36.0),
                        Row(
                          children: [
                            PrimaryButton(
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
                            const SizedBox(width: 8.0),
                            PrimaryButton(
                              buttonStyle: PrimaryButtonStyle.normal,
                              size: PrimaryButtonSize.custom,
                              verticalButtonPadding: 9,
                              autoGrow: true,
                              autoExpand: true,
                              expandType: ExpandButtonType.horizontal,
                              iconAsset: AssetConstant.uploadCircleIcon,
                              title: 'Upload',
                              onTap: () async {
                                if(context.mounted) {
                                  context.read<UploadCandidateBloc>()
                                    .add(UploadCandidateVideoFeedEvent());
                                }
                                if(state.isUpload){
                                  showDialog(
                                    context: context,
                                    builder: (_) => const UploadIndicator(
                                      progressProfile: 10.0,
                                      isUploadingProfile: false,
                                      millisProfile: 20,
                                      isUploadingVideo: true,
                                      progressVideo: 100.0,
                                      millisVideo: 10,
                                    ),
                                  );

                                  toaster.add(
                                      const ShowToastEvent(
                                        text:
                                        "Video Uploaded Successfully. Hold on we are taking you to home screen" ,
                                        icon: AssetConstant.xIcon,
                                        state: ToastState.success,
                                        duration:  Duration(seconds: 3),
                                      ));

                                  Future.delayed(const Duration(seconds: 2), (){
                                    globalNavKey.currentState?.push(MaterialPageRoute(builder: (_) => const CandidateDashboard()));
                                  });

                                  globalNavKey.currentState?.pop() ;
                                }

                              },
                              curveStyle: CurveStyle.all,
                            ),
                          ],
                        ),
                        const SizedBox(height: 36.0),
                      ])),
                ),
              )));
    });
  }
}

class UploadVideo extends StatelessWidget {
  final String text;

  final VoidCallback onTap;

  const UploadVideo({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 125,
        height: 150,
        decoration: BoxDecoration(
            color: ColorConstant.primary50,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SvgAsset(
              asset: AssetConstant.plusCircleIcon,
            ),
            Text(
              text,
              style: BaseTextStyle(
                  color: ColorConstant.neutral800,
                  fontSize: TypographyTheme.paragraph_p4,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
