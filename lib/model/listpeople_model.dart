import 'dart:convert';
import 'package:flutter/material.dart';

class ListPeopleModel {
  final String id;
  final String name;
  final String nameFile;
  ListPeopleModel({
    @required this.id,
    @required this.name,
    @required this.nameFile,
  });

  ListPeopleModel copyWith({
    String id,
    String name,
    String nameFile,
  }) {
    return ListPeopleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nameFile: nameFile ?? this.nameFile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nameFile': nameFile,
    };
  }

  factory ListPeopleModel.fromMap(Map<String, dynamic> map) {
    return ListPeopleModel(
      id: map['id'],
      name: map['name'],
      nameFile: map['nameFile'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ListPeopleModel.fromJson(String source) => ListPeopleModel.fromMap(json.decode(source));

  @override
  String toString() => 'ListPeopleModel(id: $id, name: $name, nameFile: $nameFile)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ListPeopleModel &&
      other.id == id &&
      other.name == name &&
      other.nameFile == nameFile;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ nameFile.hashCode;
}
