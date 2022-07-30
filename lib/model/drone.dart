class Drone {
  String? id;
  String? weight;
  String? manufacturer;
  bool? serviced;
  String? acquisitionDate;

  Drone(
      {this.id,
      this.weight,
      this.manufacturer,
      this.serviced,
      this.acquisitionDate});

  Drone.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weight = json['weight'];
    manufacturer = json['manufacturer'];
    serviced = json['serviced'];
    acquisitionDate = json['acquisitionDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['weight'] = weight;
    data['manufacturer'] = manufacturer;
    data['serviced'] = serviced;
    data['acquisitionDate'] = acquisitionDate;
    return data;
  }
}
