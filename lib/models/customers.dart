class CustomerModel {
  String email;
  String firstName;
  String lastNmae;
  String password;

  CustomerModel({
    required this.email,
    required this.firstName,
    required this.lastNmae,
    required this.password
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map ={};

    map.addAll({
      'email':email,
      'first_name' : firstName,
      'last_name' : lastNmae,
      'password': password,
      'username':email
    });

    return map;
  }

}