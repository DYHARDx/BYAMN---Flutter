import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/content_provider.dart';
import '../details/opportunity_detail_screen.dart';
import '../../shared/utils/screen_util.dart';
import '../../shared/widgets/opportunity_card.dart';

class InternshipsScreen extends StatelessWidget {
  const InternshipsScreen({super.key});

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
              'Internships',
              style: TextStyle(fontSize: 26.h, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10.h),
            Row(
              children: <Widget>[
                Expanded(
                  child: SegmentedButton<bool>(
                    segments: const <ButtonSegment<bool>>[
                      ButtonSegment<bool>(value: true, label: Text('Grid')),
                      ButtonSegment<bool>(value: false, label: Text('List')),
                    ],
                    selected: <bool>{provider.internshipsGrid},
                    onSelectionChanged: (Set<bool> values) {
                      provider.setInternshipsGrid(values.first);
                    },
                  ),
                ),
                SizedBox(width: 10.w),
                DropdownButton<SortBy>(
                  value: provider.internshipSortBy,
                  items: const <DropdownMenuItem<SortBy>>[
                    DropdownMenuItem<SortBy>(
                      value: SortBy.ratingDesc,
                      child: Text('Top Rated'),
                    ),
                    DropdownMenuItem<SortBy>(
                      value: SortBy.titleAsc,
                      child: Text('Title A-Z'),
                    ),
                  ],
                  onChanged: (SortBy? value) {
                    if (value != null) provider.setInternshipSort(value);
                  },
                ),
              ],
            ),
            SizedBox(height: 10.h),
            if (provider.internshipsGrid)
              GridView.builder(
                itemCount: provider.pagedInternships.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: AppScreenUtil.isMobile(context)
                      ? 2
                      : AppScreenUtil.adaptiveGridCount(context),
                  childAspectRatio: AppScreenUtil.isMobile(context)
                      ? 0.82
                      : 1.05,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final item = provider.pagedInternships[index];
                  return OpportunityCard(
                    item: item,
                    viewMode: OpportunityViewMode.grid,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => OpportunityDetailScreen(item: item),
                        ),
                      );
                    },
                  );
                },
              )
            else
              ...provider.pagedInternships
                  .map(
                    (item) => Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: OpportunityCard(
                        item: item,
                        viewMode: OpportunityViewMode.list,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  OpportunityDetailScreen(item: item),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                  .toList(),
            SizedBox(height: 8.h),
            _PaginationRow(
              page: provider.internshipPage,
              totalPages: provider.totalInternshipPages,
              onPrev: provider.previousInternshipPage,
              onNext: provider.nextInternshipPage,
            ),
          ],
        );
      },
    );
  }
}

class _PaginationRow extends StatelessWidget {
  const _PaginationRow({
    required this.page,
    required this.totalPages,
    required this.onPrev,
    required this.onNext,
  });

  final int page;
  final int totalPages;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        OutlinedButton(onPressed: onPrev, child: const Text('Prev')),
        SizedBox(width: 8.w),
        Text('Page $page / $totalPages', style: TextStyle(fontSize: 13.h)),
        SizedBox(width: 8.w),
        OutlinedButton(onPressed: onNext, child: const Text('Next')),
      ],
    );
  }
}
