import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/routes/route_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/dialogs/dialog_helper.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../app.dart';
import '../../presentation/widgets/constants/text_style.dart';
import '../resources/color_constants.dart';
import '../resources/l10n/translation_key.dart';
import '../resources/typography_theme.dart';

class PushNotificationService {
  late FirebaseMessaging _firebaseMessaging;

  PushNotificationService() {
    _firebaseMessaging = FirebaseMessaging.instance;
  }

  void initialize(BuildContext context) {
    _requestPermissions() ;
    getToken() ;
    _handleForegroundMessages(context);
    _handleBackgroundMessages();
    _handleTerminatedMessages(context);
  }

  void getToken(){
    _firebaseMessaging.getToken().then((token){
      debugPrint("The token is ::$token");
    } );

  }

  Future<void> _requestPermissions() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }


  void _handleForegroundMessages(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
      }
      if (message.notification != null) {
        if (kDebugMode)
          print(
              'Message also contained a notification: ${message.notification}');
        DialogHelper.showAdaptiveAlertDialog(
          context,
          message.notification?.title ?? '',
          message.notification?.body ?? "",
          [
            TextButton(
              child: Text(
                TranslationKeys.cancel,
                style: BaseTextStyle(
                  fontSize: TypographyTheme.paragraph_p2,
                  color: ColorConstant.primary500,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                TranslationKeys.ok,
                style: BaseTextStyle(
                  fontSize: TypographyTheme.paragraph_p2,
                  color: ColorConstant.primary500,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                context.navigator.pop();
              },
            ),
          ],
        );
      }
    });
  }

  void _handleBackgroundMessages() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void _handleTerminatedMessages(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) print('A new onMessageOpenedApp event was published!');
      _navigateToTargetPage(
          targetScreenRoute: RouteConstants.candidateDashboard, message.data);
    });

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        if (kDebugMode) print('Initial message received');
        _navigateToTargetPage(
            targetScreenRoute: RouteConstants.candidateDashboard, message.data);
      }
    });
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    if (kDebugMode)
      print('Handling a background message: ${message.messageId}');
    // Handle background message
  }

  void _navigateToTargetPage(Map<String, dynamic> data,
      {required String targetScreenRoute}) {
    globalNavKey.currentState!.pushNamed(targetScreenRoute);
  }
}
