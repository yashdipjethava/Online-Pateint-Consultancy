import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final TextEditingController _searchController = TextEditingController();
  final Set<Marker> _markers = {};
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: _currentLocation!,
          infoWindow: const InfoWindow(
            title: 'Current Location',
            snippet: 'This is your current location',
          ),
        ),
      );
      _fetchNearbyHospitals(_currentLocation!);
    });
  }

  void _fetchNearbyHospitals(LatLng position) async {
    const apiKey = 'AIzaSyCN7n62KYaihhc4adMLyaFd2WgrfBr4hUo';
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${position.latitude},${position.longitude}&radius=1500&type=hospital&key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final hospitals = data['results'];
        _markers.clear(); // Clear existing markers
        for (var hospital in hospitals) {
          final name = hospital['name'];
          final lat = hospital['geometry']['location']['lat'];
          final lng = hospital['geometry']['location']['lng'];
          final hospitalLatLng = LatLng(lat, lng);
          _markers.add(
            Marker(
              markerId: MarkerId(name),
              position: hospitalLatLng,
              infoWindow: InfoWindow(title: name),
            ),
          );
        }
        setState(() {});
      }
    }
  }



  void _searchLocation() async {
    String searchText = _searchController.text;
    if (searchText.isEmpty) return;

    List<Location> locations = await locationFromAddress(searchText);
    if (locations.isNotEmpty) {
      Location location = locations.first;
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(location.latitude, location.longitude),
          14,
        ),
      );

      setState(() {
        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId('searchedLocation'),
            position: LatLng(location.latitude, location.longitude),
            infoWindow: InfoWindow(
              title: searchText,
              snippet: 'Searched Location',
            ),
          ),
        );
      });
    }
  }

  void _moveToCurrentLocation() {
    if (_currentLocation != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          _currentLocation!,
          14,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(21.213955, 72.862732),
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                mapController = controller;
              });
            },
            padding: const EdgeInsets.only(bottom: 70, right: 5),
            markers: _markers,

          ),
          Positioned(
            top: 40.0,
            left: 16.0,
            right: 16.0,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: 'Search for a location',
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _searchLocation,
                  child: const Text('Search', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: _moveToCurrentLocation,
        tooltip: 'Current Location',
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
