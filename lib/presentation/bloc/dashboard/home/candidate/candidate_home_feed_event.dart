import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

abstract class CandidateHomeFeedEvent {
  const CandidateHomeFeedEvent();
}

class StartCandidateHomeFeedEvent extends CandidateHomeFeedEvent {
  const StartCandidateHomeFeedEvent();
}

class PopulateFollowingFeedEvent extends CandidateHomeFeedEvent {
  const PopulateFollowingFeedEvent();
}

class BottomNavTabChanged extends CandidateHomeFeedEvent{
  int index ;
  BottomNavTabChanged({required this.index}) ;

}
class HomeFeedTabChange extends CandidateHomeFeedEvent{
  int index ;
  HomeFeedTabChange({required this.index}) ;
}

class NavigateCandidateHomeFeedEvent extends CandidateHomeFeedEvent {
  const NavigateCandidateHomeFeedEvent({
   required this.pageNumber

  });
  final int  pageNumber;
}

class NavigateCandidateFollowingHomeFeedEvent extends CandidateHomeFeedEvent {
  const NavigateCandidateFollowingHomeFeedEvent(
    this.pageNumber,
  );
  final int pageNumber;
}

class FollowCompanyEvent extends CandidateHomeFeedEvent {
  const FollowCompanyEvent(
    this.companyId,
  );
  final String companyId;
}

class FollowCompanyStateEvent extends CandidateHomeFeedEvent {
  const FollowCompanyStateEvent();
}

class UnfollowCompanyEvent extends CandidateHomeFeedEvent {
  const UnfollowCompanyEvent(
    this.companyId,
  );
  final String companyId;
}

class UnfollowCompanyStateEvent extends CandidateHomeFeedEvent {
  const UnfollowCompanyStateEvent();
}

class PlayVideo  extends CandidateHomeFeedEvent{
  const PlayVideo() ;
}

class PauseVideo extends CandidateHomeFeedEvent{
  const PauseVideo() ;
}

class ChangeTab extends CandidateHomeFeedEvent{
  final int currentTabIndex ;
  const ChangeTab({required this.currentTabIndex}) ;
}

class SwitchTabCandidateVideoFeedEvent extends CandidateHomeFeedEvent {
  const SwitchTabCandidateVideoFeedEvent(this.tab);
  final int tab;
}

class UnmarkBookmarkCandidateVideoFeedEvent extends CandidateHomeFeedEvent {
  const UnmarkBookmarkCandidateVideoFeedEvent(this.id);
  final String id;
}
class RetrieveBookmarksCandidateVideoFeedEvent extends CandidateHomeFeedEvent {
  const RetrieveBookmarksCandidateVideoFeedEvent();
}
