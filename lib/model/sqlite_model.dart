import 'dart:convert';

class SQLiteModel {
  final int id;
  final String idOtp;
  final String choiceChooseId;
  SQLiteModel({
    this.id,
    this.idOtp,
    this.choiceChooseId,
  });
  

  SQLiteModel copyWith({
    int id,
    String idOtp,
    String choiceChooseId,
  }) {
    return SQLiteModel(
      id: id ?? this.id,
      idOtp: idOtp ?? this.idOtp,
      choiceChooseId: choiceChooseId ?? this.choiceChooseId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idOtp': idOtp,
      'choiceChooseId': choiceChooseId,
    };
  }

  factory SQLiteModel.fromMap(Map<String, dynamic> map) {
    return SQLiteModel(
      id: map['id'],
      idOtp: map['idOtp'],
      choiceChooseId: map['choiceChooseId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SQLiteModel.fromJson(String source) => SQLiteModel.fromMap(json.decode(source));

  @override
  String toString() => 'SQLiteModel(id: $id, idOtp: $idOtp, choiceChooseId: $choiceChooseId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SQLiteModel &&
      other.id == id &&
      other.idOtp == idOtp &&
      other.choiceChooseId == choiceChooseId;
  }

  @override
  int get hashCode => id.hashCode ^ idOtp.hashCode ^ choiceChooseId.hashCode;
}
