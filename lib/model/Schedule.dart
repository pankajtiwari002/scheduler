class Schedule {
  String title;
  int dateTime;
  int id;

  Schedule({
    required this.title,
    required this.dateTime,
    required this.id
  });

  // Convert Schedule model to JSON format
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'dateTime': dateTime,
      'id': id,
    };
  }

  // Create Schedule model from JSON data
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      title: json['title'] ?? '',
      dateTime: json['dateTime'] ?? '',
      id: json['id'] ?? ''
    );
  }

  @override
  String toString() {
    return 'Schedule{title: $title, dateTime: $dateTime}';
  }
}