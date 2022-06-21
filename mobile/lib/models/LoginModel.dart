class User {
  UserData? userData;
  String? token;

  User({this.userData, this.token});

  User.fromJson(Map<String, dynamic> json) {
    userData = json['user'] != null ? UserData.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userData != null) {
      data['userData'] = userData!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class UserData {
  int? id;
  String? email;
  String? username;
  String? firstName;
  String? lastName;
  String? avatar;
  List<UserRoleInfo>? userRoleInfo;

  UserData({
    this.id,
    this.email,
    this.username,
    this.firstName,
    this.lastName,
    this.avatar,
    this.userRoleInfo
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    if (json['user_role_info'] != null) {
      userRoleInfo = <UserRoleInfo>[];
      json['user_role_info'].forEach((v) {
        userRoleInfo!.add(UserRoleInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar'] = avatar;
    if (userRoleInfo != null) {
      data['user_role_info'] = userRoleInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserRoleInfo {
  String? role;
  String? module;
  Permissions? permissions;

  UserRoleInfo({this.role, this.module, this.permissions});

  UserRoleInfo.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    module = json['module'];
    permissions = json['permissions'] != null
      ? Permissions.fromJson(json['permissions'])
      : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    data['module'] = module;
    if (permissions != null) {
      data['permissions'] = permissions!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return role.toString();
  }
}

class Permissions {
  String? create;
  String? read;
  String? update;
  String? delete;

  Permissions({this.create, this.read, this.update, this.delete});

  Permissions.fromJson(Map<String, dynamic> json) {
    create = json['create'];
    read = json['read'];
    update = json['update'];
    delete = json['delete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['create'] = create;
    data['read'] = read;
    data['update'] = update;
    data['delete'] = delete;
    return data;
  }
}
