import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/candidate/candidate_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/candidate_home_feed_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/candidate_home_feed_event.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/home/candidate/tabs/candidate_following_tab.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/home/company/tabs/company_candidate_tab.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/home/company/tabs/company_for_you_tab.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/home/company/tabs/company_job.dart';

import '../../../../../core/resources/typography_theme.dart';
import '../../../../bloc/dashboard/home/candidate/candidate/candidate_event.dart';
import '../../../../bloc/dashboard/home/candidate/for_you/candidate_for_you_bloc.dart';
import '../../../../bloc/dashboard/home/candidate/for_you/candidate_for_you_event.dart';
import '../../../../widgets/constants/text_style.dart';

class CompanyFeedTab {
  final String title;
  final Widget widget;

  const CompanyFeedTab({required this.title, required this.widget});
}


class CompanyHomeFeedProvider extends StatelessWidget {
  final Widget child ;
  const CompanyHomeFeedProvider({
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


class CompanyHomeFeed extends StatefulWidget {
  const CompanyHomeFeed({super.key});

  @override
  State<CompanyHomeFeed> createState() => _CompanyHomeFeedState();
}

class _CompanyHomeFeedState extends State<CompanyHomeFeed> with SingleTickerProviderStateMixin {

  Widget candidate = CompanyCandidateTab();
  Widget jobs = CompanyJob();
  Widget forYouTab =  CompanyForYouTab();
  Widget followingTab = const CandidatesFollowing(); // WILL CHANGE ONCE NEW VIDEO PLAYER IS CREATED
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
      CompanyFeedTab(title: "Candidates", widget: candidate),
      CompanyFeedTab(title: "Jobs", widget: jobs),
      CompanyFeedTab(title: "For You", widget: forYouTab),
      //  if (state.followingFeeds.isNotEmpty)
      CompanyFeedTab(title: "Following", widget: followingTab),
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
