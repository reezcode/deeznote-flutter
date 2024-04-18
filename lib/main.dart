import 'package:deeznote/app/data/sources/local/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app/domain/di/client/dependency_injection.dart';
import 'app/routes/app_pages.dart';
import 'config/main_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await GetStorage.init();
  MainConfig.configLoading();
  await DependencyInjection.init();
  await Permission.storage.request();
  await Permission.manageExternalStorage.request();

  runApp(ScreenUtilInit(
    builder: (context, child) => GetMaterialApp(
      title: "Application",
      initialRoute: 'token'.load() != null && 'token'.load() != ''
          ? AppPages.HOME
          : AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
    ),
  ));
}
