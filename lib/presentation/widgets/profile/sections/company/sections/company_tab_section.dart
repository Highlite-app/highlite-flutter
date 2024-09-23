import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/sections/company/sections/company_profile_video_tab.dart';
import '../../../../../../core/resources/asset_constants.dart';
import '../../../../../../core/resources/color_constants.dart';
import '../../../../svg/svg_asset.dart';
import '../../../tabs/self_video/profile_video_tab.dart';

class CompanyTabSection extends StatefulWidget {
  const CompanyTabSection({super.key});

  @override
  State<CompanyTabSection> createState() => _CompanyTabSectionState();
}

class _CompanyTabSectionState extends State<CompanyTabSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: ColorConstant.shade100,
              indicator: UnderlineTabIndicator(
                  borderSide:
                      BorderSide(width: 1, color: ColorConstant.shade100)),
              tabs: [
                Tab(
                    icon: SvgAsset(
                  asset: AssetConstant.dotIcon,
                  color: ColorConstant.shade100,
                  size: 24,
                )),
                Tab(
                    icon: SvgAsset(
                  asset: AssetConstant.bookmarkIcon,
                  color: ColorConstant.shade100,
                  size: 24,
                )),
                Tab(
                    icon: SvgAsset(
                  asset: AssetConstant.likOutlinedIcon,
                  color: ColorConstant.shade100,
                  size: 24,
                )),
              ]),
          const Expanded(
            child: TabBarView(children: [

              CompanyProfileVideTab(),
              CompanyProfileVideTab(),
              CompanyProfileVideTab()

            ]),
          ),
        ],
      ),
    );
  }
}
