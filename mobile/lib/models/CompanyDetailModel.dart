class CompanyDetailModel {
  DataDetail? data;

  CompanyDetailModel({this.data});

  CompanyDetailModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DataDetail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataDetail {
  int? id;
  int? idciudad;
  String? nombreempresa;
  String? logo;
  String? nitempresa;
  String? fechacreacion;
  String? fechamodificacion;
  int? idpais;
  int? iddepar;
  List<Redessociales>? redessociales;
  List<Telefonos>? telefonos;

  DataDetail(
      {this.id,
      this.idciudad,
      this.nombreempresa,
      this.logo,
      this.nitempresa,
      this.fechacreacion,
      this.fechamodificacion,
      this.idpais,
      this.iddepar,
      this.redessociales,
      this.telefonos});

  DataDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idciudad = json['idciudad'];
    nombreempresa = json['nombreempresa'];
    logo = json['logo'];
    nitempresa = json['nitempresa'];
    fechacreacion = json['fechacreacion'];
    fechamodificacion = json['fechamodificacion'];
    idpais = json['idpais'];
    iddepar = json['iddepar'];
    if (json['redessociales'] != null) {
      redessociales = <Redessociales>[];
      json['redessociales'].forEach((v) {
        redessociales!.add(Redessociales.fromJson(v));
      });
    }
    if (json['telefonos'] != null) {
      telefonos = <Telefonos>[];
      json['telefonos'].forEach((v) {
        telefonos!.add(Telefonos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idciudad'] = idciudad;
    data['nombreempresa'] = nombreempresa;
    data['logo'] = logo;
    data['nitempresa'] = nitempresa;
    data['fechacreacion'] = fechacreacion;
    data['fechamodificacion'] = fechamodificacion;
    data['idpais'] = idpais;
    data['iddepar'] = iddepar;
    if (redessociales != null) {
      data['redessociales'] =
          redessociales!.map((v) => v.toJson()).toList();
    }
    if (telefonos != null) {
      data['telefonos'] = telefonos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Redessociales {
  int? id;
  int? idempresa;
  String? nombrered;
  String? enlacered;

  Redessociales({this.id, this.idempresa, this.nombrered, this.enlacered});

  Redessociales.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idempresa = json['idempresa'];
    nombrered = json['nombrered'];
    enlacered = json['enlacered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idempresa'] = idempresa;
    data['nombrered'] = nombrered;
    data['enlacered'] = enlacered;
    return data;
  }
}

class Telefonos {
  int? id;
  int? tiponumero;
  String? numerotelefono;
  String? indicativo;

  Telefonos({this.id, this.tiponumero, this.numerotelefono, this.indicativo});

  Telefonos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tiponumero = json['tiponumero'];
    numerotelefono = json['numerotelefono'];
    indicativo = json['indicativo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tiponumero'] = tiponumero;
    data['numerotelefono'] = numerotelefono;
    data['indicativo'] = indicativo;
    return data;
  }
}
