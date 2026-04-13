import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../models/opportunity_models.dart';
import '../../providers/navigation_provider.dart';
import '../../shared/widgets/byamn_app_bar.dart';
import '../courses/courses_screen.dart';
import '../details/module_detail_screen.dart';
import '../home/home_screen.dart';
import '../internships/internships_screen.dart';
import '../notifications/notifications_screen.dart';
import '../profile/profile_screen.dart';
import 'section_screen.dart';

class AppShellScreen extends StatelessWidget {
  const AppShellScreen({super.key});

  void _openSection(BuildContext context, String title, OpportunityType type) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SectionScreen(title: title, type: type),
      ),
    );
  }

  void _openNotifications(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const NotificationsScreen()),
    );
  }

  void _openModule(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<String> highlights,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ModuleDetailScreen(
          title: title,
          subtitle: subtitle,
          highlights: highlights,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    const List<Widget> pages = <Widget>[
      HomeScreen(),
      CoursesScreen(),
      InternshipsScreen(),
      ProfileScreen(),
    ];

    return Consumer<NavigationProvider>(
      builder: (BuildContext context, NavigationProvider navigation, _) {
        final List<String> titles = <String>[
          'BYAMN Home',
          'Explore Courses',
          'Explore Internships',
          'Your Profile',
        ];

        return Scaffold(
          key: scaffoldKey,
          appBar: ByamnAppBar(
            title: titles[navigation.currentIndex],
            onMenuTap: () => scaffoldKey.currentState?.openDrawer(),
            onNotificationTap: () => _openNotifications(context),
          ),
          drawer: Drawer(
            child: SafeArea(
              child: ListView(
                padding: EdgeInsets.all(12.w),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        const CircleAvatar(child: Icon(Icons.person_outline)),
                        SizedBox(width: 10.w),
                        Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16.h,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  _DrawerTile(
                    icon: Icons.home_outlined,
                    title: 'Home',
                    onTap: () {
                      Navigator.pop(context);
                      navigation.changeTab(0);
                    },
                  ),
                  _DrawerTile(
                    icon: Icons.public_outlined,
                    title: 'Global Network',
                    onTap: () {
                      Navigator.pop(context);
                      _openModule(
                        context,
                        title: 'Global Network',
                        subtitle:
                            'Connect with developers, founders and students across India.',
                        highlights: <String>[
                          'Discover 500+ active student profiles',
                          'Connect, follow, and share opportunities',
                          'Find collaborators for hackathons and projects',
                        ],
                      );
                    },
                  ),
                  _DrawerTile(
                    icon: Icons.groups_outlined,
                    title: 'My Connections',
                    onTap: () {
                      Navigator.pop(context);
                      _openModule(
                        context,
                        title: 'My Connections',
                        subtitle:
                            'Manage your saved contacts and community circle.',
                        highlights: <String>[
                          'Connection requests and accepted members',
                          'Track recent interactions',
                          'Build your public tech network',
                        ],
                      );
                    },
                  ),
                  _DrawerTile(
                    icon: Icons.work_outline,
                    title: 'Internships',
                    onTap: () {
                      Navigator.pop(context);
                      navigation.changeTab(2);
                    },
                  ),
                  _DrawerTile(
                    icon: Icons.badge_outlined,
                    title: 'Jobs',
                    onTap: () {
                      Navigator.pop(context);
                      _openSection(context, 'Jobs', OpportunityType.job);
                    },
                  ),
                  _DrawerTile(
                    icon: Icons.emoji_events_outlined,
                    title: 'Competitions',
                    onTap: () {
                      Navigator.pop(context);
                      _openSection(
                        context,
                        'Competitions',
                        OpportunityType.competition,
                      );
                    },
                  ),
                  _DrawerTile(
                    icon: Icons.workspace_premium_outlined,
                    title: 'Membership',
                    onTap: () {
                      Navigator.pop(context);
                      _openModule(
                        context,
                        title: 'Membership',
                        subtitle:
                            'Unlock premium curation and faster opportunity discovery.',
                        highlights: <String>[
                          'Priority listing updates',
                          'Advanced filter presets',
                          'Early access to handpicked opportunities',
                        ],
                      );
                    },
                  ),
                  _DrawerTile(
                    icon: Icons.school_outlined,
                    title: 'Mentorship',
                    onTap: () {
                      Navigator.pop(context);
                      _openModule(
                        context,
                        title: 'Mentorship',
                        subtitle:
                            '1:1 guidance to accelerate your internship and placement journey.',
                        highlights: <String>[
                          'Resume and portfolio review sessions',
                          'Mock interview rounds',
                          'Roadmap planning for role-specific growth',
                        ],
                      );
                    },
                  ),
                  _DrawerTile(
                    icon: Icons.code_outlined,
                    title: 'Mock Tests',
                    onTap: () {
                      Navigator.pop(context);
                      _openModule(
                        context,
                        title: 'Mock Tests',
                        subtitle:
                            'Practice assessments for coding, aptitude and interview prep.',
                        highlights: <String>[
                          'Topic-wise tests with timer',
                          'Difficulty-based filtering',
                          'Performance insights and progress tracking',
                        ],
                      );
                    },
                  ),
                  _DrawerTile(
                    icon: Icons.menu_book_outlined,
                    title: 'Courses',
                    onTap: () {
                      Navigator.pop(context);
                      navigation.changeTab(1);
                    },
                  ),
                  _DrawerTile(
                    icon: Icons.handyman_outlined,
                    title: 'Tools',
                    onTap: () {
                      Navigator.pop(context);
                      _openModule(
                        context,
                        title: 'Tools',
                        subtitle:
                            'Useful AI and productivity tools for students and developers.',
                        highlights: <String>[
                          'Resume and writing tools',
                          'Presentation and note assistants',
                          'Developer productivity stack picks',
                        ],
                      );
                    },
                  ),
                  _DrawerTile(
                    icon: Icons.business_center_outlined,
                    title: 'Careers',
                    onTap: () {
                      Navigator.pop(context);
                      _openModule(
                        context,
                        title: 'Careers',
                        subtitle:
                            'Curated pathways for internships, jobs and long-term growth.',
                        highlights: <String>[
                          'Role-based roadmap recommendations',
                          'Application checklist templates',
                          'Interview prep and strategy notes',
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: navigation.isChangingTab
                ? const Center(child: CircularProgressIndicator())
                : pages[navigation.currentIndex],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: navigation.currentIndex,
            onDestinationSelected: navigation.changeTab,
            destinations: const <NavigationDestination>[
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.menu_book_outlined),
                label: 'Courses',
              ),
              NavigationDestination(
                icon: Icon(Icons.work_outline),
                label: 'Internships',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                label: 'User',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(fontSize: 14.h, fontWeight: FontWeight.w600),
      ),
      onTap: onTap,
    );
  }
}
