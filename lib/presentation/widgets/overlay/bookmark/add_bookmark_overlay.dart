import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/bookmark/bookmark_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/bookmark/bookmark_state.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/overlay/overlay_widget/titled_overlay.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/text_field/submittable_field.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../bloc/bookmark/bookmark_event.dart';

class AddBookmarkOverlay extends StatefulWidget {
  final String candidateId ;
  final String videoFeedId ;
  const AddBookmarkOverlay({
    required this.candidateId ,
    required this.videoFeedId ,
    super.key});

  @override
  State<AddBookmarkOverlay> createState() => _AddBookmarkOverlayState();
}

class _AddBookmarkOverlayState extends State<AddBookmarkOverlay> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookmarkBloc>(
      create:  (context) => BookmarkBloc()..add(GetBookmarkEvent()),
      child: BlocBuilder<BookmarkBloc , BookmarkState>(
        builder: (context , state) {
          return TitledOverlay(
            height: 200,
              title: 'New Collection',
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SubmittableField(
                    submitText: 'Add',
                    placeholderText: 'Collection Name',
                    onSubmit: ( String collectionName){
                      Navigator.of(context).pop();
                      context.read<BookmarkBloc>().add(CreateBookmarkCollectionEvent( userId: authService.persistedUser?.id ?? '', title: collectionName ,
                          candidateId: widget.candidateId,
                          videoFeedId: widget.videoFeedId)) ;

                    }),
              ),
            );
        }
      ),
    );
  }
}
