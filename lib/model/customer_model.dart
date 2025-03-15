class CustomerModel {
  String name;
  String localisation;
  String? image;
  String phoneNumber;
  int id;
  CustomerModel({
    required this.id,
    required this.name,
    required this.localisation,
    required this.image,
    required this.phoneNumber,
  });

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map["id"],
      name: map['name'],
      localisation: map['localisation'],
      image: map['image'],
      phoneNumber: map['phoneNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'localisation': localisation, 'image': image};
  }
}
