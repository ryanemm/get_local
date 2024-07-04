class Event {
  final String? title;
  final String notification;
  final String time;

  Event({
    required this.title,
    required this.notification,
    required this.time,
  });

  factory Event.fromJson(Map<String, dynamic> jsonData) {
    return Event(
      title: jsonData['title'],
      notification: jsonData['notification'],
      time: jsonData['time'],
    );
  }
}
