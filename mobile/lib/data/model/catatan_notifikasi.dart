enum NotificationKind { success, reminder, rejected }

class NotificationRecord {
  const NotificationRecord({
    required this.title,
    required this.message,
    required this.kind,
    required this.isNew,
  });

  final String title;
  final String message;
  final NotificationKind kind;
  final bool isNew;
}
