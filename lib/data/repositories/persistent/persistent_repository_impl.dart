import 'package:highlite_flutter_mvp/data/models/apis/authentication/persisted_user.dart';
import 'package:highlite_flutter_mvp/domain/repositories/persistent/persistent_repository.dart';

import '../../../core/keys/persistence_key.dart';
import '../../../core/local_storage/shared_preference.dart';

class PersistentRepositoryImpl extends PersistentRepository{
  @override
  Future<void> clear() async {
  await  SharedPreferencesHelper.clear();
  }

  @override
  Future<PersistedUser?> get() async{
    final bool? isLoggedIn = SharedPreferencesHelper.getBool(key:PersistenceKey.isLoggedIn);
    if (isLoggedIn != null && isLoggedIn == true) {
      String tokenId =  SharedPreferencesHelper.getValue( key: PersistenceKey.tokenId,)?? '';
      String accessToken =  SharedPreferencesHelper.getValue(key:PersistenceKey.accessToken)?? '';
      String refreshToken = SharedPreferencesHelper.getValue(key: PersistenceKey.refreshToken)?? '';
      String id = SharedPreferencesHelper.getValue(key:PersistenceKey.id)?? '';
      String userType = SharedPreferencesHelper.getValue(key:PersistenceKey.userType)?? '';
      String? companyId = SharedPreferencesHelper.getValue(key:PersistenceKey.companyId);
      return PersistedUser(
        isLoggedIn: isLoggedIn,
        tokenId: tokenId,
        accessToken: accessToken,
        refreshToken: refreshToken,
        id: id,
        userType: userType,
        companyId: companyId,
      );
    } else {
      return Future.value(null);
    }
  }

  @override
  Future<String?> getFcm() {
    // TODO: implement getFcm
    throw UnimplementedError();
  }

  @override
  Future<void> persist({
    required bool loggedIn,
    required String tokenId,
    required String accessToken,
    required String refreshToken,
    required String id,
    required String userType,
    String? companyId})
  async{

    await SharedPreferencesHelper.setBool(key:PersistenceKey.isLoggedIn, value: loggedIn);
    await SharedPreferencesHelper.setValue(key:PersistenceKey.tokenId, value:tokenId);
    await SharedPreferencesHelper.setValue(key:PersistenceKey.accessToken, value:accessToken);
    await SharedPreferencesHelper.setValue(key:PersistenceKey.refreshToken, value:refreshToken);
    await SharedPreferencesHelper.setValue(key:PersistenceKey.id, value:id);
    await SharedPreferencesHelper.setValue(key:PersistenceKey.userType, value:userType);
    if (companyId != null) {
      await SharedPreferencesHelper.setValue(key:PersistenceKey.companyId, value:companyId);
    }
  }

  @override
  Future<void> persistFcm({required String fcmId}) async{
   await SharedPreferencesHelper.setValue(key: PersistenceKey.fcmId, value: fcmId) ;
  }

}