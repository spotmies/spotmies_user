class AccessToken {
  AccessToken({
    required this.authData,
    required this.token,
  });
  late final AuthData authData;
  late final String token;

  AccessToken.fromJson(Map<String, dynamic> json) {
    authData = AuthData.fromJson(json['authData']);
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['authData'] = authData.toJson();
    _data['token'] = token;
    return _data;
  }
}

class AuthData {
  AuthData({
    required this.user,
    required this.iat,
    required this.exp,
  });
  late final User user;
  late final int iat;
  late final int exp;

  AuthData.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
    iat = json['iat'];
    exp = json['exp'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user.toJson();
    _data['iat'] = iat;
    _data['exp'] = exp;
    return _data;
  }
}

class User {
  User({
    required this.uId,
  });
  late final String uId;

  User.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uId'] = uId;
    return _data;
  }
}
