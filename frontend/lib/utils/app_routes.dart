import 'package:flutter/material.dart';

import '../models/order_result.dart';
import '../models/waffle_cone.dart';
import '../screens/addresses_screen.dart';
import '../screens/checkout_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/help_support_screen.dart';
import '../screens/how_it_works_screen.dart';
import '../screens/main_screen.dart';
import '../screens/my_orders_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/order_confirmation_screen.dart';
import '../screens/payment_methods_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/product_listing_screen.dart';
import '../screens/rules_screen.dart';
import '../screens/sign_in_screen.dart';
import '../screens/sign_up_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/verification_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const onboarding = '/onboarding';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const forgotPassword = '/forgot-password';
  static const verification = '/verification';
  static const home = '/home';
  static const productDetail = '/product-detail';
  static const productListing = '/product-listing';
  static const checkout = '/checkout';
  static const orderConfirmation = '/order-confirmation';
  static const myOrders = '/my-orders';
  static const addresses = '/addresses';
  static const paymentMethods = '/payment-methods';
  static const notifications = '/notifications';
  static const help = '/help';
  static const editProfile = '/edit-profile';
  static const rules = '/rules';
  static const howItWorks = '/how-it-works';

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const SplashScreen(),
        onboarding: (_) => const OnboardingScreen(),
        signIn: (_) => const SignInScreen(),
        signUp: (_) => const SignUpScreen(),
        forgotPassword: (_) => const ForgotPasswordScreen(),
        home: (_) => const MainScreen(),
        checkout: (_) => const CheckoutScreen(),
        myOrders: (_) => const MyOrdersScreen(),
        addresses: (_) => const AddressesScreen(),
        paymentMethods: (_) => const PaymentMethodsScreen(),
        notifications: (_) => const NotificationsScreen(),
        help: (_) => const HelpSupportScreen(),
        editProfile: (_) => const EditProfileScreen(),
        rules: (_) => const RulesScreen(),
        howItWorks: (_) => const HowItWorksScreen(),
      };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case productDetail:
        return _fadeRoute(
          ProductDetailScreen(cone: settings.arguments as WaffleCone),
          settings,
        );
      case verification:
        final args = settings.arguments as Map<String, dynamic>?;
        return _fadeRoute(
          VerificationScreen(
            email: args?['email'] as String? ?? '',
            returnToHome: args?['returnToHome'] as bool? ?? false,
          ),
          settings,
        );
      case productListing:
        return _slideRoute(
          ProductListingScreen(initialCategory: settings.arguments as String?),
          settings,
        );
      case orderConfirmation:
        return _fadeRoute(
          OrderConfirmationScreen(orderResult: settings.arguments as OrderResult),
          settings,
        );
      default:
        return null;
    }
  }

  static PageRouteBuilder _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      transitionDuration: const Duration(milliseconds: 280),
    );
  }

  static PageRouteBuilder _slideRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        final tween = Tween(begin: const Offset(1, 0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOutCubic));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 320),
    );
  }
}
