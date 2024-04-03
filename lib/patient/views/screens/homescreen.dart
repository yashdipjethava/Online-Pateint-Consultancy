import 'package:aarogyam/patient/logic/cubit/auth_cubit/auth_cubit.dart';
import 'package:aarogyam/patient/logic/cubit/auth_cubit/auth_state.dart';
import 'package:aarogyam/patient/views/screens/chatbot.dart';
import 'package:aarogyam/patient/views/screens/healthblog.dart';
import 'package:aarogyam/patient/views/screens/orderbyprescription.dart';
import 'package:aarogyam/patient/views/screens/profilescreen.dart';
import 'package:aarogyam/patient/views/screens/googlemap/googlemapscreen.dart';
import 'package:aarogyam/patient/views/screens/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.updateIndex});
  final Function(int) updateIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserPhoneNumber();
    _getUserProfileData();
  }

  Future<void> _getUserPhoneNumber() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {});
    }
  }

  String _userName = '';
  String _gmail = '';
  String image = "";
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
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          setState(() {
            _userName = data['username'] ?? '';
            _gmail = data['gmail'] ?? '';
            image = data['userImage'];
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
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        toolbarHeight: 105,
        actions: [
          Container(
            height: size.height * 0.16,
            width: size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              color: Colors.teal,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.01,
                      left: size.height * 0.01,
                      right: size.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (scaffoldKey.currentState!.isDrawerOpen) {
                                scaffoldKey.currentState!.closeDrawer();
                              } else {
                                scaffoldKey.currentState!.openDrawer();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                ),
                                child: Center(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: const Color(0xff117790),
                                    backgroundImage: image.isNotEmpty
                                        ? NetworkImage(image)
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.025,
                          ),
                          Text(
                            _userName.isNotEmpty ? _userName : 'Hi Guest !',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.notifications_active,
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.height * 0.015,
                      top: size.height * 0.0080,
                      right: size.height * 0.015),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.teal,
                        ),
                        // border: OutlineInputBorder(),
                        hintText: 'Search for Medicine,Doctor,Lab Tests',
                        hintStyle: TextStyle(color: Colors.teal, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      key: scaffoldKey,
      backgroundColor: Colors.grey.shade300,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                'Welcome, $_userName',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ),
              accountEmail: Text(
                _gmail,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500),
              ),
              currentAccountPicture: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.5,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: const Color(0xff117790),
                  backgroundImage:
                      image.isNotEmpty ? NetworkImage(image) : null,
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.teal,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.teal,
              ),
              title: const Text(
                'My Profile',
                style:
                    TextStyle(color: Colors.teal, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.calendar_today,
                color: Colors.teal,
              ),
              title: const Text(
                'Appointments',
                style:
                    TextStyle(color: Colors.teal, fontWeight: FontWeight.w500),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.chat,
                color: Colors.teal,
              ),
              title: const Text(
                'Chat with Doctor',
                style:
                    TextStyle(color: Colors.teal, fontWeight: FontWeight.w500),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.teal,
              ),
              title: const Text(
                'Settings',
                style:
                    TextStyle(color: Colors.teal, fontWeight: FontWeight.w500),
              ),
              onTap: () {},
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.person_pin_rounded, color: Colors.teal),
              title: const Text('About',
                  style: TextStyle(
                      color: Colors.teal, fontWeight: FontWeight.w500)),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'aarogyam',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2024 aarogyam',
                  applicationIcon: Image.asset(
                    'assets/images/aarogyam.png',
                    width: 50,
                    height: 50,
                  ), // Set the application icon
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Welcome to our healthcare app, your one-stop solution for all your medical needs. Our app is designed to make healthcare services more accessible and convenient for you. Whether you need to consult with a doctor, schedule an appointment, or buy medicines, our app has you covered.',
                      ),
                    ),
                  ],
                );
              },
            ),
            // Add some spacing between Settings and Logout
            const Divider(), // Add a divider above the logout option
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoggedOutState) {
                  Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const PatientLoginScreen()));
                  Navigator.popUntil(context, (route) => route.isFirst);
                }
              },
              builder: (context, state) {
                return ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.teal,
                  ),
                  title: const Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    if (kDebugMode) {
                      print('log out not worked');
                    }
                    BlocProvider.of<AuthCubit>(context).logOut();
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 9, right: 9),
              child: Card(
                shadowColor: Colors.green,
                elevation: 0,
                color: Colors.white,
                child: ListTile(
                  onTap: () {
                    widget.updateIndex(2);
                  },
                  title: const Text(
                    'Express Delivery',
                    style: TextStyle(color: Colors.teal, fontSize: 15),
                  ),
                  subtitle: Row(
                    children: [
                      Image.asset('assets/images/Medicine.png', width: 28),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Buy Medicine and Essentials',
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ],
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: Card(
                      shadowColor: Colors.green,
                      elevation: 0,
                      color: Colors.white,
                      child: ListTile(
                        onTap: () {
                          widget.updateIndex(1);
                        },
                        leading:
                            Image.asset('assets/images/Doctor.png', width: 35),
                        title: const Text(
                          'Consult Digitaly',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.teal,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const MapScreen();
                          },
                        ));
                      },
                      child: Card(
                        shadowColor: Colors.green,
                        elevation: 0,
                        color: Colors.white,
                        child: ListTile(
                          leading: Image.asset('assets/images/Clinic.png',
                              width: 35),
                          title: const Text(
                            'Visit Hospital',
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.005,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(),
                              height: 50,
                              width: 60,
                              child: Image.asset(
                                'assets/images/chat 1.png',
                              ),
                            ),
                            const Text(
                              'Ask Us!',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Feeling Unwell? ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Take an assessment in less than 3 min',
                                  style: TextStyle(fontSize: 9),
                                ),
                                Text(
                                  'and get suggestion on what to do next',
                                  style: TextStyle(fontSize: 9),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 30,
                                  child: Container(
                                    height: 60,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.orange.shade100,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  left: 25,
                                  child: Image.asset(
                                      'assets/images/medical-report.png',
                                      width: 45),
                                ),
                                Positioned(
                                  top: 50,
                                  left: 35,
                                  child: Text(
                                    'Enter',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.orange.shade700,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Positioned(
                                  top: 60,
                                  left: 25,
                                  child: Text(
                                    'Symptoms',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.orange.shade700,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 30,
                                  child: Container(
                                    height: 60,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue.shade100,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  left: 25,
                                  child: Image.asset(
                                      'assets/images/symptoms.png',
                                      width: 45),
                                ),
                                Positioned(
                                  top: 50,
                                  left: 20,
                                  child: Text(
                                    'Understand',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.blue.shade700,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Positioned(
                                  top: 60,
                                  left: 35,
                                  child: Text(
                                    'causes',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.blue.shade700,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 30,
                                  child: Container(
                                    height: 60,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.greenAccent.shade100,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  left: 25,
                                  child: Image.asset('assets/images/Clinic.png',
                                      width: 45),
                                ),
                                Positioned(
                                  top: 50,
                                  left: 35,
                                  child: Text(
                                    'Enter',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.green.shade700,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Positioned(
                                  top: 60,
                                  left: 25,
                                  child: Text(
                                    'Symptoms',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.green.shade700,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 7),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChatBot(),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.all(15),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'NEXT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
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
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.teal,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/BLOG.png',
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Health Articles & ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'Resources',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'HEALTH BLOG',
                          style: TextStyle(
                              color: Colors.orange.shade400,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        const Text(
                            'Explore healthcare content created everyday by'),
                        const Text('our experts.')
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(const HealthBlog());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.orange.shade300,
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.all(15),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Read latest articles',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
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
            ),
            SizedBox(
              height: size.height * 0.005,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                // margin: EdgeInsets.only(right: 200),
                shadowColor: Colors.green,
                elevation: 0,
                color: Colors.white,
                child: ListTile(
                  onTap: () {
                    Get.to(const Prescription());
                  },
                  leading: Image.asset('assets/images/medical-report.png',
                      width: 45),
                  title: const Text(
                    'Order via Prescription ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: const Text(
                    '25% OFF',
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
