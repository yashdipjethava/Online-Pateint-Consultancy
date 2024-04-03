// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Unhealthy extends StatefulWidget {
  const Unhealthy({super.key});

  @override
  State<Unhealthy> createState() => _UnhealthyState();
}

class _UnhealthyState extends State<Unhealthy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'UNHEALTHY LIFESTYLE',
          style: TextStyle(fontSize: 18),
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
                _testCard('assets/icons/LabTest/Alcohol.png', 'Alcohol'),
                _testCard('assets/icons/LabTest/Smoking.png', 'Smoking'),
                _testCard('assets/images/Stress.png', 'Stress'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                _testCard(
                    'assets/icons/LabTest/Badlife.png', 'Inactive Lifestyle'),
                _testCard('assets/icons/LabTest/Anger.png', 'Anger Management'),
                _testCard(
                    'assets/icons/LabTest/Overdose.png', 'Medicine Overuse'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                _testCard('assets/icons/LabTest/Junkfood.png', 'Junk Food'),
                _testCard('assets/icons/LabTest/Badsleep.png', 'Less Sleep'),
                _testCard('assets/icons/LabTest/Heartburn.png', 'Heartburn'),
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
