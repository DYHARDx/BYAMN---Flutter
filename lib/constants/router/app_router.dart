import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';
import '../../screens/app/app_shell_screen.dart';
import '../../screens/auth/forget_password_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/signup_screen.dart';
import '../../splash_screen.dart';
import 'app_routes_list.dart';

class AppRoute {
  static GoRouter routes(AuthProvider authProvider) {
    return GoRouter(
      initialLocation: RouteList.splash,
      refreshListenable: authProvider,
      redirect: (context, state) {
        final String location = state.matchedLocation;
        final bool isAuthRoute =
            location == RouteList.signInRoutePath ||
            location == RouteList.signUpRoutePath ||
            location == RouteList.forgetPasswordRoutePath;

        if (!authProvider.isReady) {
          return location == RouteList.splash ? null : RouteList.splash;
        }

        if (!authProvider.isLoggedIn) {
          if (location == RouteList.splash || isAuthRoute) {
            return location == RouteList.splash
                ? RouteList.signInRoutePath
                : null;
          }
          return RouteList.signInRoutePath;
        }

        if (authProvider.isLoggedIn &&
            (location == RouteList.splash || isAuthRoute)) {
          return RouteList.homeShellRoutePath;
        }

        return null;
      },
      routes: <RouteBase>[
        GoRoute(
          path: RouteList.splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: RouteList.signInRoutePath,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: RouteList.signUpRoutePath,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: RouteList.forgetPasswordRoutePath,
          builder: (context, state) => const ForgetPasswordScreen(),
        ),
        GoRoute(
          path: RouteList.homeShellRoutePath,
          builder: (context, state) => const AppShellScreen(),
        ),
      ],
    );
  }
}
