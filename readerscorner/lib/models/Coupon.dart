class Coupon {
  final String type;
  final String code;
  final double value;
  final int id;
  Coupon({
    this.type,
    this.code,
    this.value,
    this.id,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'] as int,
      type: json['type'] as String,
      code: json['code'] as String,
      value: json['value'].toDouble() as double,
    );
  }
}

