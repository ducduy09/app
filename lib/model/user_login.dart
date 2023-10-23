class UserLogin {
  late final int userId;
  String? userName;
  late final String email;
  String password;
  String type;
  int? status;
  int? level;

  UserLogin({required this.userId, this.userName, required this.email,required this.password, required this.type, this.status, this.level});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'email': email,
      'password': password,
      'type': type,
      'status': status,
      'level': level
    };
    return map;
  }
  UserLogin.fromMap(Map<String, dynamic> res)
    : userId = res["userId"],
      userName = res["userName"],
      email = res["email"],
      password = res["password"],
      type = res["type"],
      status = res["status"],
      level = res["level"];

 UserLogin.fromJson(Map<String, dynamic> json) 
    : userId = json['userId'],
    userName = json['userName'],
    email = json['email'],
    password = json['password'],
    type = json['type'],
    status = json['status'],
    level = json["level"];
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['email'] = email;
    data['password'] = password;
    data['type'] = type;
    data['status'] = status;
    data['level'] = level;
    return data;
  }
}
