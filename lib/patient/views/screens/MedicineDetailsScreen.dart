import 'package:aarogyam/patient/views/screens/persondetailsscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MedicineDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> medicineDetails;

  const MedicineDetailsScreen({super.key, required this.medicineDetails});

  @override
  State<MedicineDetailsScreen> createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  int _quantity = 1;

  void _addToCartFirebase() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(widget.medicineDetails['medImage']),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${widget.medicineDetails['medicineName']}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              const Text('Do you want to add this item to your cart?'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                _addToCart();
                Navigator.popUntil(context, ModalRoute.withName('/Medicine'));

              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _addToCart() {
    var user = auth.currentUser;
    var docID = widget.medicineDetails['documentId'];
    try {
      FirebaseFirestore.instance.collection('cart').doc(user?.uid).collection('items').doc(docID).set({
        'uid': widget.medicineDetails['documentId'],
        'name': widget.medicineDetails['medicineName'],
        'medImage': widget.medicineDetails['medImage'],
        'dosageForm': widget.medicineDetails['dosageForm'],
        'expiryDate': widget.medicineDetails['expiryDate'],
        'stockQuantity': widget.medicineDetails['stockQuantity'],
        'price': widget.medicineDetails['price'],
        'manufacturer': widget.medicineDetails['manufacturer'],
        'strength': widget.medicineDetails['strength'],
        'medDescription': widget.medicineDetails['medDescription'],
        'useInfo': widget.medicineDetails['useInfo'],
        'quantity': _quantity,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Data added successfully');
    } catch (e) {
      print(e.toString());
    }
  }

  void buyNow() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PersonDetailsScreen(
              medicineDetails: widget.medicineDetails,
              addToCartCallback: (Map<String, dynamic> userData) {
                final User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  // Save user details to Firebase Firestore
                  FirebaseFirestore.instance.collection('users')
                      .doc(user.uid)
                      .set(userData)
                      .then((value) {
                    print('User details saved successfully');
                  }).catchError((error) {
                    print('Failed to save user details: $error');
                  });

                  // Save medicine details to user account
                  FirebaseFirestore.instance.collection('users').doc(user.uid)
                      .collection('purchases').add({
                    'name': widget.medicineDetails['medicineName'],
                    'dosageForm': widget.medicineDetails['dosageForm'],
                    'expiryDate': widget.medicineDetails['expiryDate'],
                    'stockQuantity': widget.medicineDetails['stockQuantity'],
                    'price': widget.medicineDetails['price'],
                    'manufacturer': widget.medicineDetails['manufacturer'],
                    'strength': widget.medicineDetails['strength'],
                    'medDescription': widget.medicineDetails['medDescription'],
                    'useInfo': widget.medicineDetails['useInfo'],
                    'quantity': _quantity,
                    'timestamp': FieldValue.serverTimestamp(),
                  })
                      .then((value) {
                    print('Medicine details saved successfully');
                  }).catchError((error) {
                    print('Failed to save medicine details: $error');
                  });
                }
              },
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'MEDICINE DETAILS ',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  widget.medicineDetails['medImage'],
                  height: 250,
                  width: 250,
                  fit: BoxFit.fill,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (_quantity > 1) {
                        setState(() {
                          _quantity--;
                        });
                      }
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Text(
                    '$_quantity',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  const Text('Medicine Name:', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),),
                  Flexible(
                    child: Text(
                      ' ${widget.medicineDetails['medicineName']}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: [
                  const Text('Dosage Form:', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),),
                  Text(
                    ' ${widget.medicineDetails['dosageForm']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: [
                  const Text('Expiry Date:', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),),
                  Text(
                    ' ${widget.medicineDetails['expiryDate']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: [
                  const Text('Stock Quantity:', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),),
                  Text(
                    ' ${widget.medicineDetails['stockQuantity']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: [
                  const Text('Price:', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),),
                  Text(
                    ' ${widget.medicineDetails['price']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: [
                  const Text('Manufacturer:', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),),
                  Text(
                    ' ${widget.medicineDetails['manufacturer']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: [
                  const Text('Strength:', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),),
                  Text(
                    ' ${widget.medicineDetails['strength']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              const Text('Description:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Text(
                ' ${widget.medicineDetails['medDescription']}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 5,),
              const Text('Use Info:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Text(
                ' ${widget.medicineDetails['useInfo']}',
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => _addToCartFirebase(),
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.05,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.35,

                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.teal,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(50))
                      ),
                      child:  const Center(
                          child: Text('Add To Cart', style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),)),
                    ),
                  ),

                  InkWell(
                    onTap: buyNow,
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.05,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.35,

                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.teal,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(50))
                      ),
                      child: const Center(
                          child: Text('Buy Now', style: TextStyle(fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),)),
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
