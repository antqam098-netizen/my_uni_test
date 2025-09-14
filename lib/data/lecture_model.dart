class Lecture {
  int? id;
  final String title;
  final String type; // نظري / عملي
  final String? doctor;
  final String startTime; // HH:mm
  final String place;
  final String day; // الأحد … السبت

  Lecture({
    this.id,
    required this.title,
    required this.type,
    this.doctor,
    required this.startTime,
    required this.place,
    required this.day,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'type': type,
        'doctor': doctor,
        'startTime': startTime,
        'place': place,
        'day': day,
      };

  factory Lecture.fromMap(Map<String, dynamic> map) => Lecture(
        id: map['id'],
        title: map['title'],
        type: map['type'],
        doctor: map['doctor'],
        startTime: map['startTime'],
        place: map['place'],
        day: map['day'],
      );
}
