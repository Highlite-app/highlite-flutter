import 'package:highlite_flutter_mvp/core/constants/injection_constant.dart';

import '../../../core/services/injection_container.dart';
import '../../../data/models/apis/authentication/persisted_user.dart';


final persistenceService = sl.get<PersistentRepository>(instanceName: InjectionConstant.persistentImplementation);
abstract class PersistentRepository{
  Future<PersistedUser?> get();
  Future<void> clear();
  Future<void> persist({
    required bool loggedIn,
    required String tokenId,
    required String accessToken,
    required String refreshToken,
    required String id,
    required String userType,
    String? companyId,
  });
  Future<void> persistFcm({
    required String fcmId,
  });
  Future<String?> getFcm();
}