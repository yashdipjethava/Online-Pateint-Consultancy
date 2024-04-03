import 'package:aarogyam/patient/views/screens/ecom/addtocart.dart';
import 'package:aarogyam/patient/views/screens/ecom/allergy.dart';
import 'package:aarogyam/patient/views/screens/ecom/cold.dart';
import 'package:aarogyam/patient/views/screens/ecom/cough.dart';
import 'package:aarogyam/patient/views/screens/ecom/digestion.dart';
import 'package:aarogyam/patient/views/screens/ecom/fever.dart';
import 'package:aarogyam/patient/views/screens/ecom/headache.dart';
import 'package:aarogyam/patient/views/screens/ecom/infection.dart';
import 'package:aarogyam/patient/views/screens/ecom/others.dart';
import 'package:aarogyam/patient/views/screens/ecom/pain.dart';
import 'package:flutter/material.dart';

class EcomMedicine extends StatefulWidget {
  const EcomMedicine({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EcomMedicineState createState() => _EcomMedicineState();
}

class _EcomMedicineState extends State<EcomMedicine> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 9, vsync: this);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        title: const Text('Medicine',style: TextStyle(color: Colors.white),),
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
        bottom: TabBar(
          indicator: const UnderlineTabIndicator(
            insets: EdgeInsets.zero, // Remove the space before the first tab
          ),
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          automaticIndicatorColorAdjustment: true,
          enableFeedback: true,
          unselectedLabelColor: Colors.white,
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(
                text: 'Fever',
              iconMargin: const EdgeInsets.only(top: 10),
              icon: CircleAvatar(
                backgroundColor: Colors.transparent,
                  child: Image.asset('assets/ecom/icons/fever.png',height: 30,width: 30,)),
            ),
            Tab(
              text: 'Cold',
              iconMargin: const EdgeInsets.only(top: 10),
              icon: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/ecom/icons/cold.png',height: 30,width: 30,)),
            ),
            Tab(
              text: 'Headache',
              iconMargin: const EdgeInsets.only(top: 10),
              icon: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/ecom/icons/headache.png',height: 30,width: 30,)),
            ),
            Tab(
              text: 'Allergy',
              iconMargin: const EdgeInsets.only(top: 10),
              icon: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/ecom/icons/allergy.jpg',height: 30,width: 30,)),
            ),
            Tab(
              text: 'Pain',
              iconMargin: const EdgeInsets.only(top: 10),
              icon: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/ecom/icons/pain.png',height: 30,width: 30,)),
            ),
            Tab(
              text: 'Cough',
              iconMargin: const EdgeInsets.only(top: 10),
              icon: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/ecom/icons/cough.png',height: 30,width: 30,)),
            ),
            Tab(
              text: 'Digestion',
              iconMargin: const EdgeInsets.only(top: 10),
              icon: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/ecom/icons/digestion.jpg',height: 30,width: 30,)),
            ),
            Tab(
              text: 'Infection',
              iconMargin: const EdgeInsets.only(top: 10),
              icon: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/ecom/icons/infection.png',height: 30,width: 30,)),
            ),
            Tab(
              text: 'Others',
              iconMargin: const EdgeInsets.only(top: 10),
              icon: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/ecom/icons/others.jpg',height: 30,width: 30,)),
            ),

          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
         FeverScreen(),
         ColdScreen(),
          HeadacheScreen(),
          AllergyScreen(),
          PainScreen(),
          CoughScreen(),
          DigestionScreen(),
          InfectionScreen(),
          OthersScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  const AddToCartScreen(),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart,color: Colors.white,),
      ),
    );
  }


}
