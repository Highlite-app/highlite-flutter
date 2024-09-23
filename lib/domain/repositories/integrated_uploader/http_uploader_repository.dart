import 'dart:io';

import 'package:dio/dio.dart';
import 'package:highlite_flutter_mvp/core/constants/injection_constant.dart';

import '../../../core/enums/presigned_message_type.dart';
import '../../../core/services/injection_container.dart';
import '../../../data/models/s3_bucket/upload_progress.dart';
import '../../../data/models/s3_bucket/upload_response.dart';

final uploader = sl.get<HttpUploaderRepository>(instanceName: InjectionConstant.httpUploaderRepository);

abstract class HttpUploaderRepository{
  Future<Response> putUploadForUrl(String urlToPut, File fileToUpload,
      Function(UploadProgress) onUploadProgress);
  Future<UploadResponse> uploadDirectlyByKeyAndFile(
      String key,
      File file,
      String bucket,
      String extension,
      Function(UploadProgress) onProgressChanged,
      );
  Future<UploadResponse> uploadDirectlyByKeyAndMessageFile(
      String key,
      File file,
      String bucket,
      String extension,
      PreSignedMessageType bucketType,
      Function(UploadProgress) onProgressChanged,
      );
}