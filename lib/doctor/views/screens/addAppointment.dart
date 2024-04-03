// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddAppointmentSlots extends StatefulWidget {
  const AddAppointmentSlots({super.key});

  @override
  _AddAppointmentSlotsState createState() => _AddAppointmentSlotsState();
}

class _AddAppointmentSlotsState extends State<AddAppointmentSlots> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedOption;
  String _selectedPrice = '';
  int? _selectedNumber;
  List<TimeOfDay> _selectedTimes =
      List.filled(20, const TimeOfDay(hour: 0, minute: 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Make your schedule',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                const Divider(
                  height: 25,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //  border: Border.all(width: 2, color: Colors.blue),
                    borderRadius: BorderRadius.circular(12),
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: Colors.white,
                    //     offset: Offset(4, 4),
                    //     blurRadius: 15,
                    //     spreadRadius: 1,
                    //   ),
                    //   BoxShadow(
                    //     color: Colors.grey,
                    //     offset: Offset(4, 4),
                    //     blurRadius: 15,
                    //     spreadRadius: 1,
                    //   ),
                    // ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Select Date:',
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 8),
                      DatePicker(),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //  border: Border.all(width: 2, color: Colors.blue),
                    borderRadius: BorderRadius.circular(12),
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: Colors.white,
                    //     offset: Offset(4, 4),
                    //     blurRadius: 15,
                    //     spreadRadius: 1,
                    //   ),
                    //   BoxShadow(
                    //     color: Colors.grey,
                    //     offset: Offset(4, 4),
                    //     blurRadius: 15,
                    //     spreadRadius: 1,
                    //   ),
                    // ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Price:',
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _selectedPrice = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: 'Price',
                            prefixIcon: Icon(Icons.currency_rupee)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the price';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //  border: Border.all(width: 2, color: Colors.blue),
                    borderRadius: BorderRadius.circular(12),
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: Colors.white,
                    //     offset: Offset(4, 4),
                    //     blurRadius: 15,
                    //     spreadRadius: 1,
                    //   ),
                    //   BoxShadow(
                    //     color: Colors.grey,
                    //     offset: Offset(4, 4),
                    //     blurRadius: 15,
                    //     spreadRadius: 1,
                    //   ),
                    // ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Select Option:',
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      DropdownButton<String>(
                        value: _selectedOption,
                        items: const [
                          DropdownMenuItem(
                            value: 'offline',
                            child: Text('Clinic Visit'),
                          ),
                          DropdownMenuItem(
                            value: 'online',
                            child: Text('Video Consult'),
                          )
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //  border: Border.all(width: 2, color: Colors.blue),
                    borderRadius: BorderRadius.circular(12),
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: Colors.white,
                    //     offset: Offset(4, 4),
                    //     blurRadius: 15,
                    //     spreadRadius: 1,
                    //   ),
                    //   BoxShadow(
                    //     color: Colors.grey,
                    //     offset: Offset(4, 4),
                    //     blurRadius: 15,
                    //     spreadRadius: 1,
                    //   ),
                    // ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Select Slots:',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(height: 8),
                          DropdownButton<int>(
                            value: _selectedNumber,
                            items: <int>[
                              1,
                              2,
                              3,
                              4,
                              5,
                              6,
                              7,
                              8,
                              9,
                              10,
                            ].map<DropdownMenuItem<int>>((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text('$value'),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedNumber = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      const SizedBox(height: 16),
                      if (_selectedNumber != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            _selectedNumber!,
                            (index) => TimePicker(
                              index: index,
                              onChanged: (time) {
                                setState(() {
                                  _selectedTimes[index] = time;
                                });
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Show a confirmation dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm Appointment'),
                            content: const Text(
                                'Are you sure you want to add this appointment?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(
                                      false); // No, don't add the appointment
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(true); // Yes, add the appointment
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          );
                        },
                      ).then((confirmed) {
                        if (confirmed != null && confirmed) {
                          // Extract selected time slots from _selectedTimes list
                          List<TimeOfDay> selectedSlots =
                              _selectedTimes.sublist(0, _selectedNumber!);
                          final dateTime = DateTime.now();
                          int count = 0;
                          // Convert TimeOfDay objects to formatted strings
                          List<Map<String, dynamic>> formattedSlots =
                              selectedSlots.map((time) {
                                count++;
                            return {
                              "slot$count":[DateTime(dateTime.year,dateTime.month,dateTime.day,time.hour,time.minute),false]
                            };
                          }).toList();
                          // Add data to Firestore
                          final uid = FirebaseAuth.instance.currentUser?.uid;
                          FirebaseFirestore.instance
                              .collection('TimeSlot')
                              .doc(uid)
                              .collection("Slot")
                              .add({
                            'option': _selectedOption,
                            'price': _selectedPrice,
                            'doctorId': uid,
                            'slot': _selectedNumber,
                            'times': formattedSlots,
                            'timestamp': DateTime.now(),
                          }).then((value) {
                            // Data added successfully
                            if (kDebugMode) {
                              print('Appointment added to Firestore');
                            }
                            // Clear all fields
                            setState(() {
                              _selectedOption = null;
                              _selectedPrice = '';
                              _selectedNumber = null;
                              _selectedTimes = List.filled(
                                  20, const TimeOfDay(hour: 0, minute: 0));
                            });
                            // Show a message that appointment is added
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Appointment added successfully')),
                            );
                          }).catchError((error) {
                            // Error adding data
                            if (kDebugMode) {
                              print('Error adding appointment: $error');
                            }
                          });
                        }
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.indigo[300],
                        borderRadius: BorderRadius.circular(40)),
                    padding: const EdgeInsets.all(20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  static DateTime selectedDate = DateTime.now();

  const DatePicker({super.key});

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DatePicker.selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        ).then((pickedDate) {
          if (pickedDate != null && pickedDate != DatePicker.selectedDate) {
            setState(() {
              DatePicker.selectedDate = pickedDate;
            });
          }
        });
      },
      child: Row(
        children: [
          Icon(
            Icons.calendar_month,
            color: Colors.orange[200],
          ),
          const SizedBox(width: 8),
          Text(
            '${DatePicker.selectedDate.year}-${DatePicker.selectedDate.month}-${DatePicker.selectedDate.day}',
          ),
        ],
      ),
    );
  }
}

class TimePicker extends StatefulWidget {
  final int index;
  final ValueChanged<TimeOfDay> onChanged;

  const TimePicker({super.key, required this.index, required this.onChanged});

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay _selectedTime = const TimeOfDay(hour: 0, minute: 0);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showTimePicker(
          context: context,
          initialTime: _selectedTime,
        ).then((pickedTime) {
          if (pickedTime != null && pickedTime != _selectedTime) {
            setState(() {
              _selectedTime = pickedTime;
              widget.onChanged(_selectedTime);
            });
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.orange.shade200, width: 2),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            const Icon(Icons.access_time),
            const SizedBox(width: 8),
            Text(
              'Slot time ${widget.index + 1} | ${_selectedTime.hour}:${_selectedTime.minute}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
