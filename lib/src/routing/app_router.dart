import 'package:go_router/go_router.dart';
import 'package:upskill_consultancy/src/routing/global_navigator.dart';
import 'package:upskill_consultancy/src/routing/app_routes.dart';

import 'package:upskill_consultancy/src/features/splash/presentation/screens/splash_screen.dart';
import 'package:upskill_consultancy/src/features/auth/presentation/screens/login_screen.dart';
import 'package:upskill_consultancy/src/features/auth/presentation/screens/signup_screen.dart';
import 'package:upskill_consultancy/src/features/auth/presentation/screens/forgot_password_screen.dart';

import 'package:upskill_consultancy/src/features/home/presentation/screens/home_page.dart';
import 'package:upskill_consultancy/src/features/onboarding/presentation/screens/onboarding_page.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.splash,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      name: 'onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.signup,
      name: 'signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      name: 'forgotPassword',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
  ],
);

