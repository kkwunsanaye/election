import 'dart:convert';

class ElectionModel {
  final String id;
 final String name;
 final String image;
 final String score;
  ElectionModel({
    this.id,
    this.name,
    this.image,
    this.score,
  });
  

  ElectionModel copyWith({
    String id,
    String name,
    String image,
    String score,
  }) {
    return ElectionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'score': score,
    };
  }

  factory ElectionModel.fromMap(Map<String, dynamic> map) {
    return ElectionModel(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      score: map['score'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ElectionModel.fromJson(String source) => ElectionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ElectionModel(id: $id, name: $name, image: $image, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ElectionModel &&
      other.id == id &&
      other.name == name &&
      other.image == image &&
      other.score == score;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      image.hashCode ^
      score.hashCode;
  }
}
