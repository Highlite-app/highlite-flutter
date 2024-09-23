import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/about/candidate_about_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chat/chat_responder.dart';

import 'upload_about_section.dart';

class UploadResume extends StatelessWidget {
  const UploadResume({super.key});

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
        body: BlocProvider<CandidateUploadAboutBloc>(
      create: (context) => CandidateUploadAboutBloc(),
      child: UploadCandidateAboutSection(
        languages: languages,
        maxLanguageSelection: MinMax(0, 3),
        onSubmitSelectedLanguage: (List<String> selectedLanguage) {},
      ),
    ));
  }
}
