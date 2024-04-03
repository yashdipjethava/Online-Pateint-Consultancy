// ignore_for_file: file_names
import 'package:flutter/material.dart';

class ViewAppointmentScreen extends StatelessWidget {
  final String selectedOption;
  final String selectedPrice;
  final int selectedNumber;
  final List<TimeOfDay> selectedTimes;

  const ViewAppointmentScreen({super.key, 
    required this.selectedOption,
    required this.selectedPrice,
    required this.selectedNumber,
    required this.selectedTimes,
  });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView(
        children: const [
          ListTile(
          )
        ],
      ),
    );
  }
}
