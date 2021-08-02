import 'dart:convert';

class OtpModel {
  final String id;
  final String name;
  final String otp;
  final String amount;
  final String status;
  final String choiceChooseIds;
  OtpModel({
    this.id,
    this.name,
    this.otp,
    this.amount,
    this.status,
    this.choiceChooseIds,
  });

  OtpModel copyWith({
    String id,
    String name,
    String otp,
    String amount,
    String status,
    String choiceChooseIds,
  }) {
    return OtpModel(
      id: id ?? this.id,
      name: name ?? this.name,
      otp: otp ?? this.otp,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      choiceChooseIds: choiceChooseIds ?? this.choiceChooseIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'otp': otp,
      'amount': amount,
      'status': status,
      'choiceChooseIds': choiceChooseIds,
    };
  }

  factory OtpModel.fromMap(Map<String, dynamic> map) {
    return OtpModel(
      id: map['id'],
      name: map['name'],
      otp: map['otp'],
      amount: map['amount'],
      status: map['status'],
      choiceChooseIds: map['choiceChooseIds'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OtpModel.fromJson(String source) => OtpModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OtpModel(id: $id, name: $name, otp: $otp, amount: $amount, status: $status, choiceChooseIds: $choiceChooseIds)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OtpModel &&
      other.id == id &&
      other.name == name &&
      other.otp == otp &&
      other.amount == amount &&
      other.status == status &&
      other.choiceChooseIds == choiceChooseIds;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      otp.hashCode ^
      amount.hashCode ^
      status.hashCode ^
      choiceChooseIds.hashCode;
  }
}
