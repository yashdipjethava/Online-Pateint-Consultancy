import 'package:aarogyam/patient/views/screens/ecom/paymentgatewayscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Summarypage extends StatefulWidget {
  final String medicineName;
  final String manufacturer;
  final double price;

  const Summarypage({
    super.key,
    required this.medicineName,
    required this.manufacturer,
    required this.price,
  });

  @override
  State<Summarypage> createState() => _SummarypageState();
}

class _SummarypageState extends State<Summarypage> {
  double? lat;
  double? long;
  String address = "";
  bool disposed = false; // Flag to track if the state is disposed
  int quantity = 1;

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void getLatLong() {
    if (disposed) return; // Check if the state is disposed
    Future<Position> data = _determinePosition();
    data.then((value) {
      if (disposed) return; // Check if the state is disposed
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });

      getAddress(value.latitude, value.longitude);
    }).catchError((error) {
      if (disposed) return; // Check if the state is disposed
      if (kDebugMode) {
        print("Error $error");
      }
    });
  }

  void showLocationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const ListTile(
            leading: Icon(Icons.location_pin, color: Colors.teal),
            title: Text("Use current location?"),
          ),
          content: const Text("Do you want to use your current location as the address?"),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                getLatLong();
                if (address.isNotEmpty) {
                  addressController.text = '$address (Lat: $lat, Long: $long)';
                }
              },
            ),
          ],
        );
      },
    );
  }

  void getAddress(double latitude, double longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (disposed) return; // Check if the state is disposed
    setState(() {
      address = "${placemarks[0].street!} ${placemarks[0].subLocality!} ${placemarks[0].locality!} ${placemarks[0].postalCode!} ${placemarks[0].administrativeArea!} ${placemarks[0].country!}";
    });
  }
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size  = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        title: const Text('Summary',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: size.height * 0.01,),
              _summarycard('Medicine :- ', widget.medicineName),
              SizedBox(
                height: size.height * 0.01,
              ),
              _summarycard('Manufacturer :- ', widget.manufacturer),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  //  border: Border.all(width: 2, color: Colors.blue),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(1, 1),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(1,1),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Text(
                  'Price:  ₹${widget.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15,
                        child: Text("-",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text('$quantity',
                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                    const SizedBox(width: 5,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          quantity++;
                        });

                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15,
                        child: Text("+",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  //  border: Border.all(width: 2, color: Colors.blue),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(1, 1),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(1,1),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person, color: Colors.black,),
                    border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  //  border: Border.all(width: 2, color: Colors.blue),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(1, 1),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(1,1),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: addressController,
                  onTap: () {
                    showLocationDialog();
                  },
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    prefixIcon: Icon(Icons.location_pin, color: Colors.black,),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  //  border: Border.all(width: 2, color: Colors.blue),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(1, 1),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(1,1),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.black,),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    if (nameController.text.isNotEmpty &&
                        addressController.text.isNotEmpty &&
                        emailController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                            medicineName: widget.medicineName,
                            manufacturer: widget.manufacturer,
                            price: widget.price,
                            name: nameController.text,
                            address: addressController.text,
                            email: emailController.text,
                            quantity: quantity,
                          ),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Missing Details'),
                            content: const Text('Please fill in all the details.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.teal,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                    child: const Center(
                      child: Text(
                        'Buy Now',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Widget _summarycard(String type, String data) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.symmetric(horizontal: 2),
    decoration: BoxDecoration(
      color: Colors.white,
      //  border: Border.all(width: 2, color: Colors.blue),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        const BoxShadow(
          color: Colors.white,
          offset: Offset(1, 1),
          blurRadius: 15,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: Colors.grey.shade400,
          offset: const Offset(1,1),
          blurRadius: 5,
          spreadRadius: 1,
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        Text(data,style: const TextStyle(fontSize: 15,),),
      ],
    ),
  );
}
//AIzaSyCN7n62KYaihhc4adMLyaFd2WgrfBr4hUo