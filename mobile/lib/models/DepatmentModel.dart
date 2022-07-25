class DepartmentModel {
  List<DepartmentData>? data;

  DepartmentModel({this.data});

  DepartmentModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DepartmentData>[];
      json['data'].forEach((v) {
        data!.add(DepartmentData.fromJson(v));
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

class DepartmentData {
  int? id;
  int? idpais;
  String? nombredepar;

  DepartmentData({this.id, this.idpais, this.nombredepar});

  DepartmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idpais = json['idpais'];
    nombredepar = json['nombredepar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idpais'] = idpais;
    data['nombredepar'] = nombredepar;
    return data;
  }
}
