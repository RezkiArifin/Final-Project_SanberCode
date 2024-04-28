import 'package:final_project/main.dart';
import 'package:final_project/routes/route_name.dart';
import 'package:final_project/screen/auth/login_screen.dart';
import 'package:final_project/screen/auth/register_screen.dart';
import 'package:get/get.dart';

class PageRoutesApp {
  static final pages = [
    GetPage(
      name: RouteName.loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: RouteName.registerScreen,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: RouteName.bottomNavbar,
      page: () => const BottomNavigationBarExample(),
    ),
  ];
}
