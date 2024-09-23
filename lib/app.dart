import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:highlite_flutter_mvp/core/build_context/build_context.dart';
import 'package:highlite_flutter_mvp/core/keys/persistence_key.dart';
import 'package:highlite_flutter_mvp/core/local_storage/hive_initializer.dart';
import 'package:highlite_flutter_mvp/core/networking/mapper.dart';
import 'package:highlite_flutter_mvp/core/services/injection_container.dart'
    as di;
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/services/push_notification_service.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/candidate/search/search_repository.dart';
import 'package:highlite_flutter_mvp/firebase_options.dart';
import 'package:highlite_flutter_mvp/home.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_state.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/search/candidate/candidate_search_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/search/candidate/candidate_search_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/video/upload_candidate_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/video/upload_candidate_event.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/keyboard.dart';
import 'package:sizer/sizer.dart';

import 'core/environment/base_environment.dart';
import 'core/local_storage/shared_preference.dart';
import 'core/routes/route_constants.dart';
import 'core/routes/routes.dart';

final GlobalKey<NavigatorState> globalNavKey = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> dashboardNavKey = GlobalKey<NavigatorState>();
GlobalKey<ScaffoldState> dashboardScaffoldState = GlobalKey();

Future<void> app(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveInitializer.initialize();
  MapperFactory.initialize();
  di.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  BaseEnvironment.initialize(env);
  await SharedPreferencesHelper.initialize();

  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthenticationBloc>(
      lazy: true,
        create: (BuildContext context) => authentication..add(const AuthenticateOnStartEvent())),
    // BlocProvider<AuthenticationBloc>(create: (_) => authentication),

    BlocProvider<CandidateSearchBloc>(
        lazy: false,
        create: (context) => CandidateSearchBloc()..add(StartEvent())),
    BlocProvider<UploadCandidateBloc>(
        lazy: true,
        create: (context)=> UploadCandidateBloc()..add(ResetIsVideoStateEvent())),

  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String message = "Checking Firebase Storage...";
  final PushNotificationService _pushNotification = PushNotificationService();

  final ThemeData theme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: ColorConstant.shade00,
      foregroundColor: ColorConstant.shade100,
    ),
    fontFamily: "Inter",
  );

  @override
  Widget build(BuildContext context) {
    _pushNotification.initialize(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          Keyboard.hide();
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) => Sizer(
          builder: (context, orientation, deviceType) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            routes: Routes.routes,
            theme: theme,
            navigatorKey: globalNavKey,
            locale: Get.deviceLocale,
            supportedLocales: const <Locale>[Locale('en', 'US')],
            home: const Home(),
            localizationsDelegates: const <LocalizationsDelegate<Object>>[
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
          ),
        ),
      ),
    );
  }
}
