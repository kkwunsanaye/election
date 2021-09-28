import 'dart:convert';
import 'package:flutter/material.dart';

class OtpAdminModel {
  
final String id;
final String otp;
final String name;
  OtpAdminModel({
    @required this.id,
    @required this.otp,
    @required this.name,
  });



  OtpAdminModel copyWith({
    String id,
    String otp,
    String name,
  }) {
    return OtpAdminModel(
      id: id ?? this.id,
      otp: otp ?? this.otp,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'otp': otp,
      'name': name,
    };
  }

  factory OtpAdminModel.fromMap(Map<String, dynamic> map) {
    return OtpAdminModel(
      id: map['id'],
      otp: map['otp'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OtpAdminModel.fromJson(String source) => OtpAdminModel.fromMap(json.decode(source));

  @override
  String toString() => 'OtpAdminModel(id: $id, otp: $otp, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OtpAdminModel &&
      other.id == id &&
      other.otp == otp &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ otp.hashCode ^ name.hashCode;
}
