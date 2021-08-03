import 'dart:convert';

class ShowResultModel {
  final String id;
  final String showElection;
  ShowResultModel({
    this.id,
    this.showElection,
  });

  ShowResultModel copyWith({
    String id,
    String showElection,
  }) {
    return ShowResultModel(
      id: id ?? this.id,
      showElection: showElection ?? this.showElection,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'showElection': showElection,
    };
  }

  factory ShowResultModel.fromMap(Map<String, dynamic> map) {
    return ShowResultModel(
      id: map['id'],
      showElection: map['showElection'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShowResultModel.fromJson(String source) => ShowResultModel.fromMap(json.decode(source));

  @override
  String toString() => 'ShowResultModel(id: $id, showElection: $showElection)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ShowResultModel &&
      other.id == id &&
      other.showElection == showElection;
  }

  @override
  int get hashCode => id.hashCode ^ showElection.hashCode;
}
