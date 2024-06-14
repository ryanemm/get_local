class Event {
  final String? title;
  final String detailedContent;
  final String dateTimestamp;

  Event(
      {required this.title,
      required this.detailedContent,
      required this.dateTimestamp,
});

  factory Event.fromJson(Map<String, dynamic> jsonData) {
    return Event(
      title: jsonData['title'],
      detailedContent: jsonData['detailedContent'],
      dateTimestamp: jsonData['dateTimestamp'],
 
    );
  }
}
