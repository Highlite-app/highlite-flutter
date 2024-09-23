import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';

import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/string.dart';

import '../../../core/constants/user_types.dart';
import '../../bloc/dashboard/auth/authentication_bloc.dart';
import '../../bloc/dashboard/auth/authentication_state.dart';
import '../constants/text_style.dart';
import '../logo/animated_logo.dart';
import '../profile/profile_picture.dart';
import '../svg/svg_asset.dart';

class DashboardTab {
  final Widget widget;
  final String? title;
  final String? tag ;
  final String? icon;
  final String? selectedIcon;
  final bool isHighliteLogo ;
  const DashboardTab({
    required this.widget,
     this.title,
    this.tag ,
    this.icon,
    this.isHighliteLogo = false ,
    this.selectedIcon,
  });
}

class DashboardTabs extends StatelessWidget {
  final int selectedIndex;
  final bool onDarkTabs;
  final Function(int) onSelectPage;
  final List<DashboardTab> tabs;
  final bool isHighliteLogo ;

  const DashboardTabs({
    super.key,
    required this.selectedIndex,
    required this.onDarkTabs,
    required this.onSelectPage,
    this.isHighliteLogo = false ,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  onDarkTabs ? ColorConstant.tabSurface : ColorConstant.shade00,
      child: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: onDarkTabs ? ColorConstant.tabSurface : ColorConstant.shade00,
                width: 0.5,
              ),
            ),
          ),
          child: TabBar(
            indicatorColor: Colors.transparent,
            // indicator: ShapeDecoration(
            //  color: isHighliteLogo? Colors.transparent: onDarkTabs ? ColorConstant.shade00 : ColorConstant.neutral800,
            //   shape: const RoundedRectangleBorder(
            //     borderRadius: BorderRadius.only(
            //         bottomRight: Radius.circular(0.0),
            //         bottomLeft: Radius.circular(0.0)),
            //   ),
            // ),
            dividerColor: Colors.transparent,
            indicatorPadding:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 70.0),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: onDarkTabs ? ColorConstant.shade00  : ColorConstant.neutral800,
            unselectedLabelColor: onDarkTabs ? ColorConstant.neutral400  : ColorConstant.neutral800,
            labelStyle: const  BaseTextStyle(
              fontSize: 9,
              color: ColorConstant.neutral800,
              fontWeight: FontWeight.w500,
            ),
            onTap: onSelectPage,
            tabs: tabs.mapIndexed((tab, index) {
              if (tab.tag == "Profile") {
                return BlocBuilder<AuthenticationBloc , AuthenticationState>(
                  builder: (context, authState) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ProfileTabItem(
                      isSelected: selectedIndex == index,
                      onDarkSurface: onDarkTabs,
                      title: tab.title ?? '',
                      profile: authState.userType == UserTypes.candidate
                          ? (authState.candidate?.profilePicture ?? "")
                          : (authState.companyProfile?.companyLogo ?? ""),

                    ),
                  ),
                );
              }
              if(index ==2){
                return  Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TabItem(
                    asset: tab.icon.toString(),
                    selectedAsset: tab.selectedIcon.toString(),
                    title: tab.title,
                    isHighliteIcon: tab.isHighliteLogo ,
                    isSelected: selectedIndex == index ,
                    onDarkSurface: onDarkTabs,
                    child: selectedIndex == index ? const AnimatedLogo():  Image.asset(
                         AssetConstant.icHighLiteSMLogoSmallPng

                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: TabItem(
                  asset: tab.icon.toString(),
                  selectedAsset: tab.selectedIcon.toString(),
                  title: tab.title ,
                  isHighliteIcon: tab.isHighliteLogo ,
                  isSelected: selectedIndex == index,
                  onDarkSurface: onDarkTabs,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  final String asset;
  final bool isHighliteIcon ;
  final VoidCallback? onTapHighliteIcon ;
  final String selectedAsset;
  final String? title;
  final bool isSelected;
  final bool onDarkSurface;
  final Widget? child ;
  const TabItem({
    super.key,
    required this.asset,
    required this.selectedAsset,
     this.title,
    this.isHighliteIcon = false ,
    required this.isSelected,
    this.onTapHighliteIcon ,
    required this.onDarkSurface,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return child != null ? child! :Tab(
       text: title ?? '',
      icon: SvgAsset(
        asset: isSelected ? selectedAsset : asset,
        color:  onDarkSurface ? isSelected ? ColorConstant.shade00: ColorConstant.neutral400 : ColorConstant.neutral800,
      ),
    );
  }
}

class ProfileTabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final bool onDarkSurface;
  final String profile;
  const   ProfileTabItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onDarkSurface,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    bool isURLValid = profile.isValidURLForImage();
    return Tab(
      icon: isURLValid
          ? ProfilePicture(
              url: profile,
              size: 24,
              emptySize: 24,
              emptyBackground:
                  onDarkSurface ? ColorConstant.shade00 : ColorConstant.neutral50,
            )
          : SvgAsset(
              asset: AssetConstant.profileIcon,
              size: 24,
              color: onDarkSurface ? ColorConstant.shade00 : ColorConstant.neutral800,
            ),
    );
  }
}




