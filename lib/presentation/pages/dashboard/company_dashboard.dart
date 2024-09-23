import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/dummy_page.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_state.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/home/candidate/candidate_home_feed.dart';

import '../../widgets/center_prompt_widget/center_prompt.dart';
import '../../widgets/dashboard/dashboard_tabs.dart';
import '../../widgets/dashboard/home_navigator.dart';
import '../../widgets/inbox/inbox_end_drawer.dart';
import '../../widgets/toaster/toaster_widget.dart';
import '../../widgets/uploader/overlaying_toast_stack.dart';
import '../navigation/inbox/candidate/candidate_inbox.dart';
import '../navigation/upload /company/upload_company.dart';

class CompanyTabs {
  static String mainTabs = "MainTabs";
  static String videoFeed = "Home";
  static String search = "Search";
  static String inbox = "Inbox";
  static String bookmarks = "Bookmarks";
  static String profile = "Profile";
}

class CompanyDashboard extends StatefulWidget {
  static const routeName = '/company-dashboard';

  const CompanyDashboard({super.key});

  @override
  State<CompanyDashboard> createState() => _CompanyDashboardState();
}

class _CompanyDashboardState extends State<CompanyDashboard>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  List<DashboardTab> _pages = [];
  int _selectedPageIndex = 0;
  bool onDarkTabs = true;

  @override
  void initState() {
    _pages = [
      DashboardTab(
        widget: CandidateHomeFeed(),
        title: CompanyTabs.videoFeed,
        icon: AssetConstant.homeSelectedIcon,
        selectedIcon: AssetConstant.homeSelectedIcon,
      ),
      DashboardTab(
        widget: const DummyPage(),
        title: CompanyTabs.search,
        icon: AssetConstant.searchIcon,
        selectedIcon: AssetConstant.searchIconSelected,
      ),
      const DashboardTab(
        widget: UploadCompany(),
        title: "",
        isHighliteLogo: true,
        icon: AssetConstant.icHighLiteSMLogoSmall,
        selectedIcon: AssetConstant.icHighLiteSMLogoSmall,
      ),
      DashboardTab(
        widget: CandidateInboxPage(
          scaffoldState: _scaffoldState,
        ),
        title: CompanyTabs.inbox,
        icon: AssetConstant.messageIcon,
        selectedIcon: AssetConstant.messageIconSelected,
      ),
      DashboardTab(
        widget: DummyPage(),
        title: CompanyTabs.profile,
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, authState) {
      final pages = _pages
          .where(
            (element) => authState.isAuthenticated ? true : true,
          )
          .toList();
      return
          // TODO : NEED THIS BLOC WHEN COMPANY BLOC IS CREATED
          // CompanyHomeFeedProviderWidget(
          // isHome: true,
          // child: SettingsProviderWidget(
          //   child: SettingsBuilderWidget(
          //     builder: (context, settingState) =>
          DefaultTabController(
              length: pages.length,
              initialIndex: 0,
              animationDuration: const Duration(milliseconds: 100),
              child: Scaffold(
                key: _scaffoldState,
                body: HomeNavigator(
                  builder: (navKey) => OverlayingToastStack(
                    toasts: const [
                      //   UploadHandlerToast(),
                      ToasterWidget(),
                      CenterPrompt(),
                    ],
                    child: TabBarView(
                      key: Key(CompanyTabs.mainTabs),
                      physics: const NeverScrollableScrollPhysics(),
                      children: pages
                          .map(
                            (page) => page.widget,
                          )
                          .toList(),
                    ),
                  ),
                ),
                endDrawer: _selectedPageIndex == 2
                    ? BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, authState) => InboxEndDrawer(
                          profile: "",
                         // profile: authState.companyProfile?.companyLogo ?? "",
                          name: authState.companyProfile?.companyName ?? "",
                          onArchiveOpen: () {
                            // globalNavKey.currentState!.push(
                            //   MaterialPageRoute(
                            //     builder: (_) => const CompanyArchivedInbox(),
                            //   ),
                            // );
                          },
                          onContactSupportOpen: () {},
                        ),
                      )
                    : null,
                bottomNavigationBar: DashboardTabs(
                  tabs: pages,
                  selectedIndex: _selectedPageIndex,
                  onDarkTabs: onDarkTabs,
                  onSelectPage: (index) {
                    setState(() {
                      _selectedPageIndex = index;
                      onDarkTabs =
                          _selectedPageIndex == 0 || _selectedPageIndex == 2;
                      Future.delayed(const Duration(milliseconds: 300))
                          .then((value) {
                        SystemChrome.setSystemUIOverlayStyle(onDarkTabs
                            ? SystemUiOverlayStyle.light
                            : SystemUiOverlayStyle.dark);
                      });
                    });
                  },
                ),
              ));
    });
  }
}
