import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/about/candidate_about_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/company/about/company_upload_info_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/candidate/resume%20/upload_project_section.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/company/upload%20information/upload_company_about_section.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chat/chat_responder.dart';


class UploadInformation extends StatelessWidget {
  const UploadInformation({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> languages = [
      "English",
      "Hindi",
      "Spanish",
      "French",
      "German",
      "Chinese",
      "Japanese",
      "Korean",
      "Russian",
      "Italian",
      "Portuguese",
      "Dutch",
      "Greek",
      "Turkish",
      "Arabic",
      "Hebrew",
      "Swedish",
      "Norwegian",
      "Danish",
      "Finnish",
      "Polish",
      "Czech",
      "Hungarian",
      "Thai",
      "Vietnamese",
      "Indonesian",
      "Malay",
      "Filipino",
      "Urdu",
      "Bengali",
      "Tamil",
    ];

    return Scaffold(
        body: BlocProvider<CompanyUploadInfoBloc>(
          create: (context)=> companyUploadInfoBloc,
          child: UploadCompanyAboutSection(
            languages: languages,
            maxLanguageSelection: MinMax(0, 3),
            onSubmitSelectedLanguage: (List<String> selectedLanguage) {},
          ),

          //  const UploadProjectSection()


        ));
  }
}
