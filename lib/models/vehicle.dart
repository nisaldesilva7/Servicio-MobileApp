class Vehicle {
  final String model;
  final String regNo;
  final String brand;
  final String year;


  Vehicle(this.model, this.regNo, this.brand, this.year);
  
  Map<String, dynamic> toJson() => {
    'model': model,
    'regNo': regNo,
    'brand': brand,
    'year': year,
  };
}