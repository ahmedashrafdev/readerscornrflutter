class City {
  final String name;
  final int id;
  City({
    this.name,
    this.id,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}

