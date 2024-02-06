import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phone_dialer/configs/pages.dart';
import 'package:phone_dialer/configs/routes.dart';
import 'package:phone_dialer/configs/themes.dart';
import 'package:phone_dialer/data/bindings/settings_binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PhoneDialer',
      debugShowCheckedModeBanner: false,
      theme: getLightTheme(),
      darkTheme: getDarkTheme(),
      themeMode: ThemeMode.system,
      initialBinding: SettingsBinding(),
      initialRoute: Routes.phoneRoute,
      getPages: Pages.getPages(),
    );
  }
}
