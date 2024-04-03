// ignore_for_file: file_names, camel_case_types

import 'package:aarogyam/doctor/views/screens/doctor_profileScreen.dart';
import 'package:aarogyam/doctor/views/screens/session_screen.dart';
import 'package:flutter/material.dart';

import 'addAppointment.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            toolbarHeight: 15,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.grey.shade100,
            bottom: const TabBar(
              //isScrollable: true,
                labelColor: Colors.teal,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: 'Add Session',icon: Icon(Icons.add_circle),
                  ),
                  Tab(text: 'View Session',icon: Icon(Icons.add_chart),),
                  Tab(text: 'Profile',icon: Icon(Icons.person),),
                ]),
          ),
          body: const TabBarView(
            children: [
              AddAppointmentSlots(),
              SessionScreen(),
              Doctor_Profile(),
            ],
          ),
        ));
  }
}
