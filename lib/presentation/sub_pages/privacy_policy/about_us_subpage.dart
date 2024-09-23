import 'package:flutter/material.dart';
import '../../widgets/drawer/content/content_subpage.dart';

class AboutUsSubpage extends StatelessWidget {
  const AboutUsSubpage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ContentSubpage(
      title: "About Us",
      content:
          "In 2024, finding a job is really hard. Hiring for a job is just as hard. Job matching shouldn’t be hard. So we created Highlite to make your job search / hiring process simpler."
              "\n\nWe hope you enjoy it!"
              "\n\n- The Highlite Team"

    );
  }
}
