import 'package:highlite_flutter_mvp/data/models/s3_bucket/presigner/get_presigned_url_without_client.dart';
import 'package:highlite_flutter_mvp/domain/repositories/s3_bucket/presigned_respository.dart';

class PreSignedRepositoryImpl extends PreSignedRepository{

  @override
  Future<GetPresignedURLWithoutClientResponse> createURLForMessageDocument(FilenameRequest request) {
    // TODO: implement createURLForMessageDocumentd

    throw UnimplementedError();
  }

  @override
  Future<GetPresignedURLWithoutClientResponse> createURLForMessagePhoto(FilenameRequest request) {
    // TODO: implement createURLForMessagePhoto
    throw UnimplementedError();
  }

  @override
  Future<GetPresignedURLWithoutClientResponse> createURLForMessageVideo(FilenameRequest request) {
    // TODO: implement createURLForMessageVideo
    throw UnimplementedError();
  }

  @override
  Future<GetPresignedURLWithoutClientResponse> getPresignedURLWithoutClient(GetPresignedURLWithoutClientRequest request) {
    // TODO: implement getPresignedURLWithoutClient
    throw UnimplementedError();
  }


}