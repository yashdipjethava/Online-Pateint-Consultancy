import 'package:aarogyam/patient/views/screens/ecom/summarydetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineDetails extends StatefulWidget {
  final String medicineName;
  final String dosageForm;
  final String expiryDate;
  final double price;
  final String medImage;
  final String manufacturer;
  final String medDescription;
  final int stockQuantity;
  final String strength;
  final String useInfo;
  final String docid;

  const MedicineDetails({
    super.key,
    required this.medicineName,
    required this.dosageForm,
    required this.expiryDate,
    required this.price,
    required this.medImage,
    required this.manufacturer,
    required this.medDescription,
    required this.stockQuantity,
    required this.strength,
    required this.useInfo,
    required this.docid,
  });

  @override
  State<MedicineDetails> createState() => _MedicineDetailsState();
}

class _MedicineDetailsState extends State<MedicineDetails> {
  bool isLiked = false;
  bool addedToCart = false;


  final FirebaseAuth auth = FirebaseAuth.instance;
  void _addToCart() {
    var user = auth.currentUser;
    var docID = widget.docid;
    try {
      FirebaseFirestore.instance.collection('cart').doc(user?.uid).collection('items').doc(docID).set({
        'medicineName': widget.medicineName,
        'medImage': widget.medImage,
        'dosageForm': widget.dosageForm,
        'expiryDate': widget.expiryDate,
        'stockQuantity': widget.stockQuantity,
        'price': widget.price,
        'manufacturer': widget.manufacturer,
        'strength': widget.strength,
        'medDescription': widget.medDescription,
        'useInfo': widget.useInfo,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((value) {
        setState(() {
          addedToCart = true;
        });
        if (kDebugMode) {
          print('Data added successfully');
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  String dosageFormUnit = '';
  @override
  void initState() {
    super.initState();
    var user = auth.currentUser;
    var docID = widget.docid;
    FirebaseFirestore.instance.collection('cart').doc(user?.uid).collection('items').doc(docID).get().then((docSnapshot) {
      setState(() {
        addedToCart = docSnapshot.exists;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        title: Text(
          widget.medicineName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),

        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Hero(
                    tag: widget.medImage,
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          widget.medImage,
                          width: MediaQuery.of(context).size.width * 0.60,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : null,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Price: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                      Text(
                        '₹${widget.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  _buildRow('Manufacturer', widget.manufacturer),
                  _buildRow('Stock Quantity', widget.stockQuantity.toString()  ),
                  _buildRow('Description', widget.medDescription),
                  _buildRow('Dosage Form', widget.dosageForm),
                  _buildRow('Expiry Date', widget.expiryDate),
                  _buildRow('Strength', widget.strength),
                  _buildRow('Usage Information', widget.useInfo),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.teal
                            )
                        ),
                        onPressed: addedToCart
                            ? null
                            : () {
                          setState(() {
                            addedToCart = true;
                            _addToCart();
                          });
                        },
                        icon: Icon(
                          addedToCart ? Icons.check : Icons.add_shopping_cart,
                          color: Colors.white,
                        ),
                        label: Text(addedToCart ? 'Added to Cart' : 'Add to Cart',style: const TextStyle(color: Colors.white),),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Colors.teal
                          )
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Summarypage(
                                medicineName: widget.medicineName,
                                manufacturer: widget.manufacturer,
                                price: widget.price,
                              ),
                            ),
                          );
                        },
                        child: const Text('Buy Now',style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildRow(String label, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          data,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

}
