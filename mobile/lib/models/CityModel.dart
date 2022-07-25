class CityModel {
  List<CityData>? data;

  CityModel({this.data});

  CityModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CityData>[];
      json['data'].forEach((v) {
        data!.add(CityData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CityData {
  int? id;
  int? iddepar;
  String? costoenvios;
  String? nombreciudades;

  CityData({this.id, this.iddepar, this.costoenvios, this.nombreciudades});

  CityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iddepar = json['iddepar'];
    costoenvios = json['costoenvios'];
    nombreciudades = json['nombreciudades'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['iddepar'] = iddepar;
    data['costoenvios'] = costoenvios;
    data['nombreciudades'] = nombreciudades;
    return data;
  }
}
