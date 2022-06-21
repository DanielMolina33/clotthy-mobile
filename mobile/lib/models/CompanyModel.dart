class CompanyModel {
  CompanyData? data;

  CompanyModel({this.data});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? CompanyData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CompanyData {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  Null? nextPageUrl;
  String? path;
  String? perPage;
  Null? prevPageUrl;
  int? to;

  CompanyData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to
  });

  CompanyData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    return data;
  }
}

class Data {
  int? id;
  int? idciudad;
  String? nombreempresa;
  String? logo;
  String? nitempresa;
  String? fechacreacion;
  String? fechamodificacion;

  Data({
    this.id,
    this.idciudad,
    this.nombreempresa,
    this.logo,
    this.nitempresa,
    this.fechacreacion,
    this.fechamodificacion
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idciudad = json['idciudad'];
    nombreempresa = json['nombreempresa'];
    logo = json['logo'];
    nitempresa = json['nitempresa'];
    fechacreacion = json['fechacreacion'];
    fechamodificacion = json['fechamodificacion'];
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
    return data;
  }
}