import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _phoneNumber = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _userName = '';
  String _gmail = '';
  String _address = '';
  String imageNetwork = "";
  String _age = '';
  String? _gender;

  Future<void> _getUserPhoneNumber() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _phoneNumber = user.phoneNumber!;
      });
    }
  }

  Future<void> _getUserProfileData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot snapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('Profile')
            .doc('profileData')
            .get();

        if (snapshot.exists) {
          Map<String, dynamic> data =
          snapshot.data() as Map<String, dynamic>;
          setState(() {
            _userName = data['username'] ?? '';
            _gmail = data['gmail'] ?? '';
            _address = data['address'] ?? '';
            imageNetwork = data["userImage"] ?? "";
            _age = data["age"] ?? "";
            _gender = data["gender"] ?? "";
          });
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching profile data: $e');
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserPhoneNumber();
    _getUserProfileData();
  }

  File? image;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        setState(() {});
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTap: () {
                            _showEditProfileDialog(context);
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.teal,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: const Color(0xff117790),
                                      backgroundImage: image != null
                                          ? FileImage(image!)
                                          : NetworkImage(
                                          imageNetwork) as ImageProvider,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text('UserName :- $_userName'),
                                        Text('Age :- $_age'),
                                        Text('Gender :- $_gender'),
                                        Text(
                                          _phoneNumber.isNotEmpty
                                              ? 'Mobile no :- ${_phoneNumber.substring(3)}'
                                              : 'Mobile no :- ',
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text('Gmail :- $_gmail'),
                                        Text('Address :- $_address'),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showEditProfileDialog(BuildContext context) async {
    TextEditingController usernameController =
    TextEditingController(text: _userName);
    TextEditingController mobileController =
    TextEditingController(text: _phoneNumber.substring(3));
    TextEditingController gmailController =
    TextEditingController(text: _gmail);
    TextEditingController addressController =
    TextEditingController(text: _address);

    String? newUserName;
    String? newMobile;
    String? newGmail;
    String? newAddress;
    String? newAge;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.teal,
                      width: 2.0,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      final file = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (file != null) {
                        image = File(file.path);
                        setState(() {});
                      }
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      foregroundColor: const Color(0xff117790),
                      backgroundImage: image != null
                          ? FileImage(image!)
                          : NetworkImage(
                          imageNetwork) as ImageProvider,
                    ),
                  ),
                ),
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                  ),
                  onChanged: (value) {
                    newUserName = value;
                  },
                ),
                TextField(
                  controller: TextEditingController(text: _age),
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    hintText: 'Enter your age',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    newAge = value;
                  },
                ),
                Row(
                  children: [
                    Text('Gender: '),
                    Radio<String>(
                      value: 'male',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                    const Text('Male'),
                    Radio<String>(
                      value: 'female',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                    const Text('Female'),
                  ],
                ),
                TextField(
                  controller: mobileController,
                  decoration: const InputDecoration(
                    labelText: 'Mobile',
                    hintText: 'Enter your mobile number',
                  ),
                  onChanged: (value) {
                    newMobile = value;
                  },
                ),
                TextField(
                  controller: gmailController,
                  decoration: const InputDecoration(
                    labelText: 'Gmail',
                    hintText: 'Enter your email address',
                  ),
                  onChanged: (value) {
                    newGmail = value;
                  },
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    hintText: 'Enter your address',
                  ),
                  onChanged: (value) {
                    newAddress = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (newUserName != null) {
                  setState(() {
                    _userName = newUserName!;
                  });
                }
                if (newMobile != null) {
                  setState(() {
                    _phoneNumber = '+91$newMobile';
                  });
                }
                if (newGmail != null) {
                  setState(() {
                    _gmail = newGmail!;
                  });
                }
                if (newAddress != null) {
                  setState(() {
                    _address = newAddress!;
                  });
                }
                if (newAge != null) {
                  setState(() {
                    _age = newAge!;
                  });
                }

                User? user = _auth.currentUser;
                if (user != null && image != null) {
                  try {
                    final storageRef = FirebaseStorage.instance
                        .ref()
                        .child("user_image")
                        .child("${user.uid}.jpg");
                    await storageRef.putFile(image!);
                    final url = await storageRef.getDownloadURL();
                    await _firestore
                        .collection('users')
                        .doc(user.uid)
                        .collection('Profile')
                        .doc('profileData')
                        .set({
                      'username': _userName,
                      'mobile': _phoneNumber.substring(3),
                      'gmail': _gmail,
                      "userImage": url,
                      'address': _address,
                      'age': _age,
                      'gender': _gender,
                    });
                    Navigator.pop(context);
                    _getUserProfileData();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Failed to update profile: $e'),
                    ));
                  }
                } else {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          content: const Text("Please Select image."),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Okay"))
                          ],
                        );
                      }));
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
