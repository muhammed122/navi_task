import 'package:flutter/material.dart';
import 'package:navi_task/provider/vehicle_provider.dart';
import 'file:///E:/flutter/navi_task/navi_task/lib/ui/screen/MapScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VehicleProvider>(
            create: (context) => VehicleProvider())
      ],
      child: MaterialApp(
          title: 'Navi Task',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MapScreen()),
    );
  }
}
