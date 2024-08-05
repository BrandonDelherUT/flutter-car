class Car {
  String id;
  String marca;
  String modelo;
  double velocidadMaxima;
  String tipo;

  Car({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.velocidadMaxima,
    required this.tipo,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      marca: json['marca'],
      modelo: json['modelo'],
      velocidadMaxima: json['velocidadMaxima'].toDouble(),
      tipo: json['tipo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'velocidadMaxima': velocidadMaxima,
      'tipo': tipo,
    };
  }
}
