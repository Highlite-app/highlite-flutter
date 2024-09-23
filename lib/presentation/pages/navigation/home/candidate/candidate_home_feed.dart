import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/candidate/candidate_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/candidate_home_feed_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/candidate_home_feed_event.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/home/candidate/tabs/candidate_following_tab.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/home/candidate/tabs/candidate_for_you_tab.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/home/candidate/tabs/candidate_job_v2.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/home/candidate/tabs/candidate_tab_V2.dart';

import '../../../../../core/resources/typography_theme.dart';
import '../../../../bloc/dashboard/home/candidate/candidate/candidate_event.dart';
import '../../../../bloc/dashboard/home/candidate/for_you/candidate_for_you_bloc.dart';
import '../../../../bloc/dashboard/home/candidate/for_you/candidate_for_you_event.dart';
import '../../../../widgets/constants/text_style.dart';

class CandidateFeedTab {
  final String title;
  final Widget widget;

  const CandidateFeedTab({required this.title, required this.widget});
}


class CandidateHomeFeedProvider extends StatelessWidget {
  final Widget child ;
  const CandidateHomeFeedProvider({
    required this.child ,
    super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CandidateForYouBloc>(
          create: (context) => CandidateForYouBloc()..add(StartCandidateForYouEvent()),
        ),
        BlocProvider<CandidateBloc>(
          create: (context) => CandidateBloc()..add(StartCandidateEvent()),
        ),
        // BlocProvider<JobsBloc>(
        //   create: (context) => JobsBloc(),
        // ),
        // BlocProvider<FollowingBloc>(
        //   create: (context) => FollowingBloc(),
        // ),
        BlocProvider<CandidateHomeFeedBloc>(
          create: (context) => CandidateHomeFeedBloc(
            candidateForYouBloc: BlocProvider.of<CandidateForYouBloc>(context),
            candidateBloc: BlocProvider.of<CandidateBloc>(context),
            // jobsBloc: BlocProvider.of<JobsBloc>(context),
            // followingBloc: BlocProvider.of<FollowingBloc>(context),
          ),
        ),
      ],
      child: child,
    );
  }
}


class CandidateHomeFeed extends StatefulWidget {
  const CandidateHomeFeed({super.key});

  @override
  State<CandidateHomeFeed> createState() => _CandidateHomeFeedState();
}

class _CandidateHomeFeedState extends State<CandidateHomeFeed> with SingleTickerProviderStateMixin {

  Widget candidate = CandidateTabsV2();
  Widget jobs = CandidateJobsV2();
  Widget forYouTab = const CandidateForYou();
  Widget followingTab = const CandidatesFollowing();
  late int initialIndex = 0;
  late TabController _tabController;
  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    _tabController = TabController(length: 4, vsync: this) ;
    _tabController.addListener(_handleTabSelection);
  }



  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }


  void _handleTabSelection() {
    // Ensure the event is triggered on both tab tap and swipe
    if (_tabController.index != _previousIndex) {
      _previousIndex = _tabController.index;
      context.read<CandidateHomeFeedBloc>().add(HomeFeedTabChange(index: _tabController.index));
    }
  }
  @override
  Widget build(BuildContext context) {
    final pages = [
      CandidateFeedTab(title: "Candidates", widget: candidate),
   CandidateFeedTab(title: "Jobs", widget: jobs),
      CandidateFeedTab(title: "For You", widget: forYouTab),
      //  if (state.followingFeeds.isNotEmpty)
      CandidateFeedTab(title: "Following", widget: followingTab),
    ];
    return DefaultTabController(

      length: pages.length,
      initialIndex: initialIndex,
      child: Scaffold(
        backgroundColor: ColorConstant.tabSurface,
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              TabBarView(
                controller: _tabController,
                key: const Key("VideoFeedTabs"),
                // physics: const NeverScrollableScrollPhysics(),
                children: pages.map((e) => e.widget).toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      child: TabBar(
                        controller: _tabController,
                        padding: EdgeInsets.zero,
                        isScrollable: true,
                        indicatorColor: ColorConstant.shade00,
                        dividerColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: ColorConstant.shade00,
                        labelStyle: BaseTextStyle(
                          fontSize: TypographyTheme.paragraph_p2,
                          color: ColorConstant.shade00,
                          fontWeight: FontWeight.w600,
                        ),
                        indicatorPadding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 6.0),
                        labelPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0.0),
                        tabs:
                            pages.map((page) => Tab(text: page.title)).toList(),
                        onTap: (index) {
                          context.read<CandidateHomeFeedBloc>().add( HomeFeedTabChange(index: index)) ;
                          debugPrint("The index is $index");
                          setState(() {
                            initialIndex = index;
                          });
                        },

                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
