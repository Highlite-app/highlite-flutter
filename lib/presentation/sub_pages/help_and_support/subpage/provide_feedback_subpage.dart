import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/presentation/sub_pages/help_and_support/bloc/report_feedback_state.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../../core/resources/typography_theme.dart';
import '../../../widgets/buttons/button_stack.dart';
import '../../../widgets/buttons/default_button.dart';
import '../../../widgets/chat/chat_responder.dart';
import '../../../widgets/constants/text_style.dart';
import '../../../widgets/drawer/content/content_subpage.dart';
import '../../../widgets/text_field/form_field.dart';
import '../bloc/report_feedback_bloc.dart';
import '../bloc/report_feedback_event.dart';

class ProvideFeedbackSubpage extends StatefulWidget {
  final String? heading  ;
  const ProvideFeedbackSubpage({
    this.heading ,
    super.key});

  @override
  State<ProvideFeedbackSubpage> createState() => _ProvideFeedbackSubpageState();
}

class _ProvideFeedbackSubpageState extends State<ProvideFeedbackSubpage> {
  TextEditingController provideFeedbackController =
      TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ReportFeedbackBloc , ReportFeedbackState>(
        builder: (ctx, state) {
          return ContentContainer(
            title: widget.heading ?? "Provide Feedback",
            children: [
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Your feedback will help us provide a better user experience",
                      style: BaseTextStyle(
                        fontSize: TypographyTheme.paragraph_p3,
                        color: ColorConstant.neutral700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
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
                          //               ReportFeedbackType.feedback));
                          //  ctx.navigator.pop();
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
