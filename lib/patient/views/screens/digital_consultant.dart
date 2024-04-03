import 'package:aarogyam/patient/logic/bloc/digital_bloc.dart';
import 'package:aarogyam/patient/views/screens/doctor_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DigitalConsult extends StatefulWidget {
  const DigitalConsult({super.key});

  @override
  State<DigitalConsult> createState() => _DigitalConsultState();
}

class _DigitalConsultState extends State<DigitalConsult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Digital Consult',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                ),
                const Text('Surat',style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.teal),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.teal,
                      ),
                      hintText: 'Search Doctors, Specialities & Symptoms',
                      hintStyle: TextStyle(color: Colors.teal),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  shadowColor: Colors.green,
                  color: Colors.white,
                  elevation: 2,
                  child: Column(
                    children: [
                       const Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Browse by symptoms',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.orange,
                              textDirection: TextDirection.ltr,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.teal, width: 2),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/Cough.png',
                                    width: 45,
                                  ),
                                  const Text(
                                    'Cough',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.teal, width: 2),
                              ),
                              child: Column(
                                children: [
                                  Image.asset('assets/images/Nose.png',
                                      width: 45),
                                  const Text(
                                    'Cold',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.teal, width: 2),
                              ),
                              child: Column(
                                children: [
                                  Image.asset('assets/images/Stress.png',
                                      width: 45),
                                  const Text(
                                    'Stress',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.teal, width: 2),
                              ),
                              child: Column(
                                children: [
                                  Image.asset('assets/images/Throat.png',
                                      width: 45),
                                  const Text(
                                    'Throat',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Specialties for Digital Consult',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.020,
                  vertical: MediaQuery.of(context).size.height * 0.010
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BlocProvider(
                                            create: (context) => DigitalBloc()
                                              ..add(const GetDoctorData(
                                                  specialist: "neurology")),
                                            child: const DoctorListScreen(),
                                          )));
                            },
                            child: _ConsultTile(
                                'assets/images/Neurology.jpg', 'Neurology')),
                        const SizedBox(width: 8),
                        _ConsultTile(
                            'assets/images/Bariatrics.jpg', 'Bariatrics'),
                        const SizedBox(width: 8),
                        _ConsultTile(
                            'assets/images/Cardiology.jpg', 'Cardiology'),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        _ConsultTile(
                            'assets/images/Dermatology.jpg', 'Dermatology'),
                        const SizedBox(width: 8),
                        _ConsultTile(
                            'assets/images/Psychiatry_img.jpg', 'Psychiatry'),
                        const SizedBox(width: 8),
                        _ConsultTile(
                            'assets/images/Paediatrics.jpg', 'Paediatrics'),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        _ConsultTile(
                            'assets/images/Physiotherapy.jpg', 'Physiotherpy'),
                        const SizedBox(width: 8),
                        _ConsultTile(
                            'assets/images/Diabetology.jpg', 'Diabetology'),
                        const SizedBox(width: 8),
                        _ConsultTile('assets/images/Urology.jpg', 'Urology'),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Personal Wellness',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height* 0.11,
                      width: MediaQuery.of(context).size.width* 0.43,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightBlueAccent.shade100,
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/Psychiatry.png',
                            width: 60,
                            height: 65,
                          ),
                          const Text(
                            'Psychiatry',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height* 0.11,
                      width: MediaQuery.of(context).size.width* 0.43,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightBlueAccent.shade100,
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/SexualHealth.png',
                            width: 60,
                            height: 65,
                          ),
                          const Text(
                            'Sexual Health',
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ignore: non_constant_identifier_names
Widget _ConsultTile(String imagepath, String title) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.teal, width: 2),
    ),
    child: Column(
      children: [
        Image.asset(
          imagepath,
          width: 110,
          height: 70,
          fit: BoxFit.cover,
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
