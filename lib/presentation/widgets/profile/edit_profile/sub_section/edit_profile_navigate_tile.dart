import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';
import '../../../../../core/resources/typography_theme.dart';
import '../../../buttons/rippler.dart';
import '../../../constants/text_style.dart';
import '../../../svg/svg_asset.dart';
import '../form/profile_editor_form.dart';

class NavigatedEditProfileForm<DataModel> extends StatelessWidget {
  final String title;
  final String? value;
  final DataModel? data;
  final bool bordered;
  final EditorFormModel<DataModel> form;
  const NavigatedEditProfileForm({
    super.key,
    required this.title,
    this.value,
    required this.data,
    required this.form,
    this.bordered = true,
  });

  @override
  Widget build(BuildContext context) {
    return NavigatedTile(
      title: title,
      text: value,
      bordered: bordered,
      navigateTo: ProfileEditorForm<DataModel>(
        form: form,
        data: data,
      ),
    );
  }
}

class NavigatableTile extends StatelessWidget {
  final String title;
  final String? text;
  final bool bordered;
  final bool isTextOverflow;
  final VoidCallback onTap;
  const NavigatableTile({
    super.key,
    required this.title,
    this.text,
    this.bordered = true,
    this.isTextOverflow = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Rippler(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: bordered
              ? const Border(
                  bottom: BorderSide(
                    color: ColorConstant.neutral100,
                    width: 1,
                  ),
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style:  BaseTextStyle(
                  fontSize: TypographyTheme.paragraph_p3,
                  color: ColorConstant.neutral900,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (text != null)
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 150),
                        child: Text(
                          text!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style:  BaseTextStyle(
                            fontSize: TypographyTheme.paragraph_p3,
                            color: ColorConstant.neutral900,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                          ),
                        ),
                      ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    const SvgAsset(
                      asset: AssetConstant.arrowNextIcon,
                      size: 12,
                      color: ColorConstant.neutral800,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigatedTile extends StatelessWidget {
  final String title;
  final String? text;
  final bool bordered;
  final bool isTextOverflow;
  final Widget navigateTo;
  const NavigatedTile({
    super.key,
    required this.title,
    this.text,
    this.bordered = true,
    this.isTextOverflow = false,
    required this.navigateTo,
  });

  @override
  Widget build(BuildContext context) {
    return NavigatableTile(
      title: title,
      text: text,
      bordered: bordered,
      onTap: () {
        context.navigator.push(
          MaterialPageRoute(
            builder: (_) => navigateTo,
          ),
        );
      },
    );
  }
}
