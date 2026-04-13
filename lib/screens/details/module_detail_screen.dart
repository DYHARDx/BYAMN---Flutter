import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/content_provider.dart';
import 'opportunity_detail_screen.dart';

class ModuleDetailScreen extends StatelessWidget {
  const ModuleDetailScreen({
    required this.title,
    required this.subtitle,
    required this.highlights,
    super.key,
  });

  final String title;
  final String subtitle;
  final List<String> highlights;

  bool get _isNetwork {
    final String value = title.toLowerCase();
    return value.contains('network') || value.contains('connection');
  }

  bool get _isMockTests => title.toLowerCase().contains('mock test');
  bool get _isMentorship => title.toLowerCase().contains('mentor');
  bool get _isMembership => title.toLowerCase().contains('membership');
  bool get _isTools => title.toLowerCase().contains('tool');
  bool get _isCareers => title.toLowerCase().contains('career');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontSize: 18.h)),
      ),
      body: Consumer<ContentProvider>(
        builder: (BuildContext context, ContentProvider provider, _) {
          return ListView(
            padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 28.h),
            children: <Widget>[
              _ModuleHeader(title: title, subtitle: subtitle),
              SizedBox(height: 14.h),
              if (_isNetwork) _NetworkSection(provider: provider),
              if (_isMockTests) _MockTestsSection(provider: provider),
              if (_isMentorship) const _MentorshipSection(),
              if (_isMembership) const _MembershipSection(),
              if (_isTools) _ToolsSection(provider: provider),
              if (_isCareers) _CareersSection(provider: provider),
              if (!(_isNetwork ||
                  _isMockTests ||
                  _isMentorship ||
                  _isMembership ||
                  _isTools ||
                  _isCareers))
                _GenericSection(highlights: highlights),
            ],
          );
        },
      ),
    );
  }
}

class _ModuleHeader extends StatelessWidget {
  const _ModuleHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: <Color>[
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.22),
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.16),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 24.h, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8.h),
          Text(subtitle, style: TextStyle(fontSize: 14.h)),
        ],
      ),
    );
  }
}

class _NetworkSection extends StatelessWidget {
  const _NetworkSection({required this.provider});

  final ContentProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Global Community',
          style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8.h),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Search by name or role',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        SizedBox(height: 10.h),
        ...provider.pagedUsers.map(
          (user) => Card(
            margin: EdgeInsets.only(bottom: 10.h),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.imageUrl),
              ),
              title: Text(user.name, style: TextStyle(fontSize: 14.h)),
              subtitle: Text(
                '${user.role} • ${user.location}',
                style: TextStyle(fontSize: 12.h),
              ),
              trailing: FilledButton(
                onPressed: () {},
                child: Text('Connect', style: TextStyle(fontSize: 11.h)),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            OutlinedButton(
              onPressed: provider.previousUserPage,
              child: const Text('Prev'),
            ),
            SizedBox(width: 8.w),
            Text(
              'Page ${provider.userPage} / ${provider.totalUserPages}',
              style: TextStyle(fontSize: 13.h),
            ),
            SizedBox(width: 8.w),
            OutlinedButton(
              onPressed: provider.nextUserPage,
              child: const Text('Next'),
            ),
          ],
        ),
      ],
    );
  }
}

class _MockTestsSection extends StatelessWidget {
  const _MockTestsSection({required this.provider});

