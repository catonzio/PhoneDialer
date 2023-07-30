import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phone_dialer/views/register_page.dart';

import 'controllers/settings_controller.dart';
import 'views/contacts_page.dart';
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
    // Get.put(HomeController());
    return GetMaterialApp(
        title: 'PhoneDialer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: Colors.black,
        ) /*.copyWith(
            scaffoldBackgroundColor: const Color(0xFF21152B),
            appBarTheme: const AppBarTheme(
                elevation: 2,
                backgroundColor: Color(0xFF21152B),
                foregroundColor: Colors.white,
                titleTextStyle: TextStyle(
                    decoration: TextDecoration.underline,
                    height: 1.5,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto-Regular')),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(foregroundColor: Colors.white)),
            colorScheme: ThemeData.dark().colorScheme.copyWith(
                // primary: ,
                ))*/
        ,
        themeMode: ThemeMode.system,
        initialRoute: "/phone",
        getPages: [
          // GetPage(name: "/", page: () => DefaultPage_OLD()),
          GetPage(name: "/settings", page: () => SettingsPage()),
          GetPage(name: "/phone", page: () => PhoneDialer()),
          GetPage(
              name: "/contacts",
              page: () => ContactsPage(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/register",
              page: () => RegisterPage(),
              transition: Transition.leftToRight),
        ]);
  }
}
