import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce/Components/glass_card.dart';
import 'package:mini_ecommerce/Components/them_button.dart';

class AdminHome extends StatelessWidget {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> addProductToFirestore(String name, double price) async {
      try {
        CollectionReference products = FirebaseFirestore.instance.collection(
          'products',
        );
        await products.add({
          'name': name,
          'price': price,
          'timestamp': FieldValue.serverTimestamp(),
        });

        print("Product added successfully!");
      } catch (e) {
        print("Error adding product: $e");
      }
    }

    Future<void> updateProductInFirestore(
        String docId,
        String name,
        double price,
        ) async {
      try {
        CollectionReference products = FirebaseFirestore.instance.collection(
          'products',
        );
        await products.doc(docId).update({'name': name, 'price': price});
        print("Product updated successfully!");
      } catch (e) {
        print("Error updating product: $e");
      }
    }

    Future<void> deleteProductFromFirestore(String docId) async {
      try {
        CollectionReference products = FirebaseFirestore.instance.collection(
          'products',
        );
        await products.doc(docId).delete();
        print("Product deleted successfully!");
      } catch (e) {
        print("Error deleting product: $e");
      }
    }

    void _showEditDialog(BuildContext context, DocumentSnapshot product) {
      _nameController.text = product['name'];
      _priceController.text = product['price'].toString();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit Product'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Product Name'),
                ),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Product Price'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  _nameController.clear();
                  _priceController.clear();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Save'),
                onPressed: () {
                  updateProductInFirestore(
                    product.id,
                    _nameController.text,
                    double.parse(_priceController.text),
                  );
                  _nameController.clear();
                  _priceController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Product updated successfully!')),
                  );
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      drawer: LiquidGlass(
        y: 3,
        x: 3,
        child: Drawer(
          shadowColor: Colors.transparent,
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: ListView(),
        ),
      ),
      floatingActionButton: LiquidGlass(
        x: 2,
        y: 3,
        borderRadius: 20,
        elevation: 0,
        padding: EdgeInsetsGeometry.all(1),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Add New Product'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Product Name'),
                      ),
                      TextField(
                        controller: _priceController,
                        decoration: InputDecoration(labelText: 'Product Price'),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        _nameController.clear();
                        _priceController.clear();
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Add'),
                      onPressed: () {
                        addProductToFirestore(
                          _nameController.text,
                          double.parse(_priceController.text),
                        );
                        _nameController.clear();
                        _priceController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Product added successfully!'),
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        actions: [ThemeButton(), SizedBox(width: 10)],
        title: const Text('Admin Panel'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No products found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(data['name']),
                  subtitle: Text('Price: \$${data['price']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _showEditDialog(context, document);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Confirm Delete'),
                              content: const Text(
                                'Are you sure you want to delete this product?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close dialog
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    deleteProductFromFirestore(document.id);
                                    Navigator.of(context).pop(); // Close dialog
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Product deleted!'),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
