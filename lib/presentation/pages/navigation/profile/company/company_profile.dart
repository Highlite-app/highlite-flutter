// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
// import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';
// import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
// import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
// import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_bloc.dart';
// import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_state.dart';
// import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';
//
// import '../../../../../core/constants/mocked_image.dart';
// import '../../../../../core/resources/l10n/translation_key.dart';
// import '../../../../../domain/repositories/dashboard/common/feed_service/home_feed_state_repository.dart';
// import '../../../../bloc/dashboard/profile/company/public_profile/public_company_profile_bloc.dart';
// import '../../../../bloc/dashboard/profile/company/public_profile/public_company_profile_builder.dart';
// import '../../../../bloc/dashboard/profile/company/public_profile/public_company_profile_event.dart';
// import '../../../../widgets/gallery/generic_grid.dart';
// import '../../../../widgets/modal/multiple_selection_modal.dart';
// import '../../../../widgets/navigation/base_navigator.dart';
// import '../../../../widgets/overlay/super_message/super_message_sender.dart';
// import '../../../../widgets/profile/job_post_tile.dart';
// import '../../../../widgets/profile/profile_section_spacer.dart';
// import '../../../../widgets/profile/sections/company/sections/company_about_section.dart';
// import '../../../../widgets/profile/sections/company/sections/company_general_section.dart';
// import '../../../../widgets/profile/sections/company/sections/company_header_section.dart';
// import '../appbar/profile_appbar.dart';
// import '../default/profile_hero_section.dart';
//
// class CompanyProfile extends StatefulWidget {
//   static const previewRoute = '/company-profile';
//   static const routeName = 'company-profile';
//   final CompanyOnboarding companyProfile;
//   final List<CompanyJobPost> jobPosts;
//   final bool isPreview;
//   const CompanyProfile({
//     super.key,
//     required this.isPreview,
//     required this.companyProfile,
//     required this.jobPosts,
//   });
//
//   @override
//   State<CompanyProfile> createState() => _CompanyProfileState();
// }
//
// class _CompanyProfileState extends State<CompanyProfile> {
//   @override
//   Widget build(BuildContext context) {
//     return PublicCompanyProfileProviderWidget(
//       companyProfile: widget.companyProfile,
//       child: PublicCompanyProfileBuilderWidget(builder: (context, state) {
//         return
//           BaseNavigator(
//           builder: (navKey) => Scaffold(
//             appBar: ProfileAppBar(
//               username: widget.companyProfile.userName,
//               navigator:
//               widget.isPreview ? context.navigator : navKey.currentState!,
//               isPreview: widget.isPreview,
//               selectedProfileId: widget.companyProfile.companyId,
//             ),
//             backgroundColor: ColorConstant.shade00,
//             body: CustomScrollView(
//               slivers: [
//                 CompanyProfileHeaderSection(
//                   profilePhoto: MockedImage.mockedCompanyImageFromS3,
//                   organization: widget.companyProfile.companyName,
//                   industry: widget.companyProfile.industry,
//                   city: widget.companyProfile.location,
//                   country: widget.companyProfile.location,
//                 ),
//                 BlocBuilder<AuthenticationBloc , AuthenticationState>(
//                   builder: (context, authState) =>
//                       PublicCompanyProfileBuilderWidget(
//                         builder: (context, state) => ProfileHeroSection(
//                           isPreview: widget.isPreview,
//                           onEdit: () {
//                             // navKey.currentState!
//                             //     .push(
//                             //   MaterialPageRoute(
//                             //     builder: (_) => const EditCompanyProfile(),
//                             //   ),
//                             // )
//                             //     .then((_) {
//                             //   setState(() {
//                             //     // context.read<PublicCompanyProfileBloc>().add(const ReloadPublicCompanyProfileEvent());
//                             //   });
//                             // });
//                           },
//                           followers: "${state.followers.length}",
//                           // following: "${state.following.length}",
//                           following: "${state.followingCount}",
//                           isFollowing: state.followers
//                               .where((follower) => follower == authState.id)
//                               .isNotEmpty,
//                           onFollow: state.isLoading ||
//                               authService.getUserID() ==
//                                   widget.companyProfile.id
//                               ? null
//                               : () {
//                             if (state.followers
//                                 .where((follower) => follower == authState.id)
//                                 .isNotEmpty) {
//                               context.read<PublicCompanyProfileBloc>().add(
//                                   const UnfollowPublicCompanyProfileEvent());
//                             } else {
//                               context.read<PublicCompanyProfileBloc>().add(
//                                   const FollowPublicCompanyProfileEvent());
//                             }
//                           },
//                           onTapSuperMessage: authService.getUserID() ==
//                               widget.companyProfile.id
//                               ? null
//                               : () {
//                             SuperMessageSenderOverlay.showSuperMessage(state
//                                 .jobPosts
//                                 .map(
//                                   (e) =>
//                                   IDValue(id: e.id, value: e.title),
//                             )
//                                 .toList())
//                                 .then(
//                                   (sendResponse) {
//                                 if (sendResponse != null &&
//                                     sendResponse.idValue != null) {
//                                   context
//                                       .read<PublicCompanyProfileBloc>()
//                                       .add(
//                                     SuperMessageEvent(
//                                       jobPostId: sendResponse.idValue!.id,
//                                       message: sendResponse.message,
//                                       companyId: widget.companyProfile.id,
//                                     ),
//                                   );
//                                 }
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                 ),
//                 if (widget.companyProfile.aboutCompany != "")
//                   CompanyAboutSection(
//                     aboutMe: widget.companyProfile.aboutCompany,
//                   ),
//                 CompanyGeneralSection(
//                   companyWebsite: widget.companyProfile.website,
//                   lookingToHire: widget.companyProfile.lookingToHire,
//                 ),
//                 ProfileSectionSpacer(
//                   height: widget.jobPosts.isEmpty ? 0 : 12,
//                   onEdit: null,
//                   header: TranslationKeys.ourJobs,
//                 ),
//                 PublicCompanyProfileBuilderWidget(
//                   builder: (context, state) => CompanyJobSection(
//                     items: state.jobFeeds,
//                     postItems: state.jobPosts,
//                     isPreview: widget.isPreview,
//                   ),
//                 ),
//                 const ProfileSectionSpacer(height: 40),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
//
// class ComprofileOnlyUI extends StatefulWidget {
//   final CompanyOnboarding companyProfile;
//   final List<CompanyJobPost> jobPosts;
//   final bool isPreview;
//   const ComprofileOnlyUI({
//     required this.isPreview,
//     required this.companyProfile,
//     required this.jobPosts,
//     super.key});
//
//   @override
//   State<ComprofileOnlyUI> createState() => _ComprofileOnlyUIState();
// }
//
// class _ComprofileOnlyUIState extends State<ComprofileOnlyUI> {
//   @override
//   Widget build(BuildContext context) {
//     return   BaseNavigator(
//       builder: (navKey) => Scaffold(
//         appBar: ProfileAppBar(
//           username: widget.companyProfile.username,
//           navigator:
//           widget.isPreview ? context.navigator : navKey.currentState!,
//           isPreview: widget.isPreview,
//           selectedProfileId: widget.companyProfile.id,
//         ),
//         backgroundColor: ColorConstant.shade00,
//         body: CustomScrollView(
//           slivers: [
//             CompanyProfileHeaderSection(
//               profilePhoto: widget.companyProfile.companyLogo ??
//                   MockedImage.mockedCompanyImageFromS3,
//               organization: widget.companyProfile.companyName,
//               industry: widget.companyProfile.industry,
//               city: widget.companyProfile.city,
//               country: widget.companyProfile.country,
//             ),
//             BlocBuilder<AuthenticationBloc , AuthenticationState>(
//               builder: (context, authState) =>
//                   PublicCompanyProfileBuilderWidget(
//                     builder: (context, state) => ProfileHeroSection(
//                       isPreview: widget.isPreview,
//                       onEdit: () {
//                         // navKey.currentState!
//                         //     .push(
//                         //   MaterialPageRoute(
//                         //     builder: (_) => const EditCompanyProfile(),
//                         //   ),
//                         // )
//                         //     .then((_) {
//                         //   setState(() {
//                         //     // context.read<PublicCompanyProfileBloc>().add(const ReloadPublicCompanyProfileEvent());
//                         //   });
//                         // });
//                       },
//                       followers: "${state.followers.length}",
//                       // following: "${state.following.length}",
//                       following: "${state.followingCount}",
//                       isFollowing: state.followers
//                           .where((follower) => follower == authState.id)
//                           .isNotEmpty,
//                       onFollow: state.isLoading ||
//                           authService.getUserID() ==
//                               widget.companyProfile.id
//                           ? null
//                           : () {
//                         if (state.followers
//                             .where((follower) => follower == authState.id)
//                             .isNotEmpty) {
//                           context.read<PublicCompanyProfileBloc>().add(
//                               const UnfollowPublicCompanyProfileEvent());
//                         } else {
//                           context.read<PublicCompanyProfileBloc>().add(
//                               const FollowPublicCompanyProfileEvent());
//                         }
//                       },
//                       onTapSuperMessage: authService.getUserID() ==
//                           widget.companyProfile.id
//                           ? null
//                           : () {
//                         SuperMessageSenderOverlay.showSuperMessage(state
//                             .jobPosts
//                             .map(
//                               (e) =>
//                               IDValue(id: e.id, value: e.title),
//                         )
//                             .toList())
//                             .then(
//                               (sendResponse) {
//                             if (sendResponse != null &&
//                                 sendResponse.idValue != null) {
//                               context
//                                   .read<PublicCompanyProfileBloc>()
//                                   .add(
//                                 SuperMessageEvent(
//                                   jobPostId: sendResponse.idValue!.id,
//                                   message: sendResponse.message,
//                                   companyId: widget.companyProfile.id,
//                                 ),
//                               );
//                             }
//                           },
//                         );
//                       },
//                     ),
//                   ),
//             ),
//             if (widget.companyProfile.aboutCompany != "")
//               CompanyAboutSection(
//                 aboutMe: widget.companyProfile.aboutCompany,
//               ),
//             CompanyGeneralSection(
//               companyWebsite: widget.companyProfile.website,
//               lookingToHire: widget.companyProfile.lookingToHire,
//             ),
//             ProfileSectionSpacer(
//               height: widget.jobPosts.isEmpty ? 0 : 12,
//               onEdit: null,
//               header: TranslationKeys.ourJobs,
//             ),
//             PublicCompanyProfileBuilderWidget(
//               builder: (context, state) => CompanyJobSection(
//                 items: state.jobFeeds,
//                 postItems: state.jobPosts,
//                 isPreview: widget.isPreview,
//               ),
//             ),
//             const ProfileSectionSpacer(height: 40),
//           ],
//         ),
//       ),
//     );;
//   }
// }
//
//
//
// class CompanyJobSection extends StatefulWidget {
//   final List<HighliteCompanyJobFeed> items;
//   final List<HighliteCompanyJobPost> postItems;
//   final bool isPreview;
//   const CompanyJobSection({
//     super.key,
//     required this.items,
//     required this.postItems,
//     required this.isPreview,
//   });
//
//   @override
//   State<CompanyJobSection> createState() => _CompanyJobSectionState();
// }
//
// class _CompanyJobSectionState extends State<CompanyJobSection> {
//   @override
//   Widget build(BuildContext context) {
//     if (widget.items.isEmpty) {
//       return const ProfileSectionSpacer(
//         height: 0,
//         onEdit: null,
//         header: "This company currently has no job posted.",
//       );
//     }
//     if (widget.isPreview) {
//       return GenericGrid(
//         isAddEnabled: false,
//         perColumn: 2,
//         horizontalPadding: 16.0,
//         maxHeight: 240,
//         items: widget.items,
//         itemBuilder: (context, item, index) => JobPostTile(
//           jobFeed: item,
//           isFromOwnProfile: !widget.isPreview,
//         ),
//       );
//     } else {
//       return ValueListenableBuilder(
//         valueListenable: homeFeedState.jobPosts,
//         builder: (context, value, child) {
//           return GenericGrid(
//             isAddEnabled: false,
//             perColumn: 2,
//             horizontalPadding: 16.0,
//             maxHeight: 240,
//             // items: widget.postItems,
//             items: value.where((e) => e.jobVideoFeedID != "").toList(),
//             itemBuilder: (context, item, index) => JobPostTile(
//               jobPost: item,
//               isFromOwnProfile: true,
//             ),
//           );
//         },
//       );
//     }
//   }
//
//   @override
//   void didUpdateWidget(CompanyJobSection oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.items != oldWidget.items) {
//       // context.read<PublicCompanyProfileBloc>().add(const ReloadPublicCompanyProfileEvent());
//     }
//   }
// }
