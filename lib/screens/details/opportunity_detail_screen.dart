import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/opportunity_models.dart';

class OpportunityDetailScreen extends StatelessWidget {
  const OpportunityDetailScreen({required this.item, super.key});

  final OpportunityItem item;

  Future<void> _openLink() async {
    await launchUrl(Uri.parse(item.url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title, style: TextStyle(fontSize: 17.h))),
      body: ListView(
        padding: EdgeInsets.all(14.w),
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(item.imageUrl, height: 220.h, fit: BoxFit.cover),
          ),
          SizedBox(height: 12.h),
          Text(item.title, style: TextStyle(fontSize: 22.h, fontWeight: FontWeight.w800)),
          SizedBox(height: 6.h),
          Text('${item.provider} • ${item.location}', style: TextStyle(fontSize: 14.h)),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: <Widget>[
              _ChipValue(label: item.category, icon: Icons.category_outlined),
              _ChipValue(label: item.duration, icon: Icons.schedule),
              _ChipValue(label: item.isFree ? 'Free' : 'Premium', icon: Icons.workspace_premium_outlined),
              _ChipValue(label: '⭐ ${item.rating.toStringAsFixed(1)}', icon: Icons.star_outline),
            ],
          ),
          SizedBox(height: 12.h),
          Text('Overview', style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.w700)),
          SizedBox(height: 4.h),
          Text(item.summary, style: TextStyle(fontSize: 14.h)),
          SizedBox(height: 12.h),
          Text('Skills & Tags', style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.w700)),
          SizedBox(height: 6.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: item.tags
                .map(
                  (String tag) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
                    ),
                    child: Text(tag, style: TextStyle(fontSize: 12.h, fontWeight: FontWeight.w600)),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 16.h),
          FilledButton.icon(
            onPressed: _openLink,
            icon: const Icon(Icons.open_in_new),
            label: Text('Open Official Link', style: TextStyle(fontSize: 14.h)),
          ),
        ],
      ),
    );
  }
}

class _ChipValue extends StatelessWidget {
  const _ChipValue({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 15.h),
          SizedBox(width: 4.w),
          Text(label, style: TextStyle(fontSize: 12.h)),
        ],
      ),
    );
  }
}
