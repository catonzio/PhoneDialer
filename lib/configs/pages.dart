import 'package:get/get.dart';
import 'package:phone_dialer/configs/routes.dart';
import 'package:phone_dialer/data/bindings/contacts_binding.dart';
import 'package:phone_dialer/data/bindings/home_binding.dart';
import 'package:phone_dialer/data/bindings/phone_binding.dart';
import 'package:phone_dialer/data/bindings/register_binding.dart';
import 'package:phone_dialer/data/bindings/settings_binding.dart';
import 'package:phone_dialer/ui/views/contacts_page.dart';
import 'package:phone_dialer/ui/views/phone_dialer.dart';
import 'package:phone_dialer/ui/views/register_page.dart';
import 'package:phone_dialer/ui/views/settings_page.dart';

class Pages {
  static List<GetPage> getPages() => [
        GetPage(
            name: Routes.settingsRoute,
            page: () => SettingsPage(),
            binding: SettingsBinding()),
        GetPage(
            name: Routes.phoneRoute,
            page: () => PhoneDialer(),
            bindings: [HomeBinding(), PhoneBinding()],
            customTransition: Get.customTransition,
            transition: Get.previousRoute == Routes.contactsRoute
                ? Transition.leftToRight
                : Transition.rightToLeft,
            transitionDuration: const Duration(milliseconds: 300)),
        GetPage(
            name: Routes.contactsRoute,
            page: () => const ContactsPage(),
            binding: ContactsBinding(),
            transition: Transition.rightToLeft,
            transitionDuration: const Duration(milliseconds: 300)),
        GetPage(
            name: Routes.registerRoute,
            page: () => const RegisterPage(),
            binding: RegisterBinding(),
            transition: Transition.leftToRight,
            transitionDuration: const Duration(milliseconds: 300)),
      ];
}
