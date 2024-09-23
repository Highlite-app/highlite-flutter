
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/routes/route_constants.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/onboarding/on_boarding_chat_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/pages/dashboard/candidate_dashboard.dart';
import 'package:highlite_flutter_mvp/presentation/pages/dashboard/company_dashboard.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/candidate/resume%20/upload%20_resume.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/candidate/upload_candidate.dart';
import 'package:highlite_flutter_mvp/presentation/pages/onboarding/onboarding_chat_screen.dart';
import 'package:highlite_flutter_mvp/presentation/sub_pages/help_and_support/bloc/report_feedback_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/sub_pages/help_and_support/subpage/provide_feedback_subpage.dart';
import '../../presentation/bloc/splash/on_boarding_spalsh_bloc.dart';
import '../../presentation/pages/onboarding/onboarding_splash_screen.dart';
import '../../presentation/sub_pages/help_and_support/subpage/report_problem_subpage.dart';

class Routes{

  static Map<String , Widget Function(BuildContext)> get routes =>
      {
        RouteConstants.onBoardingSplash: (context) => BlocProvider(
          create: (_)=> OnBoardingSplashBloc(),
          child: const OnboardingSplash()
        ),

       RouteConstants.onBoardingChat : (context) => BlocProvider(
         create: (_)=> OnBoardingChatBloc() ,
         child: const  OnBoardingChatScreen(loginFlow: false)
       ),

        RouteConstants.onBoardingChatLogin : (context) => BlocProvider(
            create: (_)=> OnBoardingChatBloc() ,
            child: const  OnBoardingChatScreen(loginFlow: true)
        ),

      RouteConstants.provideFeedbackSubpage: (context) => BlocProvider(
          create: (_)=> ReportFeedbackBloc(),
         child: ProvideFeedbackSubpage(),
      ),

        RouteConstants.reportFeedbackSubpage: (context)=> BlocProvider(
            create: (_)=> ReportFeedbackBloc(),
           child: ReportProblemSubpage(),
        ),

        RouteConstants.candidateDashboard: (context)=> const CandidateDashboard(),
        RouteConstants.companyDashboard: (context)=> const CompanyDashboard(),
        RouteConstants.uploadResume: (context)=> const UploadResume()



      };

}