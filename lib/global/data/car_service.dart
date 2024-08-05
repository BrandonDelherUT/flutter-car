import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domains/car.dart';

class CarService {
  final String apiUrl = 'https://60o5su2i39.execute-api.us-east-1.amazonaws.com/prod';

  Future<List<Car>> getCars() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/cars'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((car) => Car.fromJson(car)).toList();
      } else {
        print('Failed to load cars: ${response.statusCode} - ${response.reasonPhrase}');
        throw Exception('Failed to load cars');
      }
    } catch (e) {
      print('Error fetching cars: $e');
      rethrow;
    }
  }

  Future<void> addCar(Car car) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/cars'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(car.toJson()),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        print('Failed to add car: ${response.statusCode} - ${response.reasonPhrase}');
        throw Exception('Failed to add car');
      }
    } catch (e) {
      print('Error adding car: $e');
      rethrow;
    }
  }

  Future<void> updateCar(Car car) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/cars'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(car.toJson()),
      );
      if (response.statusCode != 200) {
        print('Failed to update car: ${response.statusCode} - ${response.reasonPhrase}');
        throw Exception('Failed to update car');
      }
    } catch (e) {
      print('Error updating car: $e');
      rethrow;
    }
  }

  Future<void> deleteCar(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/cars'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id}),
      );
      if (response.statusCode != 200) {
        print('Failed to delete car: ${response.statusCode} - ${response.reasonPhrase}');
        throw Exception('Failed to delete car');
      }
    } catch (e) {
      print('Error deleting car: $e');
      rethrow;
    }
  }
}
