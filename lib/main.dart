import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'global/helpers/car_provider.dart';
import 'global/presentation/screeen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CarProvider(),
      child: MaterialApp(
        title: 'Car Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
