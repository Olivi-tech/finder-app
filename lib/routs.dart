import 'dart:developer';
import 'package:finder_app/constant/app_images.dart';
import 'package:finder_app/screen/screen.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:flutter/material.dart';

import 'screen/company_screens/company_screens.dart';
import 'screen/guest_screens.dart/guest_screens.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return animatePage(_getPage(settings));
  }

  static Widget _getPage(RouteSettings settings) {
    log('..My Routing : ${settings.name}');
    switch (settings.name) {
      case AppRoutes.splash:
        return const SplashScreen();
      case AppRoutes.login:
        return const LoginAsCompany();
      case AppRoutes.register:
        return const RegisterCompanyScreen();
      case AppRoutes.guestRegister:
        return const RegisterScreen();
      case AppRoutes.guesthome:
        return const GuestHomeScreen();
      case AppRoutes.homePage:
        return HomePage();
      case AppRoutes.itemAdd:
        return const AddItemScreen();
      case AppRoutes.guestContact:
        return const GuestContactScreen();
      case AppRoutes.guestItemDetails:
        return const GuestItemDetailsPage(
          containerText: 'Iphone 11',
          timeText: '15 mints ago',
          imagePath: AppImages.phoneImge,
          locationText: 'Base Camp Resort, lahore',
        );
      case AppRoutes.itemDetails:
        return const ItemDetailsPage(
          containerText: 'Iphone 11',
          timeText: '15 mints ago',
          imagePath: AppImages.phoneImge,
          locationText: 'Base Camp Resort, lahore',
        );

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
