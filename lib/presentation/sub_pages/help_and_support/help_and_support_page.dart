import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/sub_pages/help_and_support/subpage/provide_feedback_subpage.dart';
import 'package:highlite_flutter_mvp/presentation/sub_pages/help_and_support/subpage/report_problem_subpage.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../widgets/list/navigated_tile.dart';
import '../../widgets/navigation/navigated_page.dart';
import 'bloc/report_feedback_bloc.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigatedPage(
      title: "Help & Support",
      includesBorder: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              NavigatedTile(
                  title: "Contact Support",
                  onTap: () {
                    context.navigator.push(MaterialPageRoute(
                      builder: (_) => BlocProvider<ReportFeedbackBloc>(
                        create: (_)=> ReportFeedbackBloc(),
                        child: const ProvideFeedbackSubpage(heading: 'Contact Support',),
                      ),
                    ));
                  }),
              const Divider(color: ColorConstant.neutral100,),
              NavigatedTile(
                  title: "Provide Feedback",
                  onTap: () {
                    context.navigator.push(MaterialPageRoute(
                      builder: (_) =>BlocProvider<ReportFeedbackBloc>(
                        create: (_)=> ReportFeedbackBloc(),
                        child: const ReportProblemSubpage(),
                      ),
                    ));
                  }),
              const Divider(color: ColorConstant.neutral100,),
            ],
          ),
        ),
      ),
    );
  }
}
