// Flutter SDK
export 'package:flutter/material.dart';
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/foundation.dart';
export 'package:flutter/services.dart';
export 'package:flutter_native_splash/flutter_native_splash.dart';

export 'package:easy_localization/easy_localization.dart' hide TextDirection, MapExtension;

// Project Core — everything exported through shared.dart (theme, extensions,
// utils, widgets, enums) plus routing and services.
export '../config/app_config.dart';
export '../routing/app_router.dart';
export '../routing/app_routes.dart';
export '../routing/global_navigator.dart';
export '../routing/main_shell_scaffold.dart';
export '../services/services.dart';
export '../shared/shared.dart';

export '../features/auth/presentation/screens/login_screen.dart';
export '../features/auth/presentation/screens/signup_screen.dart';
export '../features/auth/presentation/screens/forgot_password_screen.dart';
export '../features/home/presentation/screens/home_page.dart';
export '../features/courses/presentation/screens/courses_page.dart';
export '../features/my_learning/presentation/screens/my_learning_page.dart';
export '../features/services/presentation/screens/services_page.dart';
export '../features/dashboard/presentation/screens/dashboard_page.dart';
export '../features/onboarding/presentation/screens/onboarding_page.dart';
