

import 'package:flutter/material.dart';

class AllTest extends StatefulWidget {
  const AllTest({super.key});

  @override
  State<AllTest> createState() => _AllTestState();
}
class _AllTestState extends State<AllTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'HEALTH CHECKS',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            //1
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  _testCard('assets/icons/LabTest/FullBody.png', 'Body'),
                  _testCard('assets/icons/LabTest/Diabetes.png', 'Diabetes'),
                  _testCard('assets/icons/LabTest/Women.png', 'Women'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  _testCard('assets/icons/LabTest/Fever.png', 'Fever'),
                  _testCard('assets/icons/LabTest/Vitamins.png', 'Vitamins'),
                  _testCard('assets/icons/LabTest/Liver.png', 'Liver'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  _testCard('assets/icons/LabTest/Kidneys.png', 'Kidney'),
                  _testCard('assets/icons/LabTest/Hormones.png', 'Hormon'),
                  _testCard('assets/icons/LabTest/Dengue.png', 'Dengue'),
                ],
              ),
            ),
            //4
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  _testCard('assets/icons/LabTest/Thyroid.png', 'Thyroid'),
                  _testCard('assets/icons/LabTest/Heart.png', 'Heart'),
                  _testCard('assets/icons/LabTest/Harifall.png', 'Hairfall'),
                ],
              ),
            ),
            //5
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  _testCard('assets/icons/LabTest/Allergy.png', 'Allergy'),
                  _testCard('assets/icons/LabTest/Covid.png', 'Covid'),
                  _testCard('assets/icons/LabTest/Lung.png', 'Lung'),
                ],
              ),
            ),
            //6
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  _testCard('assets/icons/LabTest/Senior.png', 'Seniors'),
                  _testCard('assets/icons/LabTest/Immunity.png', 'Immunity'),
                  _testCard('assets/icons/LabTest/Bones.png', 'Bones'),
                ],
              ),
            ),
            //7
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  _testCard('assets/icons/LabTest/Xray.png', 'Xray'),
                  _testCard('assets/icons/LabTest/SexualHealth.png', 'STD'),
                  _testCard('assets/icons/LabTest/Hepatitis.png', 'Hepatitis'),
                ],
              ),
            ),
            //8
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  _testCard('assets/images/Cough.png', 'infection'),
                  _testCard(
                      'assets/icons/LabTest/Iron_studies.png', 'Iron_study'),
                  _testCard('assets/images/Lab_reports.png', 'Blood'),
                ],
              ),
            ),
          ],
        ),
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
