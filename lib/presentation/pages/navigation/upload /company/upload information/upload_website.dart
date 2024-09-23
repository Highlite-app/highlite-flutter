
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/company/about/comapany_upload_info_state.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/company/about/company_upload_info_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/candidate/resume%20/resume_navigation_page.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/company/upload%20information/our_service.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/text_field/text_field_with_button.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../widgets/chat/chat_responder.dart';
import '../../../../../widgets/chip/chip_with_button_section.dart';
import '../../../../../widgets/text/heading_text.dart';
class UploadWebsite extends StatelessWidget {
   UploadWebsite({super.key});

  final TextEditingController websiteController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  ResumeNavigation(
        children: [
          SafeArea(
            child: Padding(
              padding: const  EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeadingText(
                    headingText: TranslationKeys.website,
                    subHeading: TranslationKeys.subHeadingCompany,
                  ),
                  const SizedBox(height: 16.0) ,
                  _buildWebsiteFormSection(context)

                ],
              ),
            ),
          )
        ]);
  }

  Widget _buildWebsiteFormSection(BuildContext context) {
    return  BlocBuilder<CompanyUploadInfoBloc , CompanyUploadInfoState>(
      bloc: companyUploadInfoBloc,
      buildWhen: (previous, current) => previous.websiteController != current.websiteController,
      builder:(context , state) =>  UnderlinedTextFieldWithButton(
        controller:state.websiteController,
        isButtonEnable: true,
        labelText: 'website*',
        onTapNext: () {
          context.navigator.push(MaterialPageRoute(builder: (_)=>OurServices()));
        //  context.read<EmploymentBloc>().add(UpdateCurrentJobTitle(state.currentJobTitleController.text , true));
        }),
    );

  }
}


