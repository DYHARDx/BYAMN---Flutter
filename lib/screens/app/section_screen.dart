import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../models/opportunity_models.dart';
import '../../providers/content_provider.dart';
import '../details/opportunity_detail_screen.dart';
import '../../shared/widgets/opportunity_card.dart';

class SectionScreen extends StatelessWidget {
  const SectionScreen({required this.title, required this.type, super.key});

  final String title;
  final OpportunityType type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontSize: 18.h)),
      ),
      body: Consumer<ContentProvider>(
        builder: (BuildContext context, ContentProvider provider, _) {
          final List<OpportunityItem> items = switch (type) {
            OpportunityType.job => provider.pagedJobs,
            OpportunityType.tool => provider.toolHighlights,
            OpportunityType.competition => provider.competitionHighlights,
            _ => provider.jobHighlights,
          };

          if (items.isEmpty) {
            return const Center(child: Text('No data available.'));
          }

          return ListView.separated(
            padding: EdgeInsets.all(14.w),
            itemBuilder: (BuildContext context, int index) {
              final item = items[index];
              return OpportunityCard(
                item: item,
                viewMode: OpportunityViewMode.list,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => OpportunityDetailScreen(item: item),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (_, __) => SizedBox(height: 10.h),
            itemCount: items.length,
          );
        },
      ),
    );
  }
}
