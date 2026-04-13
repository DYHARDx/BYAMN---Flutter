import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/opportunity_models.dart';

enum OpportunityViewMode { grid, list }

class OpportunityCard extends StatelessWidget {
  const OpportunityCard({
    required this.item,
    this.viewMode = OpportunityViewMode.list,
    this.onTap,
    super.key,
  });

  final OpportunityItem item;
  final OpportunityViewMode viewMode;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (viewMode == OpportunityViewMode.grid) {
      return _GridCard(item: item, onTap: onTap);
    }

    return _ListCard(item: item, onTap: onTap);
  }
}

class _GridCard extends StatelessWidget {
  const _GridCard({required this.item, this.onTap});

  final OpportunityItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(bottom: 15),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.imageUrl,
                  height: 80.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 6.h),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      item.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.h,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: item.isFree
                          ? Colors.green.withValues(alpha: 0.16)
                          : Colors.orange.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.isFree ? 'FREE' : 'PREMIUM',
                      style: TextStyle(
                        fontSize: 9.h,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.h, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 4.h),
              Text(item.provider, style: TextStyle(fontSize: 12.h)),
              const Spacer(),
              Row(
                children: <Widget>[
                  Icon(Icons.schedule, size: 16.h),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      item.duration,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11.h),
                    ),
                  ),
                  Icon(Icons.star, size: 16.h, color: Colors.amber.shade600),
                  SizedBox(width: 2.w),
                  Text(
                    item.rating.toStringAsFixed(1),
                    style: TextStyle(fontSize: 11.h),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListCard extends StatelessWidget {
  const _ListCard({required this.item, this.onTap});

  final OpportunityItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.imageUrl,
                  height: 88.h,
                  width: 88.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            item.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.h,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.star,
                          size: 15.h,
                          color: Colors.amber.shade700,
                        ),
                        Text(
                          item.rating.toStringAsFixed(1),
                          style: TextStyle(fontSize: 11.h),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      '${item.provider} • ${item.location}',
                      style: TextStyle(
                        fontSize: 12.h,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      item.summary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11.h),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: <Widget>[
                        Icon(Icons.schedule, size: 14.h),
                        SizedBox(width: 4.w),
                        Text(item.duration, style: TextStyle(fontSize: 11.h)),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: item.isFree
                                ? Colors.green.withValues(alpha: 0.16)
                                : Colors.orange.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item.isFree ? 'FREE' : 'PREMIUM',
                            style: TextStyle(
                              fontSize: 9.h,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 4.w),
              Wrap(
                spacing: 6.w,
                runSpacing: 6.h,
                children: item.tags
                    .take(2)
                    .map(
                      (String tag) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(tag, style: TextStyle(fontSize: 9.h)),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
