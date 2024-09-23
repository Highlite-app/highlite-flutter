import 'dart:io';

import 'package:highlite_flutter_mvp/data/models/s3_bucket/upload_response.dart';
import 'package:highlite_flutter_mvp/data/models/toast/progress_indicator.dart';
import 'package:highlite_flutter_mvp/domain/repositories/integrated_uploader/http_uploader_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/integrated_uploader/integrated_uploader_repository.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/upload_handler/upload_handler_event.dart';

import '../../../presentation/bloc/upload_handler/upload_handler_builder.dart';

class IntegratedUploaderRepositoryImpl extends IntegratedUploaderRepository{
  @override
  Future<UploadResponse> uploadIntegratedToToast({
    required String key ,
    required File file,
    required String extension,
    required String bucket,
    required String startPlaceholder,
    required String progressPlaceholder,
    required String completedPlaceholder,
    bool autoClose = false
  })  async {
    uploadHandler.add(
    AddUploadIndicationEvent(
      ProgressIndication(
        id:key,
        placeholder: startPlaceholder ,
        progress: 0,
        millis: 10
      ),
    ),
    );

    final response  = await uploader.uploadDirectlyByKeyAndFile(
        key,
        file,
        bucket,
        extension,
            (progress) {
           final millis = progress.transferredBytes - progress.totalBytes;
           if (progress.progress == 100) {
             uploadHandler.add(
               UploadProgressEvent(
                 key,
                 completedPlaceholder,
                 progress.progress,
                 millis * -1,
               ),
             );
           } else {
             uploadHandler.add(
               UploadProgressEvent(
                 key,
                 progressPlaceholder,
                 progress.progress,
                 millis * -1,
               ),
             );
           }
            });
    if (autoClose) {
      uploadHandler.add(RemoveIndicationEvent(key));
    }
    return response ;
  }


}