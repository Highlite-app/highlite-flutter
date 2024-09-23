// import 'package:flutter/material.dart';
// import 'package:highlite_flutter/constants/text_style.dart';
// import 'package:highlite_flutter/constants/theme.dart';
// import 'package:highlite_flutter/constants/user_types.dart';
// import 'package:highlite_flutter/models/api_v2/highilte_bookmark_collection.dart';
// import 'package:highlite_flutter/pages/v2/bookmark_v2/grids/bookmark_info_feed_grid.dart';
// import 'package:highlite_flutter/pages/v2/bookmark_v2/grids/bookmark_info_user_grid.dart';
// import 'package:highlite_flutter/providers/bookmark_v2/bookmarks/bookmarks_bloc.dart';
// import 'package:highlite_flutter/providers/bookmark_v2/bookmarks/bookmarks_builder.dart';
// import 'package:highlite_flutter/providers/bookmark_v2/bookmarks/bookmarks_event.dart';
// import 'package:highlite_flutter/services/api/authentication/auth_service.dart';
// import 'package:highlite_flutter/utils/initial.dart';
// import 'package:highlite_flutter/utils/string.dart';
// import 'package:highlite_flutter/widgets/appbar/base_appbar.dart';
// import 'package:highlite_flutter/widgets/appbar/titled_appbar.dart';
// import 'package:highlite_flutter/widgets/popup_menu/popup_menu.dart';
// import 'package:highlite_flutter/widgets/tabs/primary_tabs.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../data/models/apis/onboarding/bookmark/highilte_bookmark_collection.dart';
// import '../../../bloc/dashboard/bookmarks/bookmarks_bloc.dart';
// import '../../../bloc/dashboard/bookmarks/bookmarks_builder.dart';
// import '../../../bloc/dashboard/bookmarks/bookmarks_event.dart';
// import '../../../widgets/utils/initial.dart';
//
// class BookmarkCollectionPage extends StatefulWidget {
//   final int selectedIndex;
//   final HighliteBookmarkCollection bookmarkCollection;
//   final BuildContext ctx;
//   // final List<HighliteBookmarkInfo> bookmarkInfo;
//   const BookmarkCollectionPage({
//     super.key,
//     required this.selectedIndex,
//     required this.bookmarkCollection,
//     required this.ctx,
//     // required this.bookmarkInfo,
//   });
//
//   @override
//   State<BookmarkCollectionPage> createState() => _BookmarkCollectionPageState();
// }
//
// class _BookmarkCollectionPageState extends State<BookmarkCollectionPage> {
//   int selectedTab = 0;
//   @override
//   void initState() {
//     super.initState();
//     InitialStater.init().then((value) {
//       widget.ctx.read<BookmarksBloc>().add(
//             // GetBookmarksEvent(
//             //   widget.authUserId,
//             // ),
//             const GetBookmarksEvent(),
//           );
//     });
//   }
//
//   @override
//   void dispose() {
//     widget.ctx.read<BookmarksBloc>().add(const ResetBookMarkEditModeEvent());
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BookmarksBuilderWidget(builder: (context, state) {
//       return BaseTabController(
//         tabs: [
//           // PrimaryTabIcon(asset: "grid-01", isSelected: selectedTab == 0),
//           // PrimaryTabIcon(
//           //     asset: "clapperboard-01", isSelected: selectedTab == 1),
//           Tab(
//             text: authV2Service.persistedUser?.userType != UserTypes.candidate
//                 ? "Candidates"
//                 : "Companies",
//           ),
//           Tab(
//             text: authV2Service.persistedUser?.userType != UserTypes.candidate
//                 ? "Videos"
//                 : "Jobs",
//           ),
//         ],
//         builder: (tabs) => Scaffold(
//           appBar: BookmarkCollectionPageAppbar(
//             // model: state.bookmarks[widget.selectedIndex],
//             model: widget.bookmarkCollection,
//             bookmarkType:
//                 selectedTab == 0 ? BookmarkType.profile : BookmarkType.feed,
//           ),
//           body: Scaffold(
//             backgroundColor: ColorTheme.shade00,
//             appBar: PrimaryTabBar(
//               onTap: (index) {
//                 setState(() {
//                   selectedTab = index;
//                 });
//                 context
//                     .read<BookmarksBloc>()
//                     .add(const ResetBookMarkEditModeEvent());
//               },
//               tabs: tabs,
//             ),
//
//             body: TabBarView(
//               physics: const NeverScrollableScrollPhysics(),
//               children: [
//                 BookmarkInfoUserGrid(
//                   users: authV2Service.persistedUser?.userType !=
//                           UserTypes.candidate
//                       ? state.bookmarkInfos
//                           .where((e) =>
//                               e.bookmarkCollectionID ==
//                                   widget.bookmarkCollection.id &&
//                               e.type == "profile" &&
//                               e.candidateProfile != null)
//                           .toList()
//                       : state.bookmarkInfos
//                           .where((e) =>
//                               e.bookmarkCollectionID ==
//                                   widget.bookmarkCollection.id &&
//                               e.type == "profile" &&
//                               e.companyProfile != null)
//                           .toList(),
//                   profileIds: authV2Service.persistedUser?.userType !=
//                           UserTypes.candidate
//                       ? state.bookmarkInfos
//                           .where((e) =>
//                               e.bookmarkCollectionID ==
//                                   widget.bookmarkCollection.id &&
//                               e.type == "profile" &&
//                               e.candidateProfile != null)
//                           .map((item) => item.candidateProfile!.id)
//                           .toList()
//                       : state.bookmarkInfos
//                           .where((e) =>
//                               e.bookmarkCollectionID ==
//                                   widget.bookmarkCollection.id &&
//                               e.type == "profile" &&
//                               e.companyProfile != null)
//                           .map((item) => item.companyProfile!.id)
//                           .toList(),
//
//                   selectedIndex: widget.selectedIndex,
//                   // users: state.bookmarkInfos.where((e) => e.bookmarkCollectionID == widget.bookmarkCollection.id && e.type == "profile").toList(),
//                   // profileIds: authV2Service.persistedUser?.userType != UserTypes.candidate ?
//                   //     state.bookmarkInfos.where((e) => e.bookmarkCollectionID == widget.bookmarkCollection.id && e.type == "profile").map((item) => item.candidateProfile!.id).toList()
//                   //     : state.bookmarkInfos.where((e) => e.bookmarkCollectionID == widget.bookmarkCollection.id && e.type == "profile").map((item) => item.companyProfile!.id).toList(),
//                 ),
//                 BookmarkInfoFeedGrid(
//                   feeds: authV2Service.persistedUser?.userType !=
//                           UserTypes.candidate
//                       ? state.bookmarkInfos
//                           .where((e) =>
//                               e.bookmarkCollectionID ==
//                                   widget.bookmarkCollection.id &&
//                               e.type == "feed" &&
//                               e.candidateFeed != null)
//                           .toList()
//                       : state.bookmarkInfos
//                           .where((e) =>
//                               e.bookmarkCollectionID ==
//                                   widget.bookmarkCollection.id &&
//                               e.type == "feed" &&
//                               e.jobPosting != null)
//                           .toList(),
//                   feedIds: authV2Service.persistedUser?.userType !=
//                           UserTypes.candidate
//                       ? state.bookmarkInfos
//                           .where((e) =>
//                               e.bookmarkCollectionID ==
//                                   widget.bookmarkCollection.id &&
//                               e.type == "feed" &&
//                               e.candidateFeed != null)
//                           .map((item) => item.candidateFeed!.id)
//                           .toList()
//                       : state.bookmarkInfos
//                           .where((e) =>
//                               e.bookmarkCollectionID ==
//                                   widget.bookmarkCollection.id &&
//                               e.type == "feed" &&
//                               e.jobPosting != null)
//                           .map((item) => item.jobPosting!.id)
//                           .toList(),
//                   selectedIndex: widget.selectedIndex,
//                 ),
//               ],
//             ),
//             // ]),
//           ),
//         ),
//       );
//     });
//   }
// }
//
// class BookmarkCollectionPageAppbar extends StatelessWidget with BaseAppBar {
//   // final BookmarkModel model;
//   final HighliteBookmarkCollection model;
//   final BookmarkType bookmarkType;
//   BookmarkCollectionPageAppbar({
//     super.key,
//     required this.model,
//     required this.bookmarkType,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BookmarksBuilderWidget(
//       builder: (context, state) => TitledAppBar(
//           title: model.title,
//           includesBorder: false,
//           style: const BaseTextStyle(
//             fontSize: TypographyTheme.paragraph_p3,
//             color: ColorTheme.neutral800,
//             fontWeight: FontWeight.w600,
//           ),
//           actions: [
//             if (!state.isEditModeUser && !state.isEditModeFeed)
//               ActionMenu(
//                 actions: [
//                   ActionItem(
//                       value: "",
//                       label: currentLocalizations.select,
//                       icon: "list")
//                 ],
//                 onTap: (value) {
//                   context
//                       .read<BookmarksBloc>()
//                       .add(SwitchTabBookMarkEditModeEvent(bookmarkType));
//                 },
//               ),
//           ]),
//     );
//   }
// }
