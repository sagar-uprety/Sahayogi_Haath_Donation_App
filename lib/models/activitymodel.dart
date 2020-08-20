class Product {
  final String description;
  final String name;

  Product({
    this.description,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'name': name,
    };
  }

  Product.fromFirestore(Map<String, dynamic> firestore)
      : description = firestore['description'],
        name = firestore['name'];
}
