import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'constants/router/app_router.dart';
import 'data/repositories/static_content_repository.dart';
import 'core/theme/app_theme_data.dart';
import 'providers/auth_provider.dart';
import 'providers/connectivity_provider.dart';
import 'providers/content_provider.dart';
import 'providers/navigation_provider.dart';
import 'providers/theme_provider.dart';
import 'services/datasource/auth_sign_in_service.dart';
import 'services/datasource/google_sign_in_service.dart';
import 'shared/widgets/wrappers/connectivity_wrapper.dart';

class ByAmnApp extends StatelessWidget {
  const ByAmnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<ConnectivityProvider>(
          create: (_) => ConnectivityProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(
            authService: AuthService(),
            googleSignInService: GoogleSignInService(),
          ),
        ),
        ChangeNotifierProvider<NavigationProvider>(
          create: (_) => NavigationProvider(),
        ),
        ChangeNotifierProvider<ContentProvider>(
          create: (_) => ContentProvider(repository: StaticContentRepository()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        child: Consumer2<ThemeProvider, AuthProvider>(
          builder:
              (
                BuildContext context,
                ThemeProvider themeProvider,
                AuthProvider authProvider,
                _,
              ) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: 'BYAMN',
                  theme: AppThemeData.appLightThemeData,
                  darkTheme: AppThemeData.appDarkThemeData,
                  themeMode: themeProvider.themeMode,
                  routerConfig: AppRoute.routes(authProvider),
                  builder: (BuildContext context, Widget? child) {
                    return ConnectivityWrapper(
                      child: child ?? const SizedBox(),
                    );
                  },
                );
              },
        ),
      ),
    );
  }
}
