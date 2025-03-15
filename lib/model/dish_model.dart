class DishModel {
  String image;
  String name;
  double price;
  String description;
  String category;
  String sellerdId;

  DishModel({
    required this.image,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    this.sellerdId = "",
  });

  factory DishModel.fromMap(Map<String, dynamic> map) {
    return DishModel(
      image: map['image'],
      name: map['name'],
      price: map['price'],
      description: map['description'],
      category: map['category'],
      sellerdId: map['seller_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'seller_id': sellerdId,
    };
  }
}
