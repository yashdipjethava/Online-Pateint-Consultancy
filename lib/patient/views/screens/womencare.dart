      // ignore_for_file: file_names

import 'package:flutter/material.dart';

class WomenCare extends StatefulWidget {
  const WomenCare({super.key});

  @override
  State<WomenCare> createState() => _WomenCareState();
}

class _WomenCareState extends State<WomenCare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'WOMEN CARE',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                _testCard('assets/icons/LabTest/pcod.png', 'PCOD'),
                _testCard('assets/icons/LabTest/Pregnancy.png', 'Pregnancy'),
                _testCard('assets/images/Lab_reports.png', 'Blood study'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                _testCard('assets/icons/LabTest/Vitamins.png', 'Vitamins'),
                _testCard(
                    'assets/icons/LabTest/Iron_studies.png', 'Iron Studies'),
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
