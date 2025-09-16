import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_ecommerce/Components/glass_card.dart';
import '../Components/them_button.dart';
import '../auth/login.dart';
import '../model/product.dart';
import 'checkoutpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // close dialog
              },
              child: const Text("No"),
            ),
            LiquidGlass(
              child: TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text("Yes"),
              ),
            ),
          ],
        );
      },
    );
  }

  final List<Product> cart = [];

  void addToCart(Product product) async {
    if (product.available) {
      setState(() {
        cart.add(product);
      });

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('carts').doc(user.uid).collection('items').add({
          'name': product.name,
          'price': product.price,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("${product.name} added to cart")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${product.name} is out of stock")),
      );
    }
  }

  void goToCheckout() {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CheckoutPage(cart: cart)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Home Page"),
        actions: [
          ThemeButton(),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: goToCheckout,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showDialog(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No products found.'));
            }

            final productsDocs = snapshot.data!.docs;
            final products = productsDocs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return Product(
                name: data['name'] ?? 'No Name',
                price: (data['price'] ?? 0).toDouble(),
                available: data['available'] ?? true,
              );
            }).toList();

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "₹${product.price.toStringAsFixed(0)}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        product.available
                            ? ElevatedButton(
                                onPressed: () => addToCart(product),
                                child: const Text("Add to Cart"),
                              )
                            : const Text(
                                "Out of stock",
                                style: TextStyle(color: Colors.red),
                              ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
