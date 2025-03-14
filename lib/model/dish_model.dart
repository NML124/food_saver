class DishModel {
  String image;
  String name;
  double price;
  String description;
  String category;

  DishModel({
    required this.image,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
  });

  factory DishModel.fromMap(Map<String, dynamic> map) {
    return DishModel(
      image: map['image'],
      name: map['name'],
      price: map['price'],
      description: map['description'],
      category: map['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'price': price,
      'description': description,
      'category': category,
    };
  }
}