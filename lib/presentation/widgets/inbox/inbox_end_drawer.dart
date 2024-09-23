import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';

import '../drawer/drawer_container.dart';
import '../drawer/drawer_tile.dart';
import '../drawer/profile_drawer_top.dart';

class InboxEndDrawer extends StatelessWidget {
  final String profile;
  final String name;
  final VoidCallback onArchiveOpen;
  final VoidCallback onContactSupportOpen;
  const InboxEndDrawer({
    super.key,
    required this.profile,
    required this.name,
    required this.onArchiveOpen,
    required this.onContactSupportOpen,
  });

  @override
  Widget build(BuildContext context) {
    return DrawerContainer(
      child: Column(
        children: [
          ProfileDrawerTop(
            profileURL: profile,
            fullName: name,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            direction: Axis.horizontal,
            children: [
              DarkDrawerTile(
                title: "Archive List",
                icon: AssetConstant.archiveIcon,
                onTap: () {
                  Scaffold.of(context).closeEndDrawer();
                  onArchiveOpen();
                },
              ),
              DarkDrawerTile(
                title: "Contact Support",
                icon:AssetConstant.headphoneIcon,
                onTap: () {
                  Scaffold.of(context).closeEndDrawer();
                  onContactSupportOpen();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
