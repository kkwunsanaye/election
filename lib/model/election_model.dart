import 'dart:convert';

class ElectionModel {
  final String id;
 final String name;
 final String image;
  ElectionModel({
    this.id,
    this.name,
    this.image,
  });
  

  ElectionModel copyWith({
    String id,
    String name,
    String image,
  }) {
    return ElectionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory ElectionModel.fromMap(Map<String, dynamic> map) {
    return ElectionModel(
      id: map['id'],
      name: map['name'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ElectionModel.fromJson(String source) => ElectionModel.fromMap(json.decode(source));

  @override
  String toString() => 'ElectionModel(id: $id, name: $name, image: $image)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ElectionModel &&
      other.id == id &&
      other.name == name &&
      other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode;
}
