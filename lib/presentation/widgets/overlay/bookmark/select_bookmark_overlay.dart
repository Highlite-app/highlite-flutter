import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/bookmark/bookmark_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/bookmark/bookmark_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/bookmark/bookmark_state.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/bookmark/bookmark_page.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/navigation/base_navigator.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/overlay/bookmark/add_bookmark_overlay.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/overlay/overlay_widget/titled_overlay.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/modal.dart';

import '../../../../core/resources/asset_constants.dart';
import '../../buttons/svg_button.dart';

class SelectBookmarkOverlay extends StatefulWidget {
  final String candidateId;

  final String videoFeedId;

  const SelectBookmarkOverlay(
      {required this.candidateId, required this.videoFeedId, super.key});


  static Future<bool?> showBookmarkSelectionByUserId(
      {required String candidateId,
        required String videoFeedId,
        required BuildContext context}) async {
    return await context.showModalOnBottom<bool?>(SelectBookmarkOverlay(
        candidateId: candidateId, videoFeedId: videoFeedId));
  }

  @override
  State<SelectBookmarkOverlay> createState() => _SelectBookmarkOverlayState();
}

class _SelectBookmarkOverlayState extends State<SelectBookmarkOverlay> {

  @override
  Widget build(BuildContext context) {
    return BaseNavigator(
        builder: (navKey) => BlocProvider<BookmarkBloc>(
              create: (context) => BookmarkBloc()..add(GetBookmarkEvent()),
              child: BlocBuilder<BookmarkBloc, BookmarkState>(
                  builder: (context, state) {
                return TitledOverlay(
                    height: 300,
                    title: 'Add Your List',
                    action: [
                      SvgButton(
                          asset: AssetConstant.plusIcon,
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddBookmarkOverlay(
                                          candidateId: widget.candidateId,
                                          videoFeedId: widget.videoFeedId,
                                        )));


                          })
                    ],
                    child: BookmarkPage(collections: state.bookmarkCollection));
              }),
            ));
  }
}
