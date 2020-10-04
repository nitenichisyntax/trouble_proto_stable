import 'dart:convert';

ReqResUsuario reqResUsuarioFromJson(String str) => ReqResUsuario.fromJson(json.decode(str));

String reqResUsuarioToJson(ReqResUsuario data) => json.encode(data.toJson());

class ReqResUsuario {
    ReqResUsuario({
        this.users,
    });

    List<User> users;

    factory ReqResUsuario.fromJson(Map<String, dynamic> json) => ReqResUsuario(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
    };
}

class User {
    User({
        this.id,
        this.nombres,
        this.apellidos,
        this.avatar,
        this.correo,
        this.password,
    });

    String id;
    String nombres;
    String apellidos;
    String avatar;
    String correo;
    String password;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        avatar: json["avatar"],
        correo: json["correo"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "nombres": nombres,
        "apellidos": apellidos,
        "avatar": avatar,
        "correo": correo,
        "password": password,
    };
}
