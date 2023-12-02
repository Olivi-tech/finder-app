import 'package:finder_app/screens/screens.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:flutter/material.dart';
import 'screens/company_screens/company_screens.dart';
import 'screens/guest_screens.dart/guest_screens.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return animatePage(_getPage(settings));
  }

  static Widget _getPage(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return const SplashScreen();
      case AppRoutes.login:
        return const LoginScreen();
      case AppRoutes.register:
        return const RegisterScreen();
      case AppRoutes.guestHome:
        return const GuestHomeScreen();
      case AppRoutes.searchScreen:
        return SearchPostScreen();
      case AppRoutes.companyHome:
        return const CompanyHomeScreen();
      case AppRoutes.settings:
        return SettingsScreen();
      case AppRoutes.guestSettingScreen:
        return GuestSettingScreen();
      case AppRoutes.itemAdd:
        return const AddItemScreen();
      case AppRoutes.guestProfile:
        return const ProfileScreen();
      case AppRoutes.subscriptions:
        return const SubscriptionScreen();
      case AppRoutes.addNewCard:
        return const AddCardScreen();

      default:
        AppRoutes.splash;
        return const SplashScreen();
    }
  }

  static PageRouteBuilder animatePage(Widget widget) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 450),
      pageBuilder: (_, __, ___) => widget,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        return customLeftSlideTransition(animation, child);
      },
    );
  }

  static Widget customLeftSlideTransition(
      Animation<double> animation, Widget child) {
    Tween<Offset> tween =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));
    return SlideTransition(
      position: tween.animate(animation),
      child: child,
    );
  }
}
