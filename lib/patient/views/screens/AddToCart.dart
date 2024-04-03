import 'package:aarogyam/patient/views/screens/MedicineDetailsScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  Future<List<Map<String, dynamic>>> fetchCartItems() async {
    List<Map<String, dynamic>> cartItems = [];
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('cart')
            .doc(user.uid)
            .collection('items')
            .get();

        cartItems = querySnapshot.docs.map((doc) {
          return {
            'documentId': doc.id,
            'medicineName': doc['name'],
            'dosageForm': doc['dosageForm'],
            'expiryDate': doc['expiryDate'],
            'stockQuantity': doc['stockQuantity'],
            'price': doc['price'],
            'medImage': doc['medImage'],
            'manufacturer': doc['manufacturer'],
            'strength': doc['strength'],
            'medDescription': doc['medDescription'],
            'useInfo': doc['useInfo'],
          };
        }).toList();
      }
    } catch (e) {
      print('Error fetching cart items: $e');
    }
    return cartItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Map<String, dynamic>> cartItems = snapshot.data!;
            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MedicineDetailsScreen(
                              medicineDetails: cartItems[index],
                            ),
                          ),
                        );
                      },
                      leading: Image.network(
                        cartItems[index]['medImage'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(cartItems[index]['medicineName']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dosage Form: ${cartItems[index]['dosageForm']}'),
                          Text('Expiry Date: ${cartItems[index]['expiryDate']}'),
                          Text('Stock Quantity: ${cartItems[index]['stockQuantity']}'),
                          Text('Price: ${cartItems[index]['price']}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _removeFromCart(cartItems[index]['documentId']);
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _removeFromCart(String documentId) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('items')
          .doc(documentId)
          .delete()
          .then((value) {
        print('Item removed from cart');
      }).catchError((error) {
        print('Failed to remove item from cart: $error');
      });
    }
  }
}
