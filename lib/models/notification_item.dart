class AppNotificationItem {
  const AppNotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.isUnread,
  });

  final String id;
  final String title;
  final String message;
  final String time;
  final bool isUnread;

  factory AppNotificationItem.fromJson(Map<String, dynamic> json) {
    return AppNotificationItem(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      message: (json['message'] ?? '').toString(),
      time: (json['time'] ?? '').toString(),
      isUnread: (json['isUnread'] as bool?) ?? false,
    );
  }
}
