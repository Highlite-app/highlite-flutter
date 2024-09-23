import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../widgets/buttons/button_stack.dart';
import '../../widgets/buttons/default_button.dart';
import '../../widgets/chat/chat_responder.dart';
import '../../widgets/drawer/content/content_subpage.dart';
import '../../widgets/form/form.dart';
import '../../widgets/profile/edit_profile/form/profile_editor_form_field.dart';

class EmailAddressSubpage extends StatefulWidget {
  const EmailAddressSubpage({super.key});

  @override
  State<EmailAddressSubpage> createState() => _EmailAddressSubpageState();
}

class _EmailAddressSubpageState extends State<EmailAddressSubpage> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<FormProviderState> formState =
      ValueNotifier(FormProviderState.empty);
  TextEditingController emailController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      title: "Change your email address",
      children: [
        FormProvider(
          formKey: _formKey,
          formState: formState,
          builder: (formState) => ProfileEditorFormField(
            label: "Please enter your new email address",
            formState: formState,
            placeholderText: "Email address",
            height: MinMax(50, 50),
            spaced: true,
            textController: emailController,
            textCapitalization: TextCapitalization.sentences,
            value: 'srijanmukhopadhyay9@gmail.com',
            //   authState.userType == UserTypes.candidate
            // ? authState.candidate?.emailAddress ?? ""
            // : authState.companyUserProfile?.emailAddress ?? "",
            validator:
                ValidationBuilder(requiredMessage: "Please add a valid email.")
                    .build(),
          ),
        ),
        ButtonStack(
          widgets: [
            DefaultButton(
              title: TranslationKeys.cancel,
              onTap: () {
                context.navigator.pop();
              },
            ),
            DefaultButton(
              title: "Send verification link",
              plain: false,
              onTap: () {
                // final label = emailController.text;
                // context.read<SettingsBloc>().add(SendOTPForChange(
                //     sendTo: emailController.text,
                //     signInOption: SignInOption.emailAddress));
                // context.navigator.push<bool>(
                //   MaterialPageRoute(
                //     builder: (_) => OTPSubpage(
                //       title: "Change your email address",
                //       label: label,
                //       targetChange: "email address",
                //     ),
                //   ),
                // );
              },
            ),
          ],
          alignment: MainAxisAlignment.end,
          direction: Axis.horizontal,
        ),
      ],
    );
  }
}
