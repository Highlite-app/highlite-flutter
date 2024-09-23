import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/sections/company/sections/company_profile_video_tab.dart';
import '../../../tabs/self_video/profile_video_tab.dart';


class CompanyTabSection extends StatefulWidget {

  const CompanyTabSection({super.key});

  @override
  State<CompanyTabSection> createState() => _CompanyTabSectionState();
}

class _CompanyTabSectionState extends State<CompanyTabSection> {


  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:  EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child:CompanyProfileVideTab(),

            ),
        ],
      ),
    );
  }
}
