
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:highlite_flutter_mvp/app.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/routes/route_constants.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/project/project_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/pages/dashboard/candidate_dashboard.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/candidate/resume%20/upload_project_section.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/buttons/primary_button.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../widgets/text/heading_text.dart';
class ProjectConfirmation extends StatelessWidget {
  const ProjectConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body:   Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         const  Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.0),
            child:  HeadingText(
              headingText: TranslationKeys.projectConfirmation,
              subHeading: TranslationKeys.subHeading,
            ),
          ),
          const SizedBox(height: 24.0) ,
          Row(children: [
            Expanded(child:
            PrimaryButton(
              title: 'Continue' ,
              size: PrimaryButtonSize.custom,
              horizontalButtonPadding: 70,
              verticalButtonPadding: 8,
              expandType: ExpandButtonType.horizontal,
              buttonStyle: PrimaryButtonStyle.bordered,
              textColor: ColorConstant.primary900,
              onTap: (){
                context.navigator.push(MaterialPageRoute(builder: (_)=> BlocProvider<UploadProjectBloc>(
                    create: (_)=> UploadProjectBloc(),
                    child: const UploadProjectSection())));
              },
            )) ,
            Expanded(child:
            PrimaryButton(
              title: 'Skip' ,
              size: PrimaryButtonSize.custom,
              horizontalButtonPadding: 50 ,
              verticalButtonPadding: 15,
              textColor: ColorConstant.primary900,
              onTap: (){
            globalNavKey.currentState?.push(MaterialPageRoute(builder:(context)=> CandidateDashboard())) ;
              },
            ))
          ],)
        ],

      ),
    );
  }
}
