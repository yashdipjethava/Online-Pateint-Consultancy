import 'package:aarogyam/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onboarding_intro_screen/onboarding_screen.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({super.key});

  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyApp()),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return OnBoardingScreen(
            onSkip: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyApp(),));
            },
            showPrevNextButton: true,
            showIndicator: true,
            backgourndColor:Colors.white,
            activeDotColor: Colors.teal,
            deactiveDotColor: Colors.grey,
            iconColor: Colors.teal,
            leftIcon: Icons.arrow_circle_left_rounded,
            rightIcon: Icons.arrow_circle_right_rounded,
            iconSize: 30,
            pages: [
              OnBoardingModel(
                image: Padding(
                  padding: EdgeInsets.all(constraints.maxWidth * 0.1),
                  child: Image.asset("assets/img/vector/page1.png"),
                ),
                title: "Welcome to Health Care App",
                titleColor: Colors.teal,
                bodyColor: Colors.teal,
                body:
                "Your personal health assistant. Manage your health records, appointments, and more.",
              ),
              OnBoardingModel(
                image: Padding(
                  padding: EdgeInsets.all(constraints.maxWidth * 0.1),
                  child: Image.asset("assets/img/vector/page2.png"),
                ),
                title: "Track Your Health",
                titleColor: Colors.teal,
                bodyColor: Colors.teal,
                body:
                "Keep track of your health data, including medications, lab results, and vitals.",
              ),
              OnBoardingModel(
                image: Padding(
                  padding: EdgeInsets.all(constraints.maxWidth * 0.1),
                  child: Image.asset("assets/img/vector/page3.png"),
                ),
                title: " Medicine Delivery at Your Doorstep",
                titleColor: Colors.teal,
                bodyColor: Colors.teal,
                body:
                "Get your prescribed medications delivered safely and conveniently to your home. Order online, track your delivery, and ensure you never run out of essential medicines.",
              ),
            ],
          );
        },
      ),
    );
  }
}
