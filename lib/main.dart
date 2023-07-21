import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phone_dialer/controllers/home_controller.dart';
import 'package:phone_dialer/views/contacts_page.dart';
import 'package:phone_dialer/views/register_page.dart';

import 'controllers/settings_controller.dart';
import 'views/phone_dialer.dart';
import 'views/settings_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    Get.put(HomeController());
    return GetMaterialApp(
      title: 'PhoneDialer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      initialRoute: "/dialer",
      getPages: [
        // GetPage(name: "/", page: () => Home()),
        GetPage(
            name: "/register",
            page: () => RegisterPage(),
            transition: Transition.leftToRight),
        GetPage(name: "/dialer", page: () => PhoneDialer()),
        GetPage(
            name: "/contacts",
            page: () => ContactsPage(),
            transition: Transition.rightToLeft),
        GetPage(name: "/settings", page: () => SettingsPage())
      ],
    );
  }
}
