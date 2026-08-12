class TimetableModel {
  final String subject;
  final String subjectCode;
  final String faculty;
  final String room;
  final DateTime startTime;
  final DateTime endTime;

  const TimetableModel({
    required this.subject,
    required this.subjectCode,
    required this.faculty,
    required this.room,
    required this.startTime,
    required this.endTime,
  });

  factory TimetableModel.fromJson(Map<String, dynamic> json) {
    final now = DateTime.now();

    DateTime parseTime(String t) {
      final parts = t.split(':');
      return DateTime(now.year, now.month, now.day,
          int.parse(parts[0]), int.parse(parts[1]));
    }

    return TimetableModel(
      subject: json['subject'],
      subjectCode: json['subject_code'],
      faculty: json['faculty'],
      room: json['room'],
      startTime: parseTime(json['start_time']),
      endTime: parseTime(json['end_time']),
    );
  }
}
