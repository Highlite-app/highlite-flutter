// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
// import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
// import '../../../../../core/constants/profile_options.dart';
// import '../../../../../data/models/apis/dashboard/cadidate/home/candidate_video_feed.dart';
// import '../../../../bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
// import '../../../../bloc/dashboard/profile/candidate/candidate_editor_event.dart';
// import '../../../form/radio_group.dart';
// import '../form/profile_editor_form.dart';
// import '../form/profile_editor_form_item.dart';
//
// class EditProfileByCandidateJobStatus
//     extends EditorFormModel<CandidateVideoFeed> {
//   EditProfileByCandidateJobStatus(String jobStatus, bool activated)
//       : super(
//           title: TranslationKeys.jobStatus,
//           buttonsEnabled: activated,
//           children: (videoFeed, formState, setState) => [
//             ProfileEditorFormItem(
//               label: TranslationKeys.jobStatus,
//               padded: false,
//               caption: TranslationKeys.jobStatusCaption,
//               children: RadioGroup(
//                 items: activated
//                     ? ProfileOptions().jobStatus()
//                     : ProfileOptions().jobStatusInactive(),
//                 initialValue: jobStatus,
//                 onSelect: (selection) {
//                   jobStatus = selection;
//                 },
//               ),
//             ),
//           ],
//           onComplete: (videoFeed, context) async {
//             context.read<CandidateEditorBloc>().add(
//                   UpdateCandidateVideoFeedEvent(
//                     videoFeed: videoFeed?.copyWith(
//                       jobStatus: jobStatus,
//                     ),
//                   ),
//                 );
//           },
//           validated: () => true,
//         );
// }
