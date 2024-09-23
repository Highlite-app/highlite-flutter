// import 'dart:async';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get_connect/http/src/response/response.dart';
// import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
//
// import '../../../../../../core/constants/user_types.dart';
// import '../../../../../../data/models/apis/dashboard/common/highlite_video_feed_info.dart';
// import '../../../../../../data/models/apis/dashboard/common/lookup/lookup.dart';
// import '../../../../../../data/models/apis/onboarding/bookmark/highilte_bookmark_info.dart';
// import '../../../../../../domain/repositories/dashboard/candidate/home/home_feed_state_repository.dart';
// import '../../../../../widgets/toaster/toast_alert.dart';
// import '../../../../toast/toast_bloc.dart';
// import '../../../../toast/toast_event.dart';
// import 'video_feed_info_event.dart';
// import 'video_feed_info_state.dart';
//
// class VideoFeedInfoBloc extends Bloc<VideoFeedInfoEvent, VideoFeedInfoState> {
//   List<StreamSubscription<GraphQLResponse<dynamic>>> subscriptions = [];
//   VideoFeedInfoBloc() : super(VideoFeedInfoState()) {
//     on<FetchVideoFeedInfoEvent>(
//       (event, emit) async {
//         if (!state.initialized) {
//           emit(
//             state.copyWith(
//               candidate: event.candidate,
//               company: event.company,
//               jobPost: event.jobPost,
//             ),
//           );
//           final info = await videoFeedInfoIntegratedService.fetchBy(
//             event.candidate.id,
//             event.company.id,
//             event.jobPost.id,
//           );
//           final lookups = lookupStateService.get(
//               event.candidate.id, event.company.id, event.jobPost.id);
//
//           StreamSubscription<GraphQLResponse<dynamic>>? subscription =
//               videoFeedInfoService.getInfoSubscription(info.id, (info) {
//             try {
//               add(EmitVideoFeedInfoEvent(info));
//             } catch (e) {
//               for (var subscription in subscriptions) {
//                 subscription.cancel();
//               }
//               subscriptions = [];
//             }
//           });
//           subscriptions = List.from([subscription]);
//           emit(state.copyWith(info: info, lookups: lookups));
//           emit(state.copyWith(isLoading: false, initialized: true));
//         }
//         emit(
//           state.copyWith(
//             bookmarkCollections:
//                 homeFeedState.currentUserBookmarkCollectionList,
//             bookmarkInfos: homeFeedState.currentUserBookmarkInfoList,
//           ),
//         );
//       },
//     );
//     on<FetchVideoFeedInfoForCompanyEvent>(
//       (event, emit) async {
//         if (!state.initialized) {
//           emit(
//             state.copyWith(
//               candidate: event.candidate,
//               company: event.company,
//               jobPosts: event.jobPost,
//             ),
//           );
//           List<HighliteVideoFeedInfo> infos = [];
//           List<HighliteLookup> lookups = [];
//           for (var jobPost in event.jobPost) {
//             final info = await videoFeedInfoIntegratedService.fetchBy(
//               event.candidate.id,
//               event.company.id,
//               jobPost.id,
//             );
//             final lookup = lookupStateService.get(
//                 event.candidate.id, event.company.id, jobPost.id);
//             lookups.addAll(lookup);
//             StreamSubscription<GraphQLResponse<dynamic>>? subscription =
//                 videoFeedInfoService.getInfoSubscription(info.id, (info) {
//               try {
//                 add(EmitVideoFeedInfoForCompanyEvent(info));
//               } catch (e) {
//                 for (var subscription in subscriptions) {
//                   subscription.cancel();
//                 }
//                 subscriptions = [];
//               }
//             });
//             infos.add(info);
//             subscriptions.add(subscription);
//           }
//           emit(state.copyWith(
//             infos: infos,
//             lookups: lookups,
//           ));
//           emit(state.copyWith(isLoading: false, initialized: true));
//         }
//         emit(
//           state.copyWith(
//             bookmarkCollections:
//                 homeFeedState.currentUserBookmarkCollectionList,
//             bookmarkInfos: homeFeedState.currentUserBookmarkInfoList,
//           ),
//         );
//       },
//     );
//     on<EmitVideoFeedInfoEvent>(
//       (event, emit) async {
//         emit(state.copyWith(info: event.info));
//         if (event.info.status == VideoFeedInfoStatus.matched) {
//           toaster.add(
//             const ShowToastEvent(
//               text: "You've got a new match",
//               state: ToastState.normal,
//               duration: Duration(seconds: 3),
//             ),
//           );
//         }
//       },
//     );
//     on<EmitVideoFeedInfoForCompanyEvent>(
//       (event, emit) async {
//         final infos = state.infos;
//         final index = infos!.indexWhere((e) => e.id == event.info.id);
//         infos[index] = event.info;
//         emit(state.copyWith(infos: infos));
//         if (event.info.status == VideoFeedInfoStatus.matched) {
//           toaster.add(
//             const ShowToastEvent(
//               text: "You've got a new match",
//               state: ToastState.normal,
//               duration: Duration(seconds: 3),
//             ),
//           );
//         }
//       },
//     );
//     on<UpdateVideoFeedInfoEvent>(
//       (event, emit) async {
//         emit(state.copyWith(info: event.info));
//         final newInfo = await videoFeedInfoService.updateVideoFeedInfo(
//           event.info,
//         );
//         emit(state.copyWith(info: newInfo));
//         add(const CheckMatchEvent());
//       },
//     );
//     on<LikeVideoFeedEvent>(
//       (event, emit) async {
//         emit(state.copyWith(isLoading: true));
//         if (state.info != null) {
//           if (authService.persistedUser!.userType == UserTypes.candidate) {
//             final info = state.info!.copyWith(
//                 candidateLiked: !state.info!.candidateLiked,
//                 candidateDisliked: false);
//             if (info.candidateLiked) {
//               centerPrompt
//                   .add(const ShowPromptEvent(asset: "like-02-selected"));
//             }
//             add(UpdateVideoFeedInfoEvent(info));
//           }
//         }
//       },
//     );
//     on<DislikeVideoFeedEvent>(
//       (event, emit) async {
//         if (state.info != null) {
//           final info = state.info!.copyWith(
//               candidateDisliked: !state.info!.candidateDisliked,
//               candidateLiked: false);
//           if (info.candidateDisliked) {
//             centerPrompt
//                 .add(const ShowPromptEvent(asset: "dislike-02-selected"));
//           }
//           add(UpdateVideoFeedInfoEvent(info));
//         }
//       },
//     );
//     on<LikeVideoFeedForCompanyBatchEvent>(
//       (event, emit) async {
//         for (var id in event.jobPostIds) {
//           emit(state.copyWith(isLoading: true));
//           if (state.infos != null) {
//             final index = state.infos!.indexWhere((e) => e.jobId == id);
//             final info = state.infos![index].copyWith(
//                 companyLiked: !state.infos![index].companyLiked,
//                 companyDisliked: false);
//             if (info.companyLiked) {
//               centerPrompt
//                   .add(const ShowPromptEvent(asset: "like-02-selected"));
//             }
//             final infos = state.infos;
//             final infoIndex = infos!.indexWhere((e) => e.id == info.id);
//             infos[infoIndex] = info;
//             emit(state.copyWith(infos: infos));
//             await videoFeedInfoService.updateVideoFeedInfo(
//               info,
//             );
//           }
//         }
//         add(const CheckMatchForCompanyEvent());
//       },
//     );
//
//     on<UnlikeVideoFeedForCompanyBatchEvent>(
//       (event, emit) async {
//         emit(state.copyWith(isLoading: true));
//         if (state.infos != null) {
//           final infos =
//               state.infos!.map((e) => e.copyWith(companyLiked: false)).toList();
//           emit(state.copyWith(infos: infos));
//           for (var info in infos) {
//             await videoFeedInfoService.updateVideoFeedInfo(
//               info,
//             );
//           }
//         }
//         emit(state.copyWith(isLoading: false));
//       },
//     );
//     on<UndislikeVideoFeedForCompanyBatchEvent>(
//       (event, emit) async {
//         emit(state.copyWith(isLoading: true));
//         if (state.infos != null) {
//           final infos = state.infos!
//               .map((e) => e.copyWith(companyDisliked: false))
//               .toList();
//           emit(state.copyWith(infos: infos));
//           for (var info in infos) {
//             await videoFeedInfoService.updateVideoFeedInfo(
//               info,
//             );
//           }
//         }
//         emit(state.copyWith(isLoading: false));
//       },
//     );
//
//     on<DislikeVideoFeedForCompanyBatchEvent>(
//       (event, emit) async {
//         for (var id in event.jobPostIds) {
//           add(DislikeVideoFeedForCompanyEvent(id));
//         }
//       },
//     );
//     on<DislikeVideoFeedForCompanyEvent>(
//       (event, emit) async {
//         if (state.infos != null) {
//           final index =
//               state.infos!.indexWhere((e) => e.jobId == event.jobPostId);
//           final info = state.infos![index].copyWith(
//             companyDisliked: !state.infos![index].companyDisliked,
//             companyLiked: false,
//           );
//           if (info.companyDisliked) {
//             centerPrompt
//                 .add(const ShowPromptEvent(asset: "dislike-02-selected"));
//           }
//           add(UpdateVideoFeedInfoForCompanyEvent(info));
//         }
//       },
//     );
//
//     on<UpdateVideoFeedInfoForCompanyEvent>(
//       (event, emit) async {
//         final infos = state.infos;
//         final index = infos!.indexWhere((e) => e.id == event.info.id);
//         infos[index] = event.info;
//         emit(state.copyWith(infos: infos));
//         await videoFeedInfoService.updateVideoFeedInfo(
//           event.info,
//         );
//       },
//     );
//     on<CheckMatchForCompanyEvent>(
//       (event, emit) async {
//         if (state.infos != null) {
//           final listOfMatches = state.infos!
//               .where((e) =>
//                   e.candidateLiked &&
//                   e.companyLiked &&
//                   e.status != VideoFeedInfoStatus.matched)
//               .toList();
//           if (listOfMatches.isNotEmpty) {
//             HighliteMessageChannel? channel;
//             for (var match in listOfMatches) {
//               final newInfo = await videoFeedInfoService.updateVideoFeedInfo(
//                 match.copyWith(
//                   status: VideoFeedInfoStatus.matched,
//                 ),
//               );
//               channel = await inboxStateService.createMatchedChannel(
//                   match.currentCandidateId,
//                   match.currentCompanyId,
//                   match.jobId);
//               final infos = state.infos;
//               final index = infos!.indexWhere((e) => e.id == match.id);
//               infos[index] = newInfo;
//               emit(state.copyWith(infos: infos));
//             }
//             if (channel != null) {
//               globalNavKey.currentState!.push(
//                 MaterialPageRoute(
//                   builder: (_) => NewMatchPage(
//                     candidate: state.candidate!.asInfo(),
//                     company: state.company!,
//                     isCompanyMatch: false,
//                     channel: channel!,
//                   ),
//                 ),
//               );
//             }
//           }
//         }
//         emit(state.copyWith(isLoading: false));
//       },
//     );
//     on<CheckMatchEvent>(
//       (event, emit) async {
//         final info = await videoFeedInfoIntegratedService.fetchBy(
//           state.candidate!.id,
//           state.company!.id,
//           state.jobPost!.id,
//         );
//         emit(state.copyWith(info: info));
//         if (state.info != null) {
//           if (state.info!.candidateLiked &&
//               state.info!.companyLiked &&
//               state.info!.status != VideoFeedInfoStatus.matched) {
//             final newInfo = await videoFeedInfoService.updateVideoFeedInfo(
//               state.info!.copyWith(
//                 status: VideoFeedInfoStatus.matched,
//               ),
//             );
//             HighliteMessageChannel? channel =
//                 await inboxStateService.createMatchedChannel(
//                     state.candidate!.id, state.company!.id, state.jobPost!.id);
//             emit(state.copyWith(info: newInfo));
//             if (channel != null) {
//               globalNavKey.currentState!.push(
//                 MaterialPageRoute(
//                   builder: (_) => NewMatchPage(
//                     candidate: state.candidate!.asInfo(),
//                     company: state.company!,
//                     post: state.jobPost!,
//                     isCompanyMatch: true,
//                     channel: channel,
//                   ),
//                 ),
//               );
//             }
//           }
//         }
//         emit(state.copyWith(isLoading: false));
//       },
//     );
//     on<SuperMessageEvent>(
//       (event, emit) async {
//         final canSuperMessage = await userSubStorage.isValidForSuperMessage();
//         if (canSuperMessage) {
//           await inboxStateService.createSuperMessageChannel(state.candidate!.id,
//               state.company!.id, event.jobPostId, event.message);
//           final lookups = state.lookups;
//           final lookup = lookupStateService.get(
//               state.candidate!.id, state.company!.id, event.jobPostId);
//           lookups.addAll(lookup);
//           emit(state.copyWith(lookups: lookups));
//         } else {
//           toaster.add(
//             ShowToastEvent(
//               title: "Insufficient Super Message Balance",
//               text: "Your Super Message cannot be sent.",
//               icon: "insufficient-super-message",
//               link: "Tap here to buy more.",
//               linkAction: () {
//                 dashboardNavKey.currentState?.push(
//                   MaterialPageRoute(
//                     builder: (_) => const UpgradeSubscriptionPage(),
//                   ),
//                 );
//               },
//               state: ToastState.insufficientAlert,
//               duration: const Duration(seconds: 3),
//             ),
//           );
//         }
//       },
//     );
//     on<UnmarkBookmarkFeedEvent>((event, emit) async {
//       logger.logEvent("videofeed event id: ${event.id}");
//
//       List<HighliteBookmarkCollection> bookmarkCollections =
//           state.bookmarkCollections;
//
//       List<HighliteBookmarkInfo> bookmarkInfos = state.bookmarkInfos;
//
//       int index = bookmarkInfos
//           .indexWhere((element) => element.referenceID == event.id);
//
//       logger.logEvent("index: $index");
//
//       if (index > -1) {
//         logger.logEvent(
//             "bookmarkInfos[index].bookmarkCollectionID: ${bookmarkInfos[index].id}");
//
//         HighliteBookmarkInfo deletedItem = await bookmarkCollectionService
//             .unmarkBookmark(bookmarkInfos[index].id);
//
//         logger.logEvent("deletedItem: $deletedItem");
//
//         bookmarkInfos.removeWhere((item) => item.id == deletedItem.id);
//         homeFeedState.currentUserBookmarkInfoList
//             .removeWhere((item) => item.id == deletedItem.id);
//       }
//       emit(state.copyWith(
//           isProfileBookmark: false,
//           bookmarkCollections: bookmarkCollections,
//           bookmarkInfos: bookmarkInfos));
//     });
//     on<RetrieveBookmarksEvent>((event, emit) async {
//       List<HighliteBookmarkInfo> bookmarkInfos = state.bookmarkInfos;
//
//       emit(state.copyWith(
//         isAdded: homeFeedState.currentUserBookmarkInfoList.length >
//                 bookmarkInfos.length
//             ? true
//             : false,
//         bookmarkCollections: homeFeedState.currentUserBookmarkCollectionList,
//         bookmarkInfos: homeFeedState.currentUserBookmarkInfoList,
//       ));
//     });
//   }
//
//   @override
//   Future<void> close() async {
//     for (var subscription in subscriptions) {
//       subscription.cancel();
//     }
//     subscriptions = [];
//     logger.logEvent("Closing subscriptions");
//     super.close();
//   }
// }
