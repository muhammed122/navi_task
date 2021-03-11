import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:navi_task/model/vehicles/vihicles_response.dart';
import 'package:navi_task/provider/vehicle_provider.dart';
import 'package:navi_task/services/location_provider.dart';
import 'package:navi_task/services/vehicle_service.dart';
import 'package:navi_task/ui/widget/from_to_widget.dart';
import 'package:navi_task/ui/widget/vehicles_widget.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  static CameraPosition _kGooglePlex = CameraPosition(
    target:  LatLng(30.044331, 31.242184),
    zoom: 14.4746,
  );

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var fromTextController = TextEditingController();
  var toTextController = TextEditingController();

  //Completer<GoogleMapController> _controller = Completer();
  GoogleMapController myGoogleMapController;
  VehiclesResponse vehiclesResponse;

  LatLng staticCurrentLocation = LatLng(30.044331, 31.242184);
  LatLng staticDestLocation = LatLng(29.996900, 30.968758);

  @override
  void initState() {
    // getVehicles();
    addUserOnMap();
    super.initState();
  }

  getVehicles() async {
    vehiclesResponse = await VehicleService.getVehicles();
  }

  addUserOnMap() async {
    var position = await MyLocationProvider.getUserPosition();
    if (position != null) {
      var pos = LatLng(position.latitude, position.longitude);
      //add user address to text field
      staticCurrentLocation = pos;
    }

    setState(() {
      addWayData();
    });
  }

  addWayData() async {
    fromTextController.text =
        await MyLocationProvider.getAddressFromLocation(staticCurrentLocation);
    toTextController.text =
        await MyLocationProvider.getAddressFromLocation(staticDestLocation);
  }

  confirmWayData() {
    if (staticDestLocation == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Add Trip Distention')));
    } else if (staticCurrentLocation == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Add pick Up')));
    } else {
      Provider.of<VehicleProvider>(context,listen: false).getVehicles();
    }
  }

  List<Marker> markers = [
    Marker(
      markerId: MarkerId("Me"),
      position:  LatLng(30.044331, 31.242184),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    vehiclesResponse = Provider.of<VehicleProvider>(context).vehiclesResponse;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              GoogleMap(
                  initialCameraPosition: MapScreen._kGooglePlex,
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  markers: markers.toSet(),
                  onMapCreated: (GoogleMapController googleController) {
                    setState(() {
                      myGoogleMapController = googleController;
                    });

                    //  addUserOnMap();
                  }),
              FromToWidget(
                fromTextController: fromTextController,
                toTextController: toTextController,
              ),
              vehiclesResponse != null
                  ? Positioned(
                      bottom: 0,
                      child: VehicleResponseWidget(
                        vehicles: vehiclesResponse.result,
                      ),
                    )
                  : Positioned(
                      bottom: 0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                          onPressed: () {
                            confirmWayData();
                          },
                          child: Container(
                            child: Text(
                              ' Done ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
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
