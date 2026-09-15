/// Centralized route path constants for GoRouter.
///
/// Use these variables instead of raw strings throughout the app.
/// Example: `context.go(AppRoutes.onboarding)` instead of `context.go('/')`.
abstract final class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String home = '/';
  static const String courses = '/courses';
  static const String myLearning = '/my-learning';
  static const String services = '/services';
  static const String dashboard = '/dashboard';
  static const String onboarding = '/onboarding';
  static const String membership = '/membership';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
}
