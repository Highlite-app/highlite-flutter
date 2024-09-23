import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/sub_pages/help_and_support/bloc/report_feedback_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/sub_pages/help_and_support/bloc/report_feedback_state.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../../core/resources/l10n/translation_key.dart';
import '../../../widgets/buttons/button_stack.dart';
import '../../../widgets/buttons/default_button.dart';
import '../../../widgets/chat/chat_responder.dart';
import '../../../widgets/drawer/content/content_subpage.dart';
import '../../../widgets/text_field/form_field.dart';

class ReportProblemSubpage extends StatefulWidget {
  const ReportProblemSubpage({super.key});

  @override
  State<ReportProblemSubpage> createState() => _ReportProblemSubpageState();
}

class _ReportProblemSubpageState extends State<ReportProblemSubpage> {
  TextEditingController provideFeedbackController =
      TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportFeedbackBloc , ReportFeedbackState>(
        builder: (ctx, state) {
          return ContentContainer(
            title: "Provide Feedback",
            children: [
              CustomFormField(
                placeholderText: "I’ve having problem navigating...",
                height: MinMax(240, 240),
                textController: provideFeedbackController,
                textCapitalization: TextCapitalization.sentences,
                value: "",
              ),
              ButtonStack(
                widgets: [
                  DefaultButton(
                    title: TranslationKeys.cancel,
                    onTap: () {
                      ctx.navigator.pop();
                    },
                  ),
                  DefaultButton(
                    title: TranslationKeys.submit,
                    plain: false,
                    onTap: () {
                      if(provideFeedbackController.text.isNotEmpty){
                          // ctx
                          //       .read<ReportFeedbackBloc>()
                          //       .add(CreateReportFeedbackEvent(authV2Service.getEmailAddress(),
                          //               provideFeedbackController.text,
                          //               ReportFeedbackType.problem));
                          // ctx.navigator.pop();
                      }

                    },
                  ),
                ],
                alignment: MainAxisAlignment.end,
                direction: Axis.horizontal,
              ),
            ],
          );
        }
    );
  }

  // @override
  // void dispose() {
  //   provideFeedbackController.dispose();
  //   super.dispose();
  // }

}
