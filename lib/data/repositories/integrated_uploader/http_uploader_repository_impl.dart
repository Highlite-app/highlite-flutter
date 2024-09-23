import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:highlite_flutter_mvp/core/enums/presigned_message_type.dart';
import 'package:highlite_flutter_mvp/data/models/s3_bucket/upload_progress.dart';
import 'package:highlite_flutter_mvp/data/models/s3_bucket/upload_response.dart';
import 'package:highlite_flutter_mvp/domain/repositories/integrated_uploader/http_uploader_repository.dart';
import 'package:path/path.dart' as path;
import '../../../domain/repositories/s3_bucket/presigned_respository.dart';
import '../../models/s3_bucket/presigner/get_presigned_url_without_client.dart';

class HttpUploaderRepositoryImpl extends  HttpUploaderRepository{
  @override
  Future<Response> putUploadForUrl(String urlToPut, File fileToUpload,
      Function(UploadProgress p1) onUploadProgress) async{
    Dio dio = Dio();
    String fileExtension = path.extension(fileToUpload.path);
    if (fileExtension == ".pdf" ||
        fileExtension == ".doc" ||
        fileExtension == ".docx") {
      final Response response = await dio.put(
        urlToPut,
        data: fileToUpload.openRead(),
        options: Options(
          contentType: 'multipart/form-data',
          headers: {
            "Content-Length": fileToUpload.lengthSync(),
          },
        ),
        onSendProgress: (int sentBytes, int totalBytes) {
          double progressPercent = sentBytes / totalBytes * 100;
          onUploadProgress(UploadProgress(
              transferredBytes: sentBytes,
              totalBytes: totalBytes,
              progress: progressPercent));
        },
      );
      return response;
    }
    final Response response = await dio.put(
      urlToPut,
      data: fileToUpload.openRead(),
      options: Options(
        contentType: "image/jpeg",
        headers: {
          "Content-Length": fileToUpload.lengthSync(),
        },
      ),
      onSendProgress: (int sentBytes, int totalBytes) {
        double progressPercent = sentBytes / totalBytes * 100;
        onUploadProgress(UploadProgress(
            transferredBytes: sentBytes,
            totalBytes: totalBytes,
            progress: progressPercent));
      },
    );
    return response;
  }

  @override
  Future<UploadResponse> uploadDirectlyByKeyAndFile
      (String key,
      File file,
      String bucket,
      String extension,
      Function(UploadProgress p1) onProgressChanged) async{
    int randomNumber = Random().nextInt(100);
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String fileName = "${timestamp}_$randomNumber.$extension";
    final response = await presignerService.getPresignedURLWithoutClient(
      GetPresignedURLWithoutClientRequest(
        filename: fileName,
        type: bucket,
      ),
    );
    final urlToPut = response.data.getPreSignedURL;
    final urlFragments = urlToPut.split('?');
    await uploader.putUploadForUrl(
      urlToPut,
      file,
          (progress) {
        onProgressChanged(progress);
      },
    );
    return UploadResponse(
      fileName: fileName,
      urlFragments: urlFragments,
    );
  }

  @override
  Future<UploadResponse> uploadDirectlyByKeyAndMessageFile(String key, File file, String bucket, String extension, PreSignedMessageType bucketType, Function(UploadProgress p1) onProgressChanged)
  async {
    int randomNumber = Random().nextInt(100);
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String fileName = "${timestamp}_$randomNumber.$extension";
    final GetPresignedURLWithoutClientResponse response;
    switch (bucketType) {
      case PreSignedMessageType.document:
        response = await presignerService.createURLForMessageDocument(
          FilenameRequest(
            filename: fileName,
          ),
        );
        break;
      case PreSignedMessageType.photo:
        response = await presignerService.createURLForMessagePhoto(
          FilenameRequest(
            filename: fileName,
          ),
        );
        break;
      case PreSignedMessageType.video:
        response = await presignerService.createURLForMessageVideo(
          FilenameRequest(
            filename: fileName,
          ),
        );
        break;
    }

    final urlToPut = response.data.getPreSignedURL;
    final urlFragments = urlToPut.split('?');
    await uploader.putUploadForUrl(
      urlToPut,
      file,
          (progress) {
        onProgressChanged(progress);
      },
    );
    return UploadResponse(
      fileName: fileName,
      urlFragments: urlFragments,
    );
  }


}