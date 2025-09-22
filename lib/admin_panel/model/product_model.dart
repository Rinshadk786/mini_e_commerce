class Product {
  final String id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required available,
  });

  factory Product.fromFirestore(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      available: true,
    );
  }

  bool get available => true;

  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price, 'timestamp': DateTime.now()};
  }
}
