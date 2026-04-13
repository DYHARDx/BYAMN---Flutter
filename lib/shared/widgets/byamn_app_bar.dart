import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ByamnAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ByamnAppBar({
    required this.title,
    this.onMenuTap,
    this.onNotificationTap,
    super.key,
  });

  final String title;
  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 72.h,
      titleSpacing: 0,
      title: Container(
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: <Color>[
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.18),
              Theme.of(context).colorScheme.secondary.withValues(alpha: 0.10),
            ],
          ),
          border: Border.all(
            color: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.20),
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 34.h,
              width: 34.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Icon(Icons.school, color: Colors.white, size: 18.h),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        onPressed: onMenuTap,
        icon: const Icon(Icons.menu_rounded),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: onNotificationTap,
          icon: Badge(
            backgroundColor: Colors.redAccent,
            label: const Text('3'),
            child: const Icon(Icons.notifications_outlined),
          ),
        ),
        SizedBox(width: 6.w),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(72.h);
}
