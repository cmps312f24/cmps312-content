class Product {
  late int id;
  late String name;
  late String category;
  late double price;
  late String description;

  Product(
      {required this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.description});

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        category = json['category'],
        price = json['price'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'price': price,
        'description': description,
      };
}
