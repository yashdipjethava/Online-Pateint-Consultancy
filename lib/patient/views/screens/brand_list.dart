
import 'package:flutter/material.dart';

import '../common_widget/mybutton.dart';

class BrandList extends StatefulWidget {
  const BrandList({super.key});

  @override
  State<BrandList> createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        actions: const [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.search,
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.shopping_cart,
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          _Products("assets/images/Veseline.webp",
              "Vaseline Deep Moisture Body Lotion.", "296"),
          _Products("assets/images/Onetouch1.jpg",
              "OneTouch Select Plus Test Strips.", "799"),
          _Products("assets/images/Ceareve1.webp",
              "CareVe Moisturising Cream for Dry to Very Dry Skin.", "1600"),
          _Products("assets/images/Onetouch2.webp",
              "OneTouch Select Plus Simple Glucometer.", "875"),
          _Products("assets/images/Cerave2.webp",
              "CareVe Foaming Daily Gel Cleanser for Normal Skin.", "1550"),
        ],
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget _Products(String imagepath, String title, String price) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
    child: Card(
      shadowColor: Colors.white,
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(9),
        child: Row(
          children: [
            //image
            Image.asset(
              imagepath,
              width: 80,
            ),const SizedBox(width: 10,),
            //details
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  Text(title),
                  //price
                  Text("₹$price")
                ],
              ),
            ),
            //add button
            const MyButton(text: "ADD"),
          ],
        ),
      ),
    ),
  );
}