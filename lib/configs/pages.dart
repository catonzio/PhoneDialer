import 'package:get/get.dart';
import 'package:phone_dialer/configs/routes.dart';
import 'package:phone_dialer/data/bindings/contacts_binding.dart';
import 'package:phone_dialer/data/bindings/phone_binding.dart';
import 'package:phone_dialer/data/bindings/register_binding.dart';
import 'package:phone_dialer/data/bindings/settings_binding.dart';
import 'package:phone_dialer/views/contacts_page.dart';
import 'package:phone_dialer/views/phone_dialer.dart';
import 'package:phone_dialer/views/register_page.dart';
import 'package:phone_dialer/views/settings_page.dart';

class Pages {
  static List<GetPage> get getPages => [
        // GetPage(name: "/", page: () => DefaultPage_OLD()),
        GetPage(
            name: Routes.settingsRoute,
            page: () => SettingsPage(),
            binding: SettingsBinding()),
        GetPage(
            name: Routes.phoneRoute,
            page: () => PhoneDialer(),
            binding: PhoneBinding(),
            transition: Get.currentRoute == Routes.contactsRoute
                ? Transition.rightToLeft
                : Transition.rightToLeftWithFade),
        GetPage(
            name: Routes.contactsRoute,
            page: () => const ContactsPage(),
            binding: ContactsBinding(),
            transition: Transition.rightToLeft),
        GetPage(
            name: Routes.registerRoute,
            page: () => RegisterPage(),
            binding: RegisterBinding(),
            transition: Transition.leftToRightWithFade),
      ];
}
