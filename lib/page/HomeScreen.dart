import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'google_Sign_Api.dart';
import 'loginScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Set<Marker> _marker = {};
  String _address;
  GoogleMapController _controller;
  void _mapController(GoogleMapController controller) async {
    Position _position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    LatLng latLng = LatLng(_position.latitude, _position.longitude);

    setState(() {
      _controller = controller;
      _marker.add(Marker(
          markerId: MarkerId("id-1"),
          position: latLng,
          infoWindow: InfoWindow(
            title: "This is you location",
            // snippet: "Thi is my location "
          )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'My_Location',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 25),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Icon(Icons.location_on_outlined),
          backgroundColor: Colors.black,
          onPressed: () async {
            Position _position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
            );
            LatLng latLng = LatLng(_position.latitude, _position.longitude);
            _controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: latLng, zoom: 15),
            ));
            _getAddress();
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset('assets/locImage.png')),
                        Text(
                          "Location",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0XFF00B686)),
                        ),
                        IconButton(
                            onPressed: () async {
                              await GoogleSignInApi.logout();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            },
                            icon: Icon(Icons.logout)),
                        if (_address != null)
                          Text(
                            _address,
                            style: TextStyle(color: Colors.black, fontSize: 28),
                          )
                      ],
                    ),
                  );
                });
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.red,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  // myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  onMapCreated: _mapController,
                  markers: _marker,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(22.5448131, 88.3403691), zoom: 15),
                ),
              )
            ],
          ),
        ));
  }

  _getAddress() async {
    Position _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      var p = await placemarkFromCoordinates(
          _position.latitude, _position.longitude);
      Placemark placemark = p[0];
      setState(() {
        _address =
            "${placemark.street},${placemark.locality},\n${placemark.postalCode},${placemark.country}";
      });
      print(_address);
    } catch (e) {
      print(e);
    }
  }
}
