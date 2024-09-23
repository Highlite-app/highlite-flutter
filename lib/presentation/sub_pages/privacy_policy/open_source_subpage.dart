import 'package:flutter/material.dart';

import '../../widgets/drawer/content/content_subpage.dart';

class OpenSourceSubpage extends StatelessWidget {
  const OpenSourceSubpage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ContentSubpage(
      title: "Open Source Libraries",
      content:
          "In 2022, finding a job is really hard. Hiring for a job is just as hard. Job matching shouldn’t be hard. So we created Highlite to make your job search / hiring process simpler. We hope you enjoy it!",
    );
  }
}
