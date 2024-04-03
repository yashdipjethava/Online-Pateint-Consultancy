import 'package:aarogyam/patient/views/screens/ecom/medicinedetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OthersScreen extends StatefulWidget {
  const OthersScreen({super.key});

  @override
  State<OthersScreen> createState() => _OthersScreenState();
}

class _OthersScreenState extends State<OthersScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('medicineDetails')
                  .where('medicineType', isEqualTo: 'Others')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var medicineDetails = snapshot.data!.docs;

                return  ListView.builder(
                  itemCount: medicineDetails.length,
                  itemBuilder: (context, index) {
                    var medicineDetail = medicineDetails[index];
                    var medicineName = medicineDetail['medicineName'];
                    var dosageForm = medicineDetail['dosageForm'];
                    var expiryDate = medicineDetail['expiryDate'];
                    var price = medicineDetail['price'];
                    var medImage = medicineDetail['medImage'];
                    var manufacturer = medicineDetail['manufacturer'];
                    var medDescription = medicineDetail['medDescription'];
                    var stockQuantity = medicineDetail['stockQuantity'];
                    var strength = medicineDetail['strength'];
                    var useInfo = medicineDetail['useInfo'];
                    var docID = medicineDetail['documentId'];

                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MedicineDetails(
                                medicineName: medicineName,
                                dosageForm: dosageForm,
                                expiryDate: expiryDate,
                                price: price,
                                medImage: medImage,
                                manufacturer: manufacturer,
                                medDescription: medDescription,
                                stockQuantity: stockQuantity,
                                strength: strength,
                                useInfo: useInfo,
                                docid: docID,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.network(
                                medImage,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    medicineName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text('Dosage Form: $dosageForm'),
                                  Text('Expiry Date: $expiryDate'),
                                  Text('Price: ₹$price',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );


                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
