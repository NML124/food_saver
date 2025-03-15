class DishModel {
  String image;
  String name;
  double price;
  String description;
  String category;
  String sellerdId;
  int quantity;

  DishModel({
    required this.image,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.quantity,
    this.sellerdId = "",
  });

  factory DishModel.fromMap(Map<String, dynamic> map) {
    return DishModel(
      image: map['image'],
      name: map['name'],
      price: double.parse(map['price'].toString()),
      description: map['description'],
      category: map['category'],
      sellerdId: map['seller_id'],
      quantity: map['quantity'] ?? 1,
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
      'quantity': quantity,
    };
  }

  static List<DishModel> fromList(var data) {
    return List<DishModel>.from(data.map((json) => DishModel.fromMap(json)));
  }
}
