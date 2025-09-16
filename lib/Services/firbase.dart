// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mini_ecommerce/model/product.dart';
//
// class FirestoreService {
//   final _db = FirebaseFirestore.instance;
//
//
//   Stream<List<Product>> productsStream() {
//     return _db.collection('products').snapshots().map((snap) => snap.docs
//         .map((d) => Product.fromMap(d.id, d.data() as Map<String, dynamic>))
//         .toList());
//   }
//
//
//   Future<String> getUserRole(String uid) async {
//     final doc = await _db.collection('users').doc(uid).get();
//     if (!doc.exists) return 'user';
//     return (doc.data()?['role'] as String?) ?? 'user';
//   }
//
//
//   Future<void> addProduct(Product p) async {
//     await _db.collection('products').add(p.toMap());
//   }
//
//
//   Future<void> updateProduct(Product p) async {
//     await _db.collection('products').doc(p.id).update(p.toMap());
//   }
//
//
//   Future<void> deleteProduct(String id) async {
//     await _db.collection('products').doc(id).delete();
//   }
// }