import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/content_provider.dart';
import '../details/opportunity_detail_screen.dart';
import '../../shared/utils/screen_util.dart';
import '../../shared/widgets/opportunity_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContentProvider>(
      builder: (BuildContext context, ContentProvider provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppScreenUtil.horizontalPadding(context),
            vertical: 14.h,
          ),
          children: <Widget>[
            Text(
              provider.heroTitle,
              style: TextStyle(fontSize: 28.h, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 8.h),
            Text(
              provider.heroSubtitle,
              style: TextStyle(fontSize: 14.h, color: Colors.grey.shade700),
            ),
            SizedBox(height: 14.h),
            Card(
              child: Padding(
                padding: EdgeInsets.all(14.w),
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: provider.stats
                      .map(
                        (item) => Container(
                          width: AppScreenUtil.isMobile(context)
                              ? double.infinity
                              : 160.w,
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.08),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                item.value,
                                style: TextStyle(
                                  fontSize: 20.h,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                item.label,
                                style: TextStyle(fontSize: 12.h),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              'Why Choose BYAMN?',
              style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.h),
            ...provider.features.map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text(item.title, style: TextStyle(fontSize: 15.h)),
                    subtitle: Text(
                      item.description,
                      style: TextStyle(fontSize: 13.h),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Loved by Students',
              style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.h),
            ...provider.testimonials.map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(item.imageUrl),
                    ),
                    title: Text(item.name, style: TextStyle(fontSize: 15.h)),
                    subtitle: Text(
                      '"${item.quote}"',
                      style: TextStyle(fontSize: 13.h),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Helpful Tools',
              style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 240.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: provider.toolHighlights.length,
                separatorBuilder: (_, __) => SizedBox(width: 10.w),
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: AppScreenUtil.isMobile(context) ? 240.w : 280.w,
                    child: OpportunityCard(
                      item: provider.toolHighlights[index],
                      viewMode: OpportunityViewMode.grid,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => OpportunityDetailScreen(
                              item: provider.toolHighlights[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Jobs & Competitions',
              style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.h),
            ...provider.jobHighlights
                .take(3)
                .map(
                  (item) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: OpportunityCard(
                      item: item,
                      viewMode: OpportunityViewMode.list,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => OpportunityDetailScreen(item: item),
                          ),
                        );
                      },
                    ),
                  ),
                )
                .toList(),
            SizedBox(height: 8.h),
            ...provider.competitionHighlights
                .take(2)
                .map(
                  (item) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: OpportunityCard(
                      item: item,
                      viewMode: OpportunityViewMode.list,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => OpportunityDetailScreen(item: item),
                          ),
                        );
                      },
                    ),
                  ),
                )
                .toList(),
            SizedBox(height: 10.h),
            Text(
              'Grow your Network',
              style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.h),
            ...provider.pagedUsers.map(
              (user) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Card(
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
            ),
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
            SizedBox(height: 10.h),
            Text(
              'Frequently Asked Questions',
              style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.h),
            Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionPanelList(
                elevation: 0,
                expansionCallback: (int index, bool isExpanded) {
                  provider.toggleFaq(index, isExpanded);
                },
                children: provider.faqItems.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final item = entry.value;
                  return ExpansionPanel(
                    canTapOnHeader: true,
                    isExpanded: provider.expandedFaq.contains(index),
                    headerBuilder: (BuildContext context, bool _) {
                      return ListTile(
                        title: Text(
                          item.question,
                          style: TextStyle(
                            fontSize: 14.h,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    },
                    body: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
                      child: Text(
                        item.answer,
                        style: TextStyle(fontSize: 13.h),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
