class CountryModel {
  List<CountryData>? data;

  CountryModel({this.data});

  CountryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CountryData>[];
      json['data'].forEach((v) {
        data!.add(CountryData.fromJson(v));
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

class CountryData {
  int? id;
  String? nombrepaises;
  String? abreviaturapaises;

  CountryData({this.id, this.nombrepaises, this.abreviaturapaises});

  CountryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombrepaises = json['nombrepaises'];
    abreviaturapaises = json['abreviaturapaises'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombrepaises'] = nombrepaises;
    data['abreviaturapaises'] = abreviaturapaises;
    return data;
  }
}
