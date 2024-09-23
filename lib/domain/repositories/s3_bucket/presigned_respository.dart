import 'package:highlite_flutter_mvp/core/constants/injection_constant.dart';

import '../../../core/services/injection_container.dart';
import '../../../data/models/s3_bucket/presigner/get_presigned_url_without_client.dart';

final presignerService = sl.get<PreSignedRepository>(instanceName: InjectionConstant.preSignedRepository);

abstract class PreSignedRepository{

  Future<GetPresignedURLWithoutClientResponse> getPresignedURLWithoutClient(
      GetPresignedURLWithoutClientRequest request);
  Future<GetPresignedURLWithoutClientResponse> createURLForMessagePhoto(
      FilenameRequest request);
  Future<GetPresignedURLWithoutClientResponse> createURLForMessageVideo(
      FilenameRequest request);
  Future<GetPresignedURLWithoutClientResponse> createURLForMessageDocument(
      FilenameRequest request);

}