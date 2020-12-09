

class Filter {
  final int id;
  final String name;
  final String slug;
  final String image;
  bool isSelected;
  
  
  Filter({
    this.id,
    this.name,
    this.image,
    this.slug,
    this.isSelected,
 
  });

  factory Filter.fromJson(Map<String, dynamic> json) {
     
    
    return Filter(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      slug: json['slug'] as String,
      isSelected: false,
    );
  }
}

