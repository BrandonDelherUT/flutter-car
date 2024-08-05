import 'package:flutter/material.dart';
import '../data/car_service.dart';
import '../domains/car.dart';

class CarProvider with ChangeNotifier {
  CarService _carService = CarService();
  List<Car> _cars = [];

  List<Car> get cars => _cars;

  Future<void> fetchCars() async {
    try {
      _cars = await _carService.getCars();
      notifyListeners();
    } catch (e) {
      print('Error fetching cars: $e');
    }
  }

  Future<void> addCar(Car car) async {
    try {
      await _carService.addCar(car);
      await fetchCars();
    } catch (e) {
      print('Error adding car: $e');
    }
  }

  Future<void> updateCar(Car car) async {
    try {
      await _carService.updateCar(car);
      await fetchCars();
    } catch (e) {
      print('Error updating car: $e');
    }
  }

  Future<void> deleteCar(String id) async {
    try {
      await _carService.deleteCar(id);
      await fetchCars();
    } catch (e) {
      print('Error deleting car: $e');
    }
  }
}
