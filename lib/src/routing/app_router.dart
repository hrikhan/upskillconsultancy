import 'package:go_router/go_router.dart';
import 'package:upskill_consultancy/src/routing/global_navigator.dart';
import 'package:upskill_consultancy/src/routing/app_routes.dart';
import 'package:upskill_consultancy/src/routing/main_shell_scaffold.dart';

import 'package:upskill_consultancy/src/features/splash/presentation/screens/splash_screen.dart';
import 'package:upskill_consultancy/src/features/auth/presentation/screens/login_screen.dart';
import 'package:upskill_consultancy/src/features/auth/presentation/screens/signup_screen.dart';
import 'package:upskill_consultancy/src/features/auth/presentation/screens/forgot_password_screen.dart';

import 'package:upskill_consultancy/src/features/home/presentation/screens/home_page.dart';
import 'package:upskill_consultancy/src/features/courses/presentation/screens/courses_page.dart';
import 'package:upskill_consultancy/src/features/my_learning/presentation/screens/my_learning_page.dart';
import 'package:upskill_consultancy/src/features/services/presentation/screens/services_page.dart';
import 'package:upskill_consultancy/src/features/dashboard/presentation/screens/dashboard_page.dart';
import 'package:upskill_consultancy/src/features/onboarding/presentation/screens/onboarding_page.dart';
import 'package:upskill_consultancy/src/features/home/presentation/screens/membership_screen.dart';

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
      path: AppRoutes.membership,
      name: 'membership',
      builder: (context, state) => const MembershipScreen(),
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

    // Bottom Navigation Shell with persistent state
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShellScaffold(navigationShell: navigationShell);
      },
      branches: [
        // Tab 0: Home
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              name: 'home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),

        // Tab 1: Courses
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.courses,
              name: 'courses',
              builder: (context, state) => const CoursesPage(),
            ),
          ],
        ),

        // Tab 2: My Learning (Center Floating Action Button)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.myLearning,
              name: 'myLearning',
              builder: (context, state) => const MyLearningPage(),
            ),
          ],
        ),

        // Tab 3: Services
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.services,
              name: 'services',
              builder: (context, state) => const ServicesPage(),
            ),
          ],
        ),

        // Tab 4: Dashboard
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.dashboard,
              name: 'dashboard',
              builder: (context, state) => const DashboardPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
