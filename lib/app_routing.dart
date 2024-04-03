import 'package:aarogyam/patient/views/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
class AppRouting{
  
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch (routeSettings.name){
      case '/':
        return MaterialPageRoute(builder: (_)=>  const PatientLoginScreen());
      default:
        return null;
    }
  }
}
