// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:aarogyam/doctor/views/screens/doctor_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor_Profile extends StatefulWidget {
  const Doctor_Profile({super.key});

  @override
  State<Doctor_Profile> createState() => _Doctor_ProfileState();
}

class _Doctor_ProfileState extends State<Doctor_Profile> {
  String name = '';
  String email = '';
  String generalFee = '';
  String dob = '';
  String experience = '';
  String address = '';
  String specialist = '';
  String? imageUrl;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _getUserProfileData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot snapshot =
            await _firestore.collection('request').doc(user.uid).get();

        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          setState(() {
            name = data['name'] ?? '';
            specialist = data['specialist'] ?? '';
            email = data['email'] ?? '';
            address = data['address'] ?? '';
            dob = data['dob'] ?? '';
            generalFee = data['generalFee'] ?? '';
            experience = data['experience'] ?? '';
            imageUrl = data['image'];
          });
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching profile data: $e');
        }
      }
    }
  }

  Future<void> _updateUserProfileData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore.collection('request').doc(user.uid).update({
          'name': name,
          'specialist': specialist,
          'email': email,
          'address': address,
          'experience': experience,
          'dob': dob,
          'generalFee': generalFee,
          'image': imageUrl,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } catch (e) {
        if (kDebugMode) {
          print('Error updating profile data: $e');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update profile'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _showEditDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Edit Doctor Profile')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  radius: 35,
                  backgroundImage: imageUrl != null
                      ? NetworkImage(imageUrl!)
                      : const AssetImage('assets/img/vector/ic_launcher.jpg')
                          as ImageProvider,
                ),
                const SizedBox(height: 20),
                _buildTextField('Name', name, (value) {
                  setState(() {
                    name = value;
                  });
                }),
                _buildTextField('Email', email, (value) {
                  setState(() {
                    email = value;
                  });
                }),
                _buildTextField('Specialist', specialist, (value) {
                  setState(() {
                    specialist = value;
                  });
                }),
                _buildTextField('Enter the Experience', experience, (value) {
                  setState(() {
                    experience = value;
                  });
                }),
                _buildTextField('Date of Birth', dob, (value) {
                  setState(() {
                    dob = value;
                  });
                }),
                _buildTextField('Address', address, (value) {
                  setState(() {
                    address = value;
                  });
                }),
                _buildTextField('General Fee', generalFee, (value) {
                  setState(() {
                    generalFee = value;
                  });
                }),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateUserProfileData();
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }


  Widget _buildTextField(
      String labelText, String value, ValueChanged<String> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        onChanged: onChanged,
        controller: TextEditingController(text: value),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getUserProfileData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(4, 4),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.grey.shade400,
                    offset: const Offset(1, 1),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: imageUrl != null
                        ? NetworkImage(imageUrl!)
                        : const AssetImage('assets/img/vector/ic_launcher.jpg')
                            as ImageProvider,
                  ),
                  SizedBox(width: size.width * 0.04),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. $name',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            specialist,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: const Text(
                'Personal Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: const Divider(),
            ),
            SizedBox(height: size.height * 0.01),
            _DecoratedCard("Date of birth", dob),
            SizedBox(height: size.height * 0.01),
            _DecoratedCard("Email", email),
            SizedBox(height: size.height * 0.01),
            _DecoratedCard("Address", address),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: const Text(
                'Professional Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: const Divider(),
            ),
            SizedBox(height: size.height * 0.01),
            _DecoratedCard('Specialist', specialist),
            SizedBox(height: size.height * 0.01),
            _DecoratedCard("Experience", experience),
            SizedBox(height: size.height * 0.01),
            _DecoratedCard('General Fee', ' ₹$generalFee'),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DocterLoginScreen(),));
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Log Out'),
                ),
                SizedBox(height: size.height * 0.02),
                ElevatedButton.icon(
                  onPressed: _showEditDialog,
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _DecoratedCard(String type, String data) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        const BoxShadow(
          color: Colors.white,
          offset: Offset(4, 4),
          blurRadius: 15,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: Colors.grey.shade400,
          offset: const Offset(1, 1),
          blurRadius: 5,
          spreadRadius: 1,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        Text(data),
        const SizedBox(height: 8),
      ],
    ),
  );
}
