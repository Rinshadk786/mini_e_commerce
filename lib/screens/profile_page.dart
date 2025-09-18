import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce/Components/them_button.dart';
import '../auth/login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? email = user?.email;

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
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      drawer: Drawer(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Orders')
              .where('user_email', isEqualTo: email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return ListView(
                children: [
                  DrawerHeader(
                    padding: EdgeInsets.all(20),
                    child: Text("My Orders"),
                  ),
                  ListTile(title: Text("No orders found.")),
                ],
              );
            }
            final orders = snapshot.data!.docs;
            return ListView(
              children: [
                DrawerHeader(
                  padding: EdgeInsets.all(20),
                  child: Text("My Orders"),
                ),
                ...orders.map((order) {
                  final data = order.data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text('Order ID: ${order.id}'),
                    //  subtitle: Text('Total: \$${data['total_price'] ?? 'N/A'}'),
                  );
                }),
              ],
            );
          },
        ),
      ),

      appBar: AppBar(title: Text(email!)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ThemeButton(),
            //  CircleAvatar(child: Icon(Icons.person, size: 30),),
            IconButton(
              icon: const Icon(Icons.logout, size: 30),
              onPressed: () => _showDialog(context),
              tooltip: 'Logout',
            ),
            Text(
              "Logout",
              style: TextStyle(color: Colors.redAccent, fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
