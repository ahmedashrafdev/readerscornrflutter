

class Product {
  final int id;
  final int cart_id;
  final String name;
  final String slug;
  final String qty;
  final String isbn;
  final bool inCart;
  final bool inWishlist;
  final String image;
  final double price;
  final String author_name;
  final String avg_rate;
  final int order_limit;
  final String description;
  final String details;
  
  
  Product({
    this.id,
    this.cart_id,
    this.inCart,
    this.inWishlist,
    this.qty,
    this.name,
    this.isbn,
    this.slug,
    this.image,
    this.price,
    this.author_name,
    this.avg_rate,
    this.order_limit,
    this.description,
    this.details,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      cart_id: json['cart_id'] as int,
      qty: json['qty'].toString() as String,
      inCart: json['inCart'] as bool,
      inWishlist: json['inWishlist'] as bool,
      name: json['name'] as String,
      slug: json['slug'] as String,
      isbn: json['isbn'] as String,
      image: json['image'] as String,
      price: json['price'].toDouble() as double,
      author_name: json['author_name'] as String,
      avg_rate: json['avg_rate'] as String,
      description: json['description'] as String,
      details: json['details'] as String,
      order_limit: json['order_limit'] as int,
    );
  }
}

