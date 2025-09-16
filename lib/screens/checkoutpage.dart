import 'package:flutter/material.dart';
import '../model/product.dart';

class CheckoutPage extends StatefulWidget {
  final List<Product> cart;
  const CheckoutPage({super.key, required this.cart});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    double total = widget.cart.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: widget.cart.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.cart.length,
                      itemBuilder: (context, index) {
                        final product = widget.cart[index];
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text(product.name),
                            subtitle: Text("₹${product.price}"),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  widget.cart.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          "Total: ₹$total",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(5),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Order Placed!")),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text("Place Order"),
                        ),
                        //  ThemeButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
