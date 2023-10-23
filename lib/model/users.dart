class User {
  final int? id;
  final String? name;
  final int? age;
  final String? address;
  final String? avatar;
  // final int? wallet;

  const User({ this.id,  this.name, this.age ,this.avatar, this.address});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'avatar': avatar,
      'address': address,
      // 'wallet': wallet
    };
    return map;
  }
  User.fromMap(Map<String, dynamic> res)
    : id = res["id"],
      name = res["name"],
      age = res["age"],
      avatar = res["avatar"],
      address = res["address"];

Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['age'] = age;
    data['avatar'] = avatar;
    data['address'] = address;
    // data['wallet'] = wallet;
    return data;
  }
  User.fromJson(Map<String, dynamic> json) 
    : id = json['id'],
    name = json['name'],
    age = json['age'],
    avatar = json['avatar'],
    address = json['address'];
}