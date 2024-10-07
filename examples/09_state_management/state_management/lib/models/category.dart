class Category {
  late int id;
  late String name;
  late String description;

  Category({required this.id, required this.name, required this.description});

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
      };
}
