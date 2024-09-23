import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/svg/svg_asset.dart';

import '../buttons/rippler.dart';

class EditButtonProfile extends StatelessWidget {
  final VoidCallback? onTap;
  const EditButtonProfile({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Rippler(
      onTap: onTap!,
      shape: const CircleBorder(),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: SvgAsset(
          asset: AssetConstant.editIcon,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
