import 'dart:io';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../blocs/application/application_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/controllers/app_navigator_observer.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../ui/work_focus_version/splash/pages/splash_page.dart';
import '../../../../ui/work_focus_version/widget/custom_refresh_footer.dart';
import '../../core/constants/app_font.dart';
import '../../core/localization/translations.dart';
import '../../core/navigator/route_generator.dart';
import '../../core/shared_prefs/shared_prefs.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      // Code for Android devices
      print('This is an Android device.');
      DIManager.findDep<SharedPrefs>()..setDeviceType("android");
    } else if (Platform.isIOS) {
      // Code for iOS devices
      print('This is an iOS device.');
      DIManager.findDep<SharedPrefs>()..setDeviceType("ios");
    } else {
      // Code for other devices
      print('This is not an Android or iOS device.');
      DIManager.findDep<SharedPrefs>()..setDeviceType("iphone");
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(AppColorsController().colorBarRed);

    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
            child: MultiBlocProvider(
              providers: [
                BlocProvider<ApplicationCubit>(
                    create: (cxt) => DIManager.findDep<ApplicationCubit>()),
              ],
              child: ScreenUtilInit(
                useInheritedMediaQuery: true,
                designSize: Size(376, 812),
                minTextAdapt: true,
                splitScreenMode: false,
                builder: (context, child) {
                  return RefreshConfiguration(

                    footerBuilder: () => CustomRefreshFooter(),
                    child: Builder(builder: (context1) {
                      // Register a callback function to handle the deep link

                      return GetMaterialApp(
                        // useInheritedMediaQuery: true,
                        enableLog: false,
                        navigatorObservers: [AppNavigatorObserver()],
                        onGenerateRoute: RouteGenerator.generateRoutes,
                        debugShowCheckedModeBanner: false,
                        builder: (BuildContext context, Widget? widget) {
                          return FlutterEasyLoading(child: widget);
                        },
                        theme: ThemeData(
                          scaffoldBackgroundColor: AppColorsController().white,
                          textTheme:
                              AppFont.getTextTheme(Theme.of(context).textTheme),
                          tabBarTheme: TabBarTheme(
                            labelColor: DIManager.findDep<AppColorsController>()
                                .primaryColor,
                            unselectedLabelColor:
                                DIManager.findDep<AppColorsController>()
                                    .greyTextColor,
                            labelStyle: AppStyle.tabBarLabelStyle,
                            unselectedLabelStyle:
                                AppStyle.tabBarUnselectedLabelStyle,
                          ),
                          primaryColor: DIManager.findDep<AppColorsController>()
                              .primaryColor,
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  DIManager.findDep<AppColorsController>()
                                      .textButtonBackground,
                              // This is a custom color variable
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        title: AppConsts.appName,
                        translations: AppTranslations(),
                        // locale:
                        //     DevicePreview.locale(context),

                        locale:DIManager.findDep<ApplicationCubit>().appLanguage,

                        fallbackLocale: Locale(AppConsts.LANG_DEFAULT),
                        supportedLocales: DIManager.findDep<ApplicationCubit>()
                            .supportedLanguages,
                        localizationsDelegates: [
                          // RefreshLocalizations.delegate,
                          // Built-in localization of basic text for Material widgets
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                          // Built-in localization of basic text for Material widgets
                          DefaultWidgetsLocalizations.delegate,
                          DefaultCupertinoLocalizations.delegate,
                          DefaultMaterialLocalizations.delegate,
                        ],
                        initialRoute: SplashPage.routeName,
                        localeResolutionCallback: (Locale? locale,
                            Iterable<Locale> supportedLocales) {
                          //print("change language");
                          return locale;
                        },
                      );
                    }),
                  );
                },
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    DIManager.dispose();
    super.dispose();
  }
}
