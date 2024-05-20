import 'dart:developer';
import 'package:baapapp/app_config.dart';
import 'package:baapapp/constants/api_end_points.dart';
import 'package:baapapp/models/api_base_model.dart';
import 'package:baapapp/utils/preferences/local_preferences.dart';
import 'package:baapapp/utils/routes/routes.dart';
// ignore: unnecessary_import
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/bloc_provider.dart';

void main({String? env}) async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  usePathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await LocalStorageUtils.init();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
    SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? jwtToken = prefs.getString('jwtToken');

  final appConfig = await AppConfig().forEnvironment(env);
  runApp(MultiBlocProvider(
    providers: blocProviders,
    child: EasyLocalization(
      supportedLocales: const [
        Locale('marathi', 'IN'),
        Locale('hindi', 'IN'),
        Locale('english', 'IN'),
      ],
      fallbackLocale: const Locale('marathi', 'IN'),
      startLocale: const Locale('marathi', 'IN'),
      path: 'lib/logic/language_translate/language_checker.dart',
      //  customLocalization: CustomLocalizationDelegate(), // Use customDelegate instead of customLocalizationDelegate
      child: MyApp(
        config: appConfig,
        jwtToken: jwtToken
      ),
    ),
  ));
}
late ApiEndPoints apiEndpoints;

class MyApp extends StatefulWidget {
  const  MyApp({super.key, required this.config ,this.jwtToken});
  final ApiBaseModel config;
    final String? jwtToken;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appRoutes = Routes();

  @override
  void initState() {
    apiEndpoints = ApiEndPoints(apiBaseModel: widget.config);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 760),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: "BAAP APP",
            debugShowCheckedModeBanner: false,
               localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
            theme: ThemeData(
              textTheme: GoogleFonts.baloo2TextTheme(),
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                },
              ),
            ),
            routeInformationParser: appRoutes.router.routeInformationParser,
            routeInformationProvider: appRoutes.router.routeInformationProvider,
            routerDelegate: appRoutes.router.routerDelegate,
          );
        });
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log("Created: $bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log("Change in $bloc: $change");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log("Change in $bloc: $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    log("Closed: $bloc");
    super.onClose(bloc);
  }
}
