import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_constants.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _openExternal(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ThemeProvider>(
      builder:
          (
            BuildContext context,
            AuthProvider authProvider,
            ThemeProvider themeProvider,
            _,
          ) {
            final String userName =
                authProvider.currentUser?.displayName.isNotEmpty == true
                ? authProvider.currentUser!.displayName
                : 'BYAMN User';
            final String userEmail =
                authProvider.currentUser?.email ?? 'demo@byamn.in';

            return ListView(
              padding: EdgeInsets.all(16.w),
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(14.w),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 26.h,
                          child: Text(
                            userName.characters.first.toUpperCase(),
                            style: TextStyle(fontSize: 20.h),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                userName,
                                style: TextStyle(
                                  fontSize: 17.h,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(userEmail, style: TextStyle(fontSize: 13.h)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Card(
                  child: SwitchListTile(
                    title: Text('Dark Theme', style: TextStyle(fontSize: 15.h)),
                    subtitle: Text(
                      'Switch to black and gray modern dark mode',
                      style: TextStyle(fontSize: 13.h),
                    ),
                    value: themeProvider.isDarkMode,
                    onChanged: themeProvider.toggleTheme,
                  ),
                ),
                SizedBox(height: 8.h),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Row(
                      children: <Widget>[
                        _MetricTile(title: '520+', subtitle: 'Courses'),
                        _MetricTile(title: '520+', subtitle: 'Internships'),
                        _MetricTile(title: '520+', subtitle: 'Network'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.shield_outlined),
                    title: Text(
                      'Privacy Policy',
                      style: TextStyle(fontSize: 15.h),
                    ),
                    subtitle: Text(
                      'byamn.in/privacy',
                      style: TextStyle(fontSize: 13.h),
                    ),
                    onTap: () => _openExternal(AppConstants.privacyUrl),
                  ),
                ),
                SizedBox(height: 8.h),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.description_outlined),
                    title: Text(
                      'Terms of Use',
                      style: TextStyle(fontSize: 15.h),
                    ),
                    subtitle: Text(
                      'byamn.in/terms',
                      style: TextStyle(fontSize: 13.h),
                    ),
                    onTap: () => _openExternal(AppConstants.termsUrl),
                  ),
                ),
                SizedBox(height: 8.h),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.language_outlined),
                    title: Text(
                      'Explore BYAMN Web',
                      style: TextStyle(fontSize: 15.h),
                    ),
                    subtitle: Text(
                      'Open internships, jobs and tools',
                      style: TextStyle(fontSize: 13.h),
                    ),
                    onTap: () => _openExternal('https://www.byamn.in/'),
                  ),
                ),
                SizedBox(height: 14.h),
                FilledButton.icon(
                  onPressed: authProvider.isLoading
                      ? null
                      : () async {
                          await authProvider.logout();
                        },
                  icon: const Icon(Icons.logout),
                  label: Text('Logout', style: TextStyle(fontSize: 14.h)),
                ),
              ],
            );
          },
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 17.h, fontWeight: FontWeight.w800),
          ),
          Text(subtitle, style: TextStyle(fontSize: 12.h)),
        ],
      ),
    );
  }
}
