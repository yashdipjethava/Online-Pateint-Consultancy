import 'package:aarogyam/patient/views/common_widget/medicinescreeen.dart';
import 'package:aarogyam/patient/views/screens/AddToCart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'MedicineDetailsScreen.dart';

class Medicine extends StatefulWidget {
  const Medicine({super.key});

  @override
  State<Medicine> createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Track views for each medicine
  final Map<String, int> _medicineViews = {};

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
        children: [
          Container(
            height: size.height * 0.11,
            width: size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.teal,
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                  EdgeInsets.only(left: size.height * 0.015,top: size.height * 0.045,right: size.height * 0.015 ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child:  TextFormField(
                      controller:_searchController ,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value.toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide.none
                        ),
                        prefixIcon: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                            child: const Icon(Icons.arrow_back,color: Colors.teal,
                            )
                        ),
                        suffixIcon: const Icon(
                          Icons.search,
                          color: Colors.teal,
                        ),
                        // border: OutlineInputBorder(),
                        hintText: 'Search for Medicine,Doctor,Lab Tests',
                        hintStyle: const TextStyle(color: Colors.teal),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            children: [
              bannerWidget(
                size,   text: "Get 25% Off",
                icon: FontAwesomeIcons.tags,),
              bannerWidget(
                size,   text: "Free Delivery",
                icon: FontAwesomeIcons.truckMedical,),

            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'MOST VIEWED MEDICINES',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: Colors.white),
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('MostviewedMedicine').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No data available'),
                );
              }

              List<DocumentSnapshot> mostViewedMedicines = snapshot.data!.docs;
              mostViewedMedicines.sort((a, b) => (b['mostViewed'] as int).compareTo(a['mostViewed'] as int));
              mostViewedMedicines = mostViewedMedicines.take(10).toList();

              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: size.width *0.03),
                child: Container(
                 decoration: const BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(10)),
                   color: Colors.white
                 ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: mostViewedMedicines.map((medicine) {
                        var medicineData = medicine.data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(medicineData['medImage']),
                              ),
                              Text(medicineData['medicineName']),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'VALUE DEALS FOR YOU',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('medicineDetails').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No data available'),
                  );
                }

                // Update views count for each medicine
                for (var doc in snapshot.data!.docs) {
                  _medicineViews.putIfAbsent(doc.id, () => 0);
                }

                List<DocumentSnapshot> medicines = snapshot.data!.docs.where((medicine) {
                  var data = medicine.data() as Map<String, dynamic>;
                  return data['medicineName'].toLowerCase().contains(_searchQuery) ||
                      data['dosageForm'].toLowerCase().contains(_searchQuery) ||
                      data['expiryDate'].toLowerCase().contains(_searchQuery);
                }).toList();

                // Sort medicines based on views count
                medicines.sort((a, b) => _medicineViews[b.id]!.compareTo(_medicineViews[a.id]!));

                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: size.width * 0.030),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                    ),
                    child: ListView.builder(
                      itemCount: medicines.length,
                      itemBuilder: (context, index) {
                        var medicine = medicines[index].data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  MedicineDetailsScreen(medicineDetails: medicine),));
                              setState(() {
                                _medicineViews[medicines[index].id] = (_medicineViews[medicines[index].id] ?? 0) + 1;
                              });

                              await FirebaseFirestore.instance.collection('MostviewedMedicine').doc(medicines[index].id).set({
                                'medicineName': medicine['medicineName'],
                                'dosageForm': medicine['dosageForm'],
                                'expiryDate': medicine['expiryDate'],
                                'stockQuantity': medicine['stockQuantity'],
                                'price': medicine['price'],
                                'medImage': medicine['medImage'],
                                'mostViewed': _medicineViews[medicines[index].id],
                              });

                            },
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.160,
                              width: MediaQuery.of(context).size.width * 0.12,
                              child: Row(
                                children: [
                                  Image.network(medicine['medImage'], width: 80, height: 80, fit: BoxFit.fill,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(medicine['medicineName'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                        Text('Dosage Form: ${medicine['dosageForm']}'),
                                        Text('Expiry Date: ${medicine['expiryDate']}'),
                                        Text('Stock Quantity: ${medicine['stockQuantity']}'),
                                        Text('Price: ${medicine['price']}'),
                                        const SizedBox(height: 5,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddToCartScreen(),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}