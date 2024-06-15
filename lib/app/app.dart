import 'package:eso_akte_sikhi/app/routes/app_pages.dart';
import 'package:eso_akte_sikhi/app/shared/firebase/remote_config_service.dart';
import 'package:eso_akte_sikhi/app/shared/snackbar/snackbar_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DrawingApp extends StatelessWidget {
  const DrawingApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: const ColorScheme.light(
          primary: Colors.white,
          brightness: Brightness.light,
          surfaceTint: Colors.white,
        ),
      ),
      title: 'Drawing App',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      navigatorKey: Get.key,
      initialBinding: InitialBinding(),
      builder: (final context, final child) {
        return Builder(
          builder: (final context) {
            return ScreenUtilInit(
              designSize: const Size.fromWidth(375),
              builder: (final ctx, final child) {
                final Widget wrappedChild = MediaQuery(
                  data: MediaQuery.of(ctx).copyWith(
                    textScaler: const TextScaler.linear(1),
                  ),
                  child: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle.dark
                        .copyWith(systemNavigationBarColor: Colors.white),
                    child: child!,
                  ),
                );
                return wrappedChild;
              },
              child: child!,
            );
          },
        );
      },
    );
  }
}

class InitialBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(SnackbarNotification());
    Get.put(RemoteConfigService());
  }
}
