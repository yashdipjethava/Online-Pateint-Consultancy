// ignore_for_file: file_names

import 'package:aarogyam/patient/views/screens/medicinedata.dart';
import 'package:flutter/material.dart';


class MedTile extends StatelessWidget {
  final MedicineData medicineData;

  const MedTile({super.key, required this.medicineData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            const BoxShadow(
              color: Colors.white,
              offset: Offset(4,4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(4,4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ]
      ),
      margin: const EdgeInsets.only(left: 25),
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //image
          Image.asset(
            medicineData.imagepath,
            height: 110,
          ),
          //name
          Expanded(
            child: Text(
              medicineData.name,
              style: const TextStyle(
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
          ),
          //price + rating
          SizedBox(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('₹${medicineData.price}'),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text(
                      medicineData.rating,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
