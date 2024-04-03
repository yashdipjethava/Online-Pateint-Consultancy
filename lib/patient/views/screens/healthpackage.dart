

import 'package:flutter/material.dart';

class HealthPackage extends StatefulWidget {
  const HealthPackage({super.key});

  @override
  State<HealthPackage> createState() => _HealthPackageState();
}

class _HealthPackageState extends State<HealthPackage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'HEALTH PACKAGES',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.search,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.shopping_cart,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                _testCard(
                    'assets/icons/LabTest/FullBody.png', 'Full Body checkup'),
                _testCard(
                    'assets/icons/LabTest/Diabetes.png', 'Diabetes Package'),
                _testCard('assets/icons/LabTest/Women.png', 'Women Wellness'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                _testCard(
                    'assets/icons/LabTest/Thyroid.png', 'Thyroid Packages'),
                _testCard('assets/icons/LabTest/Heart.png', 'Heart (Cardiac)'),
                _testCard(
                    'assets/icons/LabTest/Harifall.png', 'Hairfall Packages'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                _testCard('assets/icons/LabTest/Fever.png', 'Fever Packages'),
                _testCard(
                    'assets/icons/LabTest/Vitamins.png', 'Vitamin Packages'),
                _testCard(
                  'assets/icons/LabTest/Kidneys.png',
                  'Kidney Packages',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                _testCard('assets/images/Lab_reports.png', 'Blood Packages'),
                _testCard('assets/icons/LabTest/Liver.png', 'Liver Packages'),
                _testCard('assets/images/Doctor.png', 'Men  Wellness'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _testCard(String imagepath, String title) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.lightBlueAccent.shade100, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Image.asset(
                imagepath,
                width: 100,
                height: 50,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