  final ContentProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Practice Sets',
          style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8.h),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Search topics: DSA, OOPs, Aptitude...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        SizedBox(height: 10.h),
        ...provider.competitionHighlights.map(
          (item) => Card(
            margin: EdgeInsets.only(bottom: 10.h),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.quiz_outlined, color: Colors.white),
              ),
              title: Text(item.title, style: TextStyle(fontSize: 14.h)),
              subtitle: Text(
                '${item.category} • ${item.duration}',
                style: TextStyle(fontSize: 12.h),
              ),
              trailing: FilledButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => OpportunityDetailScreen(item: item),
                    ),
                  );
                },
                child: Text('Start', style: TextStyle(fontSize: 11.h)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MentorshipSection extends StatelessWidget {
  const _MentorshipSection();

  @override
  Widget build(BuildContext context) {
    final List<_MentorCardData> mentors = <_MentorCardData>[
      const _MentorCardData(
        name: 'Aman Singh',
        role: 'Product & Career Mentor',
        session: '30 min Session',
      ),
      const _MentorCardData(
        name: 'Sana Khan',
        role: 'Frontend & Portfolio Mentor',
        session: '45 min Session',
      ),
      const _MentorCardData(
        name: 'Rohit Verma',
        role: 'Backend & Interview Mentor',
        session: '60 min Session',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Available Mentors',
          style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8.h),
        ...mentors.map(
          (mentor) => Card(
            margin: EdgeInsets.only(bottom: 10.h),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(mentor.name.characters.first.toUpperCase()),
              ),
              title: Text(mentor.name, style: TextStyle(fontSize: 14.h)),
              subtitle: Text(
                '${mentor.role} • ${mentor.session}',
                style: TextStyle(fontSize: 12.h),
              ),
              trailing: FilledButton(
                onPressed: () {},
                child: Text('Book', style: TextStyle(fontSize: 11.h)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MembershipSection extends StatelessWidget {
  const _MembershipSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Membership Plans',
          style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8.h),
        const _PlanCard(
          title: 'Starter',
          price: '₹0 / month',
          points: <String>[
            'Daily updates',
            'Basic filters',
            'Community access',
          ],
        ),
        const _PlanCard(
          title: 'Pro',
          price: '₹199 / month',
          points: <String>[
            'Priority listings',
            'Advanced filters',
            'Interview prep kit',
          ],
        ),
        const _PlanCard(
          title: 'Elite',
          price: '₹499 / month',
          points: <String>[
            '1:1 mentor calls',
            'Resume deep review',
            'Career roadmap tracking',
          ],
        ),
      ],
    );
  }
}

class _ToolsSection extends StatelessWidget {
  const _ToolsSection({required this.provider});

  final ContentProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Useful Tools',
          style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8.h),
        ...provider.toolHighlights.map(
          (item) => Card(
            margin: EdgeInsets.only(bottom: 10.h),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.handyman_outlined)),
              title: Text(item.title, style: TextStyle(fontSize: 14.h)),
              subtitle: Text(item.summary, style: TextStyle(fontSize: 12.h)),
              trailing: FilledButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => OpportunityDetailScreen(item: item),
                    ),
                  );
                },
                child: Text('Open', style: TextStyle(fontSize: 11.h)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CareersSection extends StatelessWidget {
  const _CareersSection({required this.provider});

  final ContentProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Career Tracks',
          style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8.h),
        ...provider.jobHighlights.map(
          (item) => Card(
            margin: EdgeInsets.only(bottom: 10.h),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.badge_outlined)),
              title: Text(item.title, style: TextStyle(fontSize: 14.h)),
              subtitle: Text(
                '${item.provider} • ${item.location}',
                style: TextStyle(fontSize: 12.h),
              ),
              trailing: FilledButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => OpportunityDetailScreen(item: item),
                    ),
                  );
                },
                child: Text('View', style: TextStyle(fontSize: 11.h)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GenericSection extends StatelessWidget {
  const _GenericSection({required this.highlights});

  final List<String> highlights;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'What you get',
          style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8.h),
        ...highlights.map(
          (String item) => Card(
            margin: EdgeInsets.only(bottom: 10.h),
            child: ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: Text(item, style: TextStyle(fontSize: 14.h)),
            ),
          ),
        ),
      ],
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.price,
    required this.points,
  });

  final String title;
  final String price;
  final List<String> points;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 17.h, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 4.h),
            Text(price, style: TextStyle(fontSize: 14.h)),
            SizedBox(height: 8.h),
            ...points.map(
              (point) => Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.check, size: 16),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(point, style: TextStyle(fontSize: 12.h)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 6.h),
            FilledButton(
              onPressed: () {},
              child: Text('Choose Plan', style: TextStyle(fontSize: 12.h)),
            ),
          ],
        ),
      ),
    );
  }
}

class _MentorCardData {
  const _MentorCardData({
    required this.name,
    required this.role,
    required this.session,
  });

  final String name;
  final String role;
  final String session;
}
