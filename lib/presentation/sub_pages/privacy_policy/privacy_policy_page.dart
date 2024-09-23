import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/sub_pages/privacy_policy/privacy_policy_subpage.dart';
import 'package:highlite_flutter_mvp/presentation/sub_pages/privacy_policy/terms_of_use_subpage.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';
import '../../widgets/list/navigated_tile.dart';
import '../../widgets/navigation/navigated_page.dart';
import 'about_us_subpage.dart';
import 'open_source_subpage.dart';


class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigatedPage(
      title: "Documentation",
      includesBorder: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              NavigatedTile(
                  title: "About Us",
                  onTap: () {
                    context.navigator.push(MaterialPageRoute(
                      builder: (_) => const AboutUsSubpage(),
                    ));
                  }),
              const Divider(color: ColorConstant.neutral100,),
              NavigatedTile(
                  title: "Privacy Policy",
                  onTap: () {
                    context.navigator.push(MaterialPageRoute(
                      builder: (_) => const PrivacyPolicySubpage(),
                    ));
                  }),
                const Divider(color: ColorConstant.neutral100,),
              NavigatedTile(
                  title: "Terms of Use",
                  onTap: () {
                    context.navigator.push(MaterialPageRoute(
                      builder: (_) => const TermsOfUseSubpage(),
                    ));
                  }),
                const Divider(color: ColorConstant.neutral100,),
    /*          NavigatedTile(
                  title: "Open Source Libraries",
                  onTap: () {
                    context.navigator.push(MaterialPageRoute(
                      builder: (_) => const OpenSourceSubpage(),
                    ));
                  }),
                const Divider(color: ColorConstant.neutral100,),*/
            ],
          ),
        ),
      ),
    );
  }
}
