class Usermodel {
  var nickname;
  var correo;
  var contrasena;

  Usermodel({this.nickname, this.correo, this.contrasena});

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
      nickname: json['nickname'],
      correo: json['correo'],
      contrasena: json['contrasena'],
    );
  }
}
