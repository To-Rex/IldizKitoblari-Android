import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:disposable_cached_images/disposable_cached_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ildiz_kitoblari/pages/splash_screen.dart';
import 'package:ildiz_kitoblari/resource/srting.dart';
import 'controllers/get_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark));
  await DisposableImages.init();
  runApp(DisposableImages(MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.setHeightWidth(context);
    return ScreenUtilInit(
        designSize: Size(_getController.width.value, _getController.height.value),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return AdaptiveTheme(
              debugShowFloatingThemeButton: true,
              initial: AdaptiveThemeMode.light,
              light: ThemeData.light(useMaterial3: true),
              dark: ThemeData.dark(useMaterial3: true),
              builder: (theme, darkTheme) => GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Ildiz Kitoblari',
                theme: theme,
                translations: LocaleString(),
                locale:  Locale(_getController.language.languageCode, _getController.language.countryCode),
                darkTheme: darkTheme,
                home: SplashScreen(),
              )
          );
        });
  }
}