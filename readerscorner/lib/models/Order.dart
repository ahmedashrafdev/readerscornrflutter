

class Order {
  final int id;
  final int address_id;
  final String date;
  final double discount;
  final double total;
  final double subtotal;
  final String status;
  final String gateway;

  
  
  Order({
    
    this.id,
    this.address_id,
    this.date,
    this.discount,
    this.total,
    this.subtotal,
    this.status,
    this.gateway,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
     
    
    return Order(
      id: json['id'] as int,
      address_id: json['address_id'] as int,
      date: json['date'] as String,
      discount: json['discount'].toDouble() as double,
      total: json['total'].toDouble() as double,
      subtotal: json['subtotal'].toDouble() as double,
      status: json['status'] as String,
      gateway: json['gateway'] as String,
     
    );
  }
}

