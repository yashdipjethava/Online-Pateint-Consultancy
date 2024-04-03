import 'package:aarogyam/patient/logic/bloc/digital_bloc.dart';
import 'package:aarogyam/patient/views/screens/slot_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorListScreen extends StatelessWidget {
  const DoctorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Doctor List"),
        ),
        body: BlocBuilder<DigitalBloc, DigitalState>(builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.error.isNotEmpty) {
            return Center(
              child: Text(state.error),
            );
          } else if (state.doctorData.isEmpty) {
            return const Center(
              child: Text("Doctor Unavailable."),
            );
          }
          return ListView.builder(
            itemCount: state.doctorData.length,
            itemBuilder: (context, index) {
              final data = state.doctorData[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (context) =>
                            DigitalBloc()..add(GetSlot(uid: data.uid!)),
                        child: SlotScreen(
                          doctorModel: data,
                        ),
                      ),
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(data.image!),
                ),
                title: Text(data.name ?? ""),
                subtitle: Text(data.address ?? ""),
              );
            },
          );
        }));
  }
}
