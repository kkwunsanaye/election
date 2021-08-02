import 'dart:convert';

class ElectionDateModel {
  final String id;
  final String year;
  final String month;
  final String day;
  final String hour;
  final String minus;
  ElectionDateModel({
    this.id,
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minus,
  });

  ElectionDateModel copyWith({
    String id,
    String year,
    String month,
    String day,
    String hour,
    String minus,
  }) {
    return ElectionDateModel(
      id: id ?? this.id,
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
      hour: hour ?? this.hour,
      minus: minus ?? this.minus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'year': year,
      'month': month,
      'day': day,
      'hour': hour,
      'minus': minus,
    };
  }

  factory ElectionDateModel.fromMap(Map<String, dynamic> map) {
    return ElectionDateModel(
      id: map['id'],
      year: map['year'],
      month: map['month'],
      day: map['day'],
      hour: map['hour'],
      minus: map['minus'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ElectionDateModel.fromJson(String source) => ElectionDateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ElectionDateModel(id: $id, year: $year, month: $month, day: $day, hour: $hour, minus: $minus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ElectionDateModel &&
      other.id == id &&
      other.year == year &&
      other.month == month &&
      other.day == day &&
      other.hour == hour &&
      other.minus == minus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      year.hashCode ^
      month.hashCode ^
      day.hashCode ^
      hour.hashCode ^
      minus.hashCode;
  }
}
