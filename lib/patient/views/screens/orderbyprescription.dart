// ignore_for_file: file_names

import 'dart:io';

import 'package:aarogyam/patient/views/screens/digital_consultant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Prescription extends StatefulWidget {
  const Prescription({super.key});

  @override
  State<Prescription> createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  File ? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text(
          "UPLOAD PRESCRIPTION",
          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Stack( children: [
            _selectedImage != null
                ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity, // Adjust width as needed
              child: Image.file(
                _selectedImage!,
                fit: BoxFit.cover, // Adjust BoxFit as needed
              ),
            ) :
            SizedBox(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(),
                child:  Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "What is a valid prescription?",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Image.asset("assets/images/presc.jpeg"),
                    ],
                  ),
                ),
              ),
            ),
          ],

          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.36,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Upload prescription from",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(onTap: _pickImagefromGallery,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey)),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.photo,
                                    size: 25,
                                  ),
                                  Text(
                                    'Gallery',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: GestureDetector(
                            onTap: _pickImagefromCamera,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey)),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 25,
                                  ),
                                  Text(
                                    'Camera',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.contact_page,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'My Prescription',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    "Don't have a valid prescription?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.to(const DigitalConsult());
                        },
                        child: const Text(
                          "Click here",
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text("for Aarogyam doctor consultation."),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _pickImagefromGallery () async {
   final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery,);

   if(returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }


  Future _pickImagefromCamera () async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera,);

    if(returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }
}

