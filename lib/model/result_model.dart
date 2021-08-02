import 'dart:convert';

class ResultModel {
  final String xValue;
  final int yValue;
  ResultModel({
    this.xValue,
    this.yValue,
  });
  

  ResultModel copyWith({
    String xValue,
    int yValue,
  }) {
    return ResultModel(
      xValue: xValue ?? this.xValue,
      yValue: yValue ?? this.yValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'xValue': xValue,
      'yValue': yValue,
    };
  }

  factory ResultModel.fromMap(Map<String, dynamic> map) {
    return ResultModel(
      xValue: map['xValue'],
      yValue: map['yValue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultModel.fromJson(String source) => ResultModel.fromMap(json.decode(source));

  @override
  String toString() => 'ResultModel(xValue: $xValue, yValue: $yValue)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ResultModel &&
      other.xValue == xValue &&
      other.yValue == yValue;
  }

  @override
  int get hashCode => xValue.hashCode ^ yValue.hashCode;
}
