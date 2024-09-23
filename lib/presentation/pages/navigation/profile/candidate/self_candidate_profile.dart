import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_state.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_state.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/profile/candidate/candidate_profile_v2.dart';
import '../../../../../data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';
import 'candidate_profile.dart';

class SelfCandidateProfile extends StatelessWidget {
  const SelfCandidateProfile({super.key});

  @override
  Widget build(BuildContext context) {


  return BlocBuilder<AuthenticationBloc , AuthenticationState>(
    builder: (context , authState) {
      return BlocProvider<CandidateEditorBloc>(
        create: (_)=>CandidateEditorBloc(
            candidate: authState.candidate,
            videoFeed: authState.candidateVideoFeed,
        )..add(const CandidateEditorStartEvent()),
        child: BlocBuilder<CandidateEditorBloc ,CandidateEditorState >(
          builder: (context , state) {
            return CandidateProfileV2(
                      candidateOnBoarding: state.candidateOnBoarding ,



            );
          }
        ),
      );
    }
  );
  }
}
