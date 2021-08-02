import 'dart:convert';

class AmountModel {
  final int amount;
  AmountModel({
     this.amount,
  });
  
  

  AmountModel copyWith({
    int amount,
  }) {
    return AmountModel(
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
    };
  }

  factory AmountModel.fromMap(Map<String, dynamic> map) {
    return AmountModel(
      amount: map['amount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AmountModel.fromJson(String source) => AmountModel.fromMap(json.decode(source));

  @override
  String toString() => 'AmountModel(amount: $amount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AmountModel &&
      other.amount == amount;
  }

  @override
  int get hashCode => amount.hashCode;
}
