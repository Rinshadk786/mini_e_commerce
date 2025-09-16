// class Product {
//  // final int id;
//   final String name;
//   final double price;
//   final bool available;
//
//   Product({required this.name, required this.price, required this.available});
// }
// models/product_model.dart
class Product {
  //final String id;
  final String name;
  final double price;
  final bool available;
  // final String imageUrl;

  Product({
    // required this.id,
    required this.name,
    required this.price,
    required this.available,
    //required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price, 'available': available};
  }

  factory Product.fromMap(String id, Map<String, dynamic> map) {
    return Product(
      //id: id,
      name: map['name'],
      price: map['price'],
      available: true,
    );
  }
}
