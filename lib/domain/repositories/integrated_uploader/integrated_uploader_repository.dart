import 'dart:io';

import '../../../core/constants/injection_constant.dart';
import '../../../core/services/injection_container.dart';
import '../../../data/models/s3_bucket/upload_response.dart';

final integratedUploader = sl.get<IntegratedUploaderRepository>(instanceName: InjectionConstant.integratedUploaderRepository);

abstract class IntegratedUploaderRepository{

  Future<UploadResponse> uploadIntegratedToToast({
    required String key,
    required File file,
    required String extension,
    required String bucket,
    required String startPlaceholder,
    required String progressPlaceholder,
    required String completedPlaceholder,
    bool autoClose = false,
});

}