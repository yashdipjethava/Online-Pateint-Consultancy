  import 'package:flutter/material.dart';

class AddAppointmentSlots extends StatefulWidget {
  @override
  _AddAppointmentSlotsState createState() => _AddAppointmentSlotsState();
}

class _AddAppointmentSlotsState extends State<AddAppointmentSlots> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedOption;
  String _selectedPrice = '';
  int? _selectedNumber;
  List<TimeOfDay> _selectedTimes =
      List.filled(20, TimeOfDay(hour: 0, minute: 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Form Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Select Date:'),
                const SizedBox(height: 8),
                DatePicker(),
                const SizedBox(height: 16),
                const Text('Select Option:'),
                const SizedBox(height: 8),
                DropdownButton<String>(
                  value: _selectedOption,
                  items: const [
                    DropdownMenuItem(
                      value: 'offline',
                      child: Text('offline'),
                    ),
                    DropdownMenuItem(
                      value: 'online',
                      child: Text('online'),
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                  },
                ),
                SizedBox(height: 16),
                Text('Select Price:'),
                SizedBox(height: 8),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _selectedPrice = value;
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Select Number:'),
                const SizedBox(height: 8),
                DropdownButton<int>(
                  value: _selectedNumber,
                  items: <int>[1, 2, 3, 4, 5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
                      .map<DropdownMenuItem<int>>((int value) {
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
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print('Option: $_selectedOption');
                      print('Price: $_selectedPrice');
                      print('Number: $_selectedNumber');
                      print('Times:');
                      for (int i = 0; i < _selectedNumber!; i++) {
                        print('Time ${i + 1}: ${_selectedTimes[i]}');
                      }
                    }
                  },
                  child: const Text('Submit'),
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
          const Icon(Icons.calendar_today),
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

  const TimePicker({required this.index, required this.onChanged});

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
      child: Row(
        children: [
          const Icon(Icons.access_time),
          const SizedBox(width: 8),
          Text(
            'Time ${widget.index + 1}: ${_selectedTime.hour}:${_selectedTime.minute}',
          ),
        ],
      ),
    );
  }
}
