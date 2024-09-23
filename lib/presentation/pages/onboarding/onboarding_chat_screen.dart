import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/login/login_flow/login_flow.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/onboarding/on_boarding_chat_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/onboarding/onboarding_chat_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/onboarding/onboarding_chat_state.dart';
import '../../../core/resources/typography_theme.dart';
import '../../../data/models/onboardingChat/flows/general/general_flow.dart';
import '../../widgets/chat/chat_bubble.dart';
import '../../widgets/constants/text_style.dart';
import '../../widgets/onboarding/onboarding_chat_widget.dart';

class OnBoardingChatScreen extends StatelessWidget {
  final bool loginFlow;
  const OnBoardingChatScreen({super.key, required this.loginFlow});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingChatBloc , OnBoardingChatState>(
      builder: (context, state) => OnboardingChatWidget(
        messages: state.messages,
        chatRespondent: state.chatRespondent,
        showIndicator: state.showIndicator,
        isLogin: loginFlow,
        onLoadChat: () {
          if (loginFlow) {
            context.read<OnBoardingChatBloc>().add(
              OnboardingChatStartEvent(
                [
                  LoginFlow(
                    initialStep: 0,
                    ignoreLoginMessage: false,
                  ),
                ],
              ),
            );
          } else {
            context
                .read<OnBoardingChatBloc>()
                .add(OnboardingChatStartEvent([GeneralFlow(initialStep: 0)]));
          }
        },
        onSendMessage: (message) {
          context
              .read<OnBoardingChatBloc>()
              .add(OnboardingSendChatEvent(message));
        },
        onEdit: (message, index) async {
          debugPrint("OnEdit");
          await _showEditDialog(context, message);
        },
        enabledRefresh: !state.resetable,
      ),
    );
  }

  Future<void> _showEditDialog(BuildContext ctx, ChatMessage message) async {
    await showCupertinoModalPopup<void>(
      context: ctx,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title:  Text(
          "Are you sure?",
          style: BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p1,
            color: ColorConstant.neutral800,
            fontWeight: FontWeight.w700,
          ),
        ),
        content:  Text(
          "This will delete your answer and take you back to the previous step.",
          style: BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p4,
            color: ColorConstant.neutral800,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () async {
              Navigator.of(context).pop();
            },
            child: Text(
              TranslationKeys.cancel,
              style:  BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p2,
                color: ColorConstant.primary500,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              ctx.read<OnBoardingChatBloc>()
                  .add(OnboardingPreviousStepEvent(message));
              Navigator.of(context).pop();
            },
            child:  Text(
              "Edit",
              style: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p2,
                color: ColorConstant.primary500,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
