import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helpers/car_provider.dart';
import '../../domains/car.dart';

class CarForm extends StatefulWidget {
  final Car? car;

  CarForm({this.car});

  @override
  _CarFormState createState() => _CarFormState();
}

class _CarFormState extends State<CarForm> {
  final _formKey = GlobalKey<FormState>();
  late String marca;
  late String modelo;
  late double velocidadMaxima;
  late String tipo;
  late TextEditingController _velocidadMaximaController;

  @override
  void initState() {
    super.initState();
    _velocidadMaximaController = TextEditingController();
    if (widget.car != null) {
      marca = widget.car!.marca;
      modelo = widget.car!.modelo;
      velocidadMaxima = widget.car!.velocidadMaxima;
      tipo = widget.car!.tipo;
      _velocidadMaximaController.text = widget.car!.velocidadMaxima.toString();
    }
  }

  @override
  void dispose() {
    _velocidadMaximaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.car == null ? 'Add Car' : 'Edit Car'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: widget.car?.marca,
              decoration: InputDecoration(labelText: 'Marca'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a marca';
                }
                return null;
              },
              onSaved: (value) {
                marca = value!;
              },
            ),
            TextFormField(
              initialValue: widget.car?.modelo,
              decoration: InputDecoration(labelText: 'Modelo'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a modelo';
                }
                return null;
              },
              onSaved: (value) {
                modelo = value!;
              },
            ),
            TextFormField(
              controller: _velocidadMaximaController,
              decoration: InputDecoration(labelText: 'Velocidad Máxima'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a velocidad máxima';
                }
                try {
                  double.parse(value);
                } catch (e) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onSaved: (value) {
                velocidadMaxima = double.parse(value!);
              },
            ),
            TextFormField(
              initialValue: widget.car?.tipo,
              decoration: InputDecoration(labelText: 'Tipo'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a tipo';
                }
                return null;
              },
              onSaved: (value) {
                tipo = value!;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              if (widget.car == null) {
                Provider.of<CarProvider>(context, listen: false).addCar(
                  Car(id: '', marca: marca, modelo: modelo, velocidadMaxima: velocidadMaxima, tipo: tipo),
                );
              } else {
                Provider.of<CarProvider>(context, listen: false).updateCar(
                  Car(id: widget.car!.id, marca: marca, modelo: modelo, velocidadMaxima: velocidadMaxima, tipo: tipo),
                );
              }
              Navigator.of(context).pop();
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
