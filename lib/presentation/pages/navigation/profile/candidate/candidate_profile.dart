// import 'package:flutter/material.dart';
// import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
// import '../../../../../core/resources/color_constants.dart';
// import '../../../../../core/resources/l10n/translation_key.dart';
// import '../../../../widgets/buttons/tag_item.dart';
// import '../../../../widgets/navigation/base_navigator.dart';
// import '../../../../widgets/profile/profile_section_spacer.dart';
// import '../../../../widgets/profile/sections/candidate/candidate_general_section.dart';
// import '../../../../widgets/profile/sections/candidate/candidate_header_section.dart';
// import '../../../../widgets/profile/tags_profile_section.dart';
// import '../../../../widgets/utils/context.dart';
// import '../appbar/profile_appbar.dart';
// import '../default/profile_hero_section.dart';
// import 'edit_profile/edit_candidate_profile.dart';
//
// class CandidateProfile extends StatelessWidget {
//   static String routeName = "preview-candidate";
//   static String previewRoute = "/preview-candidate";
//
//   final CandidateOnBoarding? candidateProfile;
//   final bool isPreview;
//
//   const CandidateProfile({
//     super.key,
//     required this.candidateProfile,
//     required this.isPreview,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BaseNavigator(
//       builder: (navKey) => Scaffold(
//         appBar: ProfileAppBar(
//           username: candidateProfile?.username ?? "",
//           navigator: isPreview ? context.navigator : navKey.currentState!,
//           isPreview: isPreview,
//           selectedProfileId: candidateProfile?.candidateId ?? "",
//         ),
//         body: CustomScrollView(
//           slivers: [
//             CandidateProfileHeaderSection(
//               profilePhoto: '',
//               firstName: candidateProfile?.firstName ?? "",
//               lastName: candidateProfile?.lastName ?? "",
//               title: candidateProfile?.position ?? "",
//               city: candidateProfile?.city ?? "",
//               country: candidateProfile?.country ?? "",
//             ),
//             ProfileHeroSection(
//               isPreview: isPreview,
//               onEdit: () {
//                 navKey.currentState!.push(
//                   MaterialPageRoute(
//                     builder: (_) => const EditCandidateProfile(),
//                   ),
//                 );
//               },
//               followers: "100",
//               following: "158",
//               isFollowing: false,
//               onFollow: () {},
//             ),
//             // if (candidateProfile?.aboutme?.isNotEmpty ??
//             //     false || candidateProfile?.aboutme != null)
//             //   CandidateAboutSection(
//             //     aboutMe: candidateProfile?.aboutme ?? "",
//             //   ),
//             CandidateGeneralSection(
//               salary: candidateProfile?.salary ?? "",
//               jobDuration: candidateProfile?.jobDuration ?? "",
//               jobFlexibility: candidateProfile?.workType ?? "",
//             ),
//             TagsProfileSection(
//               title: TranslationKeys.skills,
//               addText: null,
//               groupTags: TagWrap(
//                 axis: Axis.horizontal,
//                 wrappedTags: candidateProfile?.skills?
//                   .map((e) => Tag(title: e))
//                         .toList() ??
//                     [],
//               ),
//               isPreview: true,
//               onSave: (skills) {},
//             ),
//             TagsProfileSection(
//               title: TranslationKeys.tools,
//               addText: null,
//               groupTags: TagWrap(
//                 axis: Axis.horizontal,
//                 wrappedTags: candidateProfile?.tools
//                         ?.map((e) => Tag(title: e))
//                         .toList() ??
//                     [],
//               ),
//               isPreview: true,
//               onSave: (tools) {},
//             ),
//
//               const ProfileSectionSpacer(
//                 height: 12,
//                 onEdit: null,
//                 header: TranslationKeys.myWork,
//               ),
//             const ProfileSectionSpacer(height: 40),
//           ],
//         ),
//         backgroundColor: ColorConstant.shade00,
//       ),
//     );
//   }
// }
