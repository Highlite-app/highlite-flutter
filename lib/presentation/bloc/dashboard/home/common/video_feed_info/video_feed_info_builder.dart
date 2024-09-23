// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../../data/models/apis/dashboard/company/highlite_company_profile.dart';
// import '../../../../../../data/models/apis/onboarding/candidate/highlite_candidate.dart';
// import '../../../../../../data/models/apis/onboarding/company/highlite_company_job_feed.dart';
// import '../../../../../../data/models/apis/onboarding/company/highlite_company_job_post.dart';
// import 'video_feed_info_bloc.dart';
// import 'video_feed_info_event.dart';
// import 'video_feed_info_state.dart';
//
// class VideoFeedInfoBuilderWidget extends StatelessWidget {
//   final Widget Function(BuildContext, VideoFeedInfoState) builder;
//   const VideoFeedInfoBuilderWidget({super.key, required this.builder});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<VideoFeedInfoBloc, VideoFeedInfoState>(
//       builder: builder,
//     );
//   }
// }
//
// class VideoFeedInfoProviderWidget extends StatefulWidget {
//   final Widget child;
//   final CandidateOnBoarding candidate;
//   final HighliteCompanyProfile company;
//   final HighliteCompanyJobFeed jobPost;
//
//   const VideoFeedInfoProviderWidget({
//     super.key,
//     required this.child,
//     required this.candidate,
//     required this.company,
//     required this.jobPost,
//   });
//
//   @override
//   State<VideoFeedInfoProviderWidget> createState() =>
//       _VideoFeedInfoProviderWidgetState();
// }
//
// class _VideoFeedInfoProviderWidgetState
//     extends State<VideoFeedInfoProviderWidget> {
//   final bloc = VideoFeedInfoBloc();
//   @override
//   void dispose() {
//     for (var subscription in bloc.subscriptions) {
//       subscription.cancel();
//     }
//     bloc.subscriptions = [];
//     bloc.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<VideoFeedInfoBloc>(
//       lazy: true,
//       create: (ctx) {
//         return bloc
//           ..add(
//             FetchVideoFeedInfoEvent(
//               candidate: widget.candidate,
//               company: widget.company,
//               jobPost: widget.jobPost,
//             ),
//           );
//       },
//       child: widget.child,
//     );
//   }
// }
//
// class VideoFeedInfoProviderForCompanyWidget extends StatefulWidget {
//   final Widget child;
//   final CandidateOnBoarding candidate;
//   final HighliteCompanyProfile company;
//   final List<HighliteCompanyJobPost> jobPost;
//
//   const VideoFeedInfoProviderForCompanyWidget({
//     super.key,
//     required this.child,
//     required this.candidate,
//     required this.company,
//     required this.jobPost,
//   });
//
//   @override
//   State<VideoFeedInfoProviderForCompanyWidget> createState() =>
//       _VideoFeedInfoProviderForCompanyWidgetState();
// }
//
// class _VideoFeedInfoProviderForCompanyWidgetState
//     extends State<VideoFeedInfoProviderForCompanyWidget> {
//   final bloc = VideoFeedInfoBloc();
//   @override
//   void dispose() {
//     bloc.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<VideoFeedInfoBloc>(
//       lazy: true,
//       create: (ctx) {
//         return bloc
//           ..add(
//             FetchVideoFeedInfoForCompanyEvent(
//               candidate: widget.candidate,
//               company: widget.company,
//               jobPost: widget.jobPost,
//             ),
//           );
//       },
//       child: widget.child,
//     );
//   }
// }
