import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navi_task/model/vehicles/vehicle.dart';
import 'package:navi_task/other/constants.dart';
import 'package:navi_task/services/vehicle_service.dart';
import 'package:navi_task/ui/widget/dialog.dart';

class VehicleResponseWidget extends StatefulWidget {
  final List<Vehicle> vehicles;

  VehicleResponseWidget({this.vehicles});

  @override
  _VehicleResponseWidgetState createState() => _VehicleResponseWidgetState();
}

class _VehicleResponseWidgetState extends State<VehicleResponseWidget> {
  var selected = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selected = widget.vehicles[0].id;
                              });
                            },
                            child: Column(
                              children: [
                                Image.network(
                                  widget.vehicles[0].photo,
                                  width: 75,
                                  height: 75,
                                ),
                                Text(
                                  "${widget.vehicles[0].name}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: selected == widget.vehicles[0].id
                                          ? kButtonColor
                                          : kTextColor2),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selected = widget.vehicles[1].id;
                              });
                            },
                            child: Column(
                              children: [
                                Image.network(
                                  widget.vehicles[1].photo,
                                  width: 75,
                                  height: 75,
                                ),
                                Text(
                                  "${widget.vehicles[1].name}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: selected == widget.vehicles[1].id
                                          ? kButtonColor
                                          : kTextColor2),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'Distance: ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2580EB)),
                          ),
                          Text(
                            '5.2KM | 10min',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: kTextColor),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '60 ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2580EB)),
                                ),
                                Text(
                                  'EGP',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2580EB)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Builder(
                  builder: (context) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                    onPressed: () {
                      confirmTrip(context);
                    },
                    child: Container(
                      child: Text(
                        'Book Now',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  confirmTrip(BuildContext context) async {
    var value = await VehicleService.confirmOrder(selected);
    if (value == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Something wrong Try again')));
    } else {
      showAlertDialog(context , value.result.orderID);
    }
  }
}
