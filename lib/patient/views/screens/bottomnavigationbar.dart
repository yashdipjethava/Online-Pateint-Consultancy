import 'package:aarogyam/patient/views/screens/purchasemedicine.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'digital_consultant.dart';
import 'ecom/ecom.dart';
import 'healthblog.dart';
import 'homescreen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  var _index = 0;

  void updateIndex(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          HomeScreen(
            updateIndex: updateIndex,
          ),
          const DigitalConsult(),
          const EcomMedicine(),
          const PurchaseDetailsScreen(),
          const HealthBlog(),
        ],
      ),
      bottomNavigationBar:  Container(
        color: Colors.teal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GNav(
            gap: 8,
            padding: const EdgeInsets.all(8),
            backgroundColor: Colors.teal,
            color: Colors.white,
            activeColor: Colors.teal,
            tabBackgroundColor: Colors.grey.shade100,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.person_3_sharp,
                text: 'Doctor',
              ),
              GButton(
                icon: Icons.medication_liquid,
                text: 'Medicine',
              ),
              GButton(
                icon: Icons.shopping_cart,
                text: 'Your Orders',
              ),
              GButton(
                icon: Icons.notes,
                text: 'Health Blogs',
              ),
            ],
            selectedIndex: _index,
            onTabChange: updateIndex,
          ),
        ),
      ),
    );
  }
}