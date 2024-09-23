import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_state.dart';
import 'package:highlite_flutter_mvp/presentation/sub_pages/settings/phone_number_subpage.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../core/constants/user_types.dart';
import '../../widgets/drawer/content/content_subpage.dart';
import '../../widgets/profile/edit_profile/form/profile_editor_form_item.dart';
import '../../widgets/text_field/action_field.dart';
import 'email_address_subpage.dart';

class AccountInfoPage extends StatelessWidget {
  const AccountInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc , AuthenticationState>(
      builder: (context , authState) {
        return ContentContainer(
          title: "Account Info",
          children: [
            // ProfileEditorFormItem(
            //   label: "Your phone number",
            //   padded: false,
            //   spaced: true,
            //   children: ActionField(
            //     submitText: "Change",
            //     placeholderText: "Your phone number",
            //     value: '6291385125',
            //     // authState.userType == UserTypes.candidate
            //     //     ? authState.candidate?.phoneNumber ?? ""
            //     //     : authState.companyUserProfile?.phoneNumber ?? "",
            //     onTap: () {
            //       context.navigator.push(MaterialPageRoute(
            //         builder: (_) => const PhoneNumberSubpage(),
            //       ));
            //     },
            //   ),
            // ),
            // const SizedBox(height: 16.0),
            ProfileEditorFormItem(
              label: "Your email address",
              padded: false,
              spaced: true,
              children: ActionField(
                submitText: "Change",
                placeholderText: "Your email address",
                value: authState.userType == UserTypes.candidate
                    ? authState.candidate?.email ?? ""
                    : authState.companyProfile?.email ?? "",
                onTap: () {
                  context.navigator.push(MaterialPageRoute(
                    builder: (_) => const EmailAddressSubpage(),
                  ));
                },
              ),
            )
          ],
        );
      }
    );
  }
}
