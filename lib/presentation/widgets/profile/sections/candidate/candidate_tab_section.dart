import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/home/candidate_feed.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/bookmark/bookmark_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/bookmark/bookmark_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/bookmark/bookmark_state.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/bookmark/bookmark_page.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/svg/svg_asset.dart';

import '../../../../../data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';
import '../../../../../data/models/apis/dashboard/company/upload/company_job_post.dart';
import '../../../../../data/models/apis/onboarding/bookmark/response/bookmark_collection.dart';
import '../../../../../data/models/apis/onboarding/bookmark/response/bookmark_infos.dart';
import '../../../../../data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import '../../../../../data/models/apis/onboarding/company/company_onboarding.dart';
import '../../tabs/self_video/profile_video_tab.dart';

class CandidateTabSection extends StatefulWidget {
  final List<CandidateVideoFeed> candidateFeed ;
  final CandidateOnBoarding candidateOnBoarding ;
  final  List<BookmarkCollection> bookmarkCollection ;

  const CandidateTabSection({
    super.key,
    required this.candidateFeed,
    required this.candidateOnBoarding ,
   required this.bookmarkCollection ,
  });

  @override
  State<CandidateTabSection> createState() => _CandidateTabSectionState();
}

class _CandidateTabSectionState extends State<CandidateTabSection> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: ColorConstant.shade100,
              indicator: UnderlineTabIndicator(
                  borderSide:
                      BorderSide(width: 1, color: ColorConstant.shade100)),
              tabs: [
                Tab(
                    icon: SvgAsset(
                  asset: AssetConstant.dotIcon,
                  color: ColorConstant.shade100,
                  size: 24,
                )),
                Tab(
                    icon: SvgAsset(
                  asset: AssetConstant.bookmarkIcon,
                  color: ColorConstant.shade100,
                  size: 24,
                )),
                Tab(
                    icon: SvgAsset(
                  asset: AssetConstant.likOutlinedIcon,
                  color: ColorConstant.shade100,
                  size: 24,
                )),
              ]),
          Expanded(
            child: TabBarView(children: [
              ProfileVideoTab(candidateVideoFeed: widget.candidateFeed, candidateOnBoarding: widget.candidateOnBoarding,),
              BookmarkPage(
                collections: widget.bookmarkCollection,
              ),
              ProfileVideoTab(candidateVideoFeed: const [], candidateOnBoarding: widget.candidateOnBoarding,),
            // ProfileVideoTab(),
            ]),
          )
        ],
      ),
    );
  }
}
