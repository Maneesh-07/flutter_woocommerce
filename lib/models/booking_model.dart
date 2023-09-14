class Product {
  final int id;
  final String name;
  final String slug;
  final String permalink;
  final String price;
  // Add more properties as needed

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.permalink,
    required this.price,
    // Initialize other properties here
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      permalink: json['permalink'],
      price: json['price'],
      // Map other properties from JSON here
    );
  }
}
