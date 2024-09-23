import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../buttons/tag_item.dart';

class TagsSection extends StatelessWidget {
  final List<String> tags;
  const TagsSection({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 75.w),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: -4.0,
        runSpacing: -2.0,
        direction: Axis.horizontal,
        children: [
          WrapTag(
            runSpacing: -12.0,
            group: TagWrap(
              wrappedTags: tags
                  .map(
                    (display) => Tag(
                      title: display,
                      status: TagStatus.normal,
                      size: TagSize.small,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
