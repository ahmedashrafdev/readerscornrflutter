class Address {
  final int id;
  final String phone;
  final String title;
  final int city_id;
  final String building;
  final String city_name;
  final String postal;
  final String apartment;
  final String street;
  final String floor;
  Address({
   this.id,
   this.city_id,
   this.city_name,
    this.phone,
    this.title,
    this.building,
    this.postal,
    this.apartment,
    this.street,
    this.floor,
  });
  
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        id: json['id'] as int,
        city_id: json['city_id'] as int,
        city_name: json['city_name'] as String,
        phone: json['phone'] as String,
        title: json['title'] as String,
        building: json['building'] as String,
        postal: json['postal'] as String,
        apartment: json['apartment'] as String,
        street: json['street'] as String,
        floor: json['floor'] as String,
      
    );
  }
}
