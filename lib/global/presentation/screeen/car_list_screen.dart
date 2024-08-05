import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helpers/car_provider.dart';
import '../../domains/car.dart';
import '../widgets/car_form.dart';

class CarListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Car List'),
      ),
      body: FutureBuilder(
        future: carProvider.fetchCars(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: carProvider.cars.length,
              itemBuilder: (context, index) {
                final car = carProvider.cars[index];
                return ListTile(
                  title: Text('${car.marca} ${car.modelo}'),
                  subtitle: Text('Max Speed: ${car.velocidadMaxima} km/h'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      carProvider.deleteCar(car.id);
                    },
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => CarForm(car: car),
                    );
                  },
                );
              },
            );
          }
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
