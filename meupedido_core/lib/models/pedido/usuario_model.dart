import 'package:meupedido_core/core/auth/user_model.dart';

class UsuarioModel {
  String idUser;
  String nome;
  String email;
  String telefone;

  UsuarioModel({
    this.idUser,
    this.nome,
    this.email,
    this.telefone,
  });

  UsuarioModel copyWith({
    String idUser,
    String nome,
    String email,
    String telefone,
  }) =>
      UsuarioModel(
        idUser: idUser ?? this.idUser,
        nome: nome ?? this.nome,
        email: email ?? this.email,
        telefone: telefone ?? this.telefone,
      );

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        idUser: json["idUser"] == null ? null : json["idUser"],
        nome: json["nome"] == null ? null : json["nome"],
        email: json["email"] == null ? null : json["email"],
        telefone: json["telefone"] == null ? null : json["telefone"],
      );

  Map<String, dynamic> toJson() => {
        "idUser": idUser == null ? null : idUser,
        "nome": nome == null ? null : nome,
        "email": email == null ? null : email,
        "telefone": telefone == null ? null : telefone,
      };

  factory UsuarioModel.fromUserModel(UserModel userAtual) => UsuarioModel(
        idUser: userAtual.uid,
        nome: userAtual.nome,
        email: userAtual.email,
        //telefone: _authController.userAtual.
      );
}
