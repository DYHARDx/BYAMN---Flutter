import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/content_provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(fontSize: 18.h)),
      ),
      body: Consumer<ContentProvider>(
        builder: (BuildContext context, ContentProvider provider, _) {
          final notifications = provider.notifications;
          if (notifications.isEmpty) {
            return const Center(child: Text('No notifications available.'));
          }

          return ListView.separated(
            padding: EdgeInsets.all(14.w),
            itemBuilder: (BuildContext context, int index) {
              final item = notifications[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: item.isUnread
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.shade500,
                    child: Icon(
                      item.isUnread
                          ? Icons.notifications_active_outlined
                          : Icons.notifications_none_outlined,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(item.title, style: TextStyle(fontSize: 15.h)),
                  subtitle: Text(
                    item.message,
                    style: TextStyle(fontSize: 13.h),
                  ),
                  trailing: Text(item.time, style: TextStyle(fontSize: 12.h)),
                ),
              );
            },
            separatorBuilder: (_, __) => SizedBox(height: 8.h),
            itemCount: notifications.length,
          );
        },
      ),
    );
  }
}
