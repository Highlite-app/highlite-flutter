import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/routes/route_constants.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/candidate_home_feed_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/candidate_home_feed_state.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/home/candidate/candidate_home_feed.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/inbox/candidate/candidate_inbox.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/profile/candidate/self_candidate_profile.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/video_feed/candidate_info.dart';

import '../../bloc/dashboard/auth/authentication_state.dart';
import '../../bloc/dashboard/home/candidate/candidate_home_feed_event.dart';
import '../../widgets/center_prompt_widget/center_prompt.dart';
import '../../widgets/dashboard/dashboard_tabs.dart';
import '../../widgets/dashboard/home_navigator.dart';
import '../../widgets/inbox/inbox_end_drawer.dart';
import '../../widgets/toaster/toaster_widget.dart';
import '../../widgets/uploader/overlaying_toast_stack.dart';
import '../navigation/search/candidate/candidate_search.dart';
import '../navigation/upload /candidate/upload_candidate.dart';

class CandidateTabs {
  static String mainTabs = "MainTabs";
  static String videoFeed = "Home";
  static String search = "Search";
  static String inbox = "Inbox";
  static String upload = "Upload";
  static String profile = "Profile";
}

class CandidateDashboard extends StatefulWidget {
  static const routeName = '/candidate-dashboard';

  const CandidateDashboard({super.key});

  @override
  State<CandidateDashboard> createState() => _CandidateDashboardState();
}

class _CandidateDashboardState extends State<CandidateDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  List<DashboardTab> _pages = [];
  int _selectedPageIndex = 0;
  bool onDarkTabs = true;

  @override
  void initState() {
    _pages = [
       DashboardTab(
        tag: CandidateTabs.videoFeed,
        widget: CandidateHomeFeed(),
        icon: AssetConstant.homeIcon,
        selectedIcon: AssetConstant.homeSelectedIcon,
      ),
      DashboardTab(
        tag: CandidateTabs.search,
        widget: CandidateSearchPage(),
        icon: AssetConstant.searchIcon,
        selectedIcon: AssetConstant.searchIconSelected,
      ),
       DashboardTab(
        tag: CandidateTabs.upload,
        widget: UploadCandidate(),
        isHighliteLogo: true,
        icon: AssetConstant.icHighLiteSMLogoSmall,
        selectedIcon: AssetConstant.icHighLiteSMLogoSmall,
      ),
      DashboardTab(
        tag: CandidateTabs.inbox,
        widget: CandidateInboxPage(
          scaffoldState: _scaffoldState,
        ),
        icon: AssetConstant.messageIcon,
        selectedIcon: AssetConstant.messageIconSelected,
      ),
       DashboardTab(
          tag: CandidateTabs.profile,
          widget: SelfCandidateProfile(),
          icon: AssetConstant.profileIcon,
          selectedIcon: AssetConstant.profileSelectedIcon)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
        final pages = _pages
            .where((element) => authState.isAuthenticated
                ? true
                : element.title != CandidateTabs.profile)
            .toList();
        return CandidateHomeFeedProvider(
          child: BlocBuilder<CandidateHomeFeedBloc, CandidateHomeFeedState>(
              builder: (context, state) {
            return DefaultTabController(
              length: pages.length,
              initialIndex: 0,
              animationDuration: const Duration(milliseconds: 100),
              child: Scaffold(
                key: _scaffoldState,
                body: HomeNavigator(
                    builder: (navKey) => OverlayingToastStack(
                            toasts: const [
                              //UploadHandlerToast(),
                              ToasterWidget(),
                              CenterPrompt()
                            ],
                            child: TabBarView(
                              key: Key(CandidateTabs.mainTabs),
                              physics: const NeverScrollableScrollPhysics(),
                              children: _pages
                                  .map(
                                    (page) => page.widget,
                                  )
                                  .toList(),
                            ))),
                endDrawer: _selectedPageIndex == 2
                    ? BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, authState) => InboxEndDrawer(
                          profile: authState.candidate?.profilePicture ?? '',
                          name: authState.candidate?.fullName ?? "",
                          onArchiveOpen: () {
                            Get.toNamed(RouteConstants.provideFeedbackSubpage);
                            // TODO: NEED TO ADD CANDIDATE ARCHIVE INBOX PAGE
                            // CandidateArchivedInbox(),
                          },
                          onContactSupportOpen: () {},
                        ),
                      )
                    : null,
                bottomNavigationBar: DashboardTabs(
                  tabs: _pages,
                  selectedIndex: _selectedPageIndex,
                  onDarkTabs: onDarkTabs,
                  isHighliteLogo: _selectedPageIndex == 2 ? true : false,
                  onSelectPage: (index) async {
                    context
                        .read<CandidateHomeFeedBloc>()
                        .add(BottomNavTabChanged(index: index));
                    print("The current index is ::$index");
                    setState(
                      () {
                        _selectedPageIndex = index;
                        onDarkTabs =
                            _selectedPageIndex == 0 || _selectedPageIndex == 2;
                        Future.delayed(const Duration(milliseconds: 300))
                            .then((value) {
                          SystemChrome.setSystemUIOverlayStyle(onDarkTabs
                              ? SystemUiOverlayStyle.light
                              : SystemUiOverlayStyle.dark);
                        });
                      },
                    );
                  },
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
