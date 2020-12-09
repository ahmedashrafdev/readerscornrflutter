import 'dart:ffi';

class Cart {
  final int id;
  final String name;
  final String slug;
  final String image;
  final double price;
  final String author_name;
  final String avg_rate;
  final int order_limit;
  
  Cart({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.price,
    this.author_name,
    this.avg_rate,
    this.order_limit,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      image: json['image'] as String,
      price: json['price'].toDouble() as double,
      author_name: json['author_name'] as String,
      avg_rate: json['avg_rate'] as String,
      order_limit: json['order_limit'] as int,
    );
  }
}

