import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:shopin/pages/dashboard.dart';
import 'package:shopin/pages/login_screen.dart';
import 'package:shopin/pages/success_screen.dart';
import 'package:shopin/prefs/prefs.dart';

class Routes {
  static const String dashboard = '/dashboard';
  static const String login = '/login';
  static const String cart = '/cart';
  static const String success = '/success';
}

class AppRouter {
  static List<GetPage> routes = [
    GetPage(
        name: Routes.login,
        page: () => PrefsDb.getLoginDetails == null
            ? const LoginScreen()
            : const DashboardScreen()),
    GetPage(name: Routes.dashboard, page: () => const DashboardScreen()),
    GetPage(
        name: Routes.success,
        page: () => const SuccessScreen(
              products: [],
            )),
  ];
}
