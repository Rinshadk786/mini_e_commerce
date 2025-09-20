// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../../model/product.dart';
//
//
// class AdminViewModel extends ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   final nameController = TextEditingController();
//   final priceController = TextEditingController();
//
//   bool _loading = false;
//   bool get loading => _loading;
//
//   Stream<List<Product>> getProducts() {
//     return _firestore.collection('products').snapshots().map((snapshot) =>
//         snapshot.docs
//             .map((doc) => product.fromFirestore(doc.data(), doc.id))
//             .toList());
//   }
//
//   Future<void> addProduct(BuildContext context) async {
//     try {
//       final name = nameController.text.trim();
//       final price = double.tryParse(priceController.text.trim()) ?? 0;
//
//       if (name.isEmpty || price <= 0) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Enter valid product details")),
//         );
//         return;
//       }
//
//       await _firestore.collection('products').add({
//         'name': name,
//         'price': price,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//
//       nameController.clear();
//       priceController.clear();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Product added successfully!')),
//       );
//     } catch (e) {
//       debugPrint("Error adding product: $e");
//     }
//   }
//
//   Future<void> updateProduct(BuildContext context, Product product) async {
//     try {
//       final name = nameController.text.trim();
//       final price = double.tryParse(priceController.text.trim()) ?? 0;
//
//       if (name.isEmpty || price <= 0) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Enter valid product details")),
//         );
//         return;
//       }
//
//       await _firestore.collection('products').doc(product.id).update({
//         'name': name,
//         'price': price,
//       });
//       nameController.clear();
//       priceController.clear();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Product updated successfully!')),
//       );
//     } catch (e) {
//       debugPrint("Error updating product: $e");
//     }
//   }
//
//   Future<void> deleteProduct(BuildContext context, String docId) async {
//     try {
//       await _firestore.collection('products').doc(docId).delete();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Product deleted!')),
//       );
//     } catch (e) {
//       debugPrint("Error deleting product: $e");
//     }
//   }
// }
