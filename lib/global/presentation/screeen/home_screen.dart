import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helpers/car_provider.dart';
import '../../domains/car.dart';
import '../widgets/car_form.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Llamamos a fetchCars una sola vez cuando se construye la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CarProvider>(context, listen: false).fetchCars();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Car Management'),
      ),
      body: Consumer<CarProvider>(
        builder: (context, carProvider, child) {
          if (carProvider.cars.isEmpty) {
            return Center(child: Text('No cars found'));
          }
          return ListView.builder(
            itemCount: carProvider.cars.length,
            itemBuilder: (context, index) {
              final car = carProvider.cars[index];
              return ListTile(
                title: Text(car.marca),
                subtitle: Text(car.modelo),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => CarForm(car: car),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        carProvider.deleteCar(car.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => CarForm(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
