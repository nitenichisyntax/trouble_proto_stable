import 'dart:convert';

ReqResAlerta reqResAlertaFromJson(String str) => ReqResAlerta.fromJson(json.decode(str));

String reqResAlertaToJson(ReqResAlerta data) => json.encode(data.toJson());

class ReqResAlerta {
    ReqResAlerta({
        this.alertas,
    });

    List<Alerta> alertas;

    factory ReqResAlerta.fromJson(Map<String, dynamic> json) => ReqResAlerta(
        alertas: List<Alerta>.from(json["alertas"].map((x) => Alerta.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "alertas": List<dynamic>.from(alertas.map((x) => x.toJson())),
    };
}

class Alerta {
    Alerta({
        this.id,
        this.latitud,
        this.longitud,
        this.foto,
        this.fecha,
        this.descripcion,
        this.tipo,
        this.nivel,
    });

    String id;
    double latitud;
    double longitud;
    String foto;
    DateTime fecha;
    String descripcion;
    String tipo;
    String nivel;

    factory Alerta.fromJson(Map<String, dynamic> json) => Alerta(
        id:           json["_id"],
        latitud:      json["latitud"].toDouble(),
        longitud:     json["longitud"].toDouble(),
        foto:         json["foto"],
        fecha:        DateTime.parse(json["fecha"]),
        descripcion:  json["descripcion"],
        tipo:         json["tipo"],
        nivel:        json["nivel"],
    );

    Map<String, dynamic> toJson() => {
        "latitud": latitud,
        "longitud": longitud,
        "foto": foto,
        "fecha": fecha.toIso8601String(),
        "descripcion": descripcion,
        "tipo": tipo,
        "nivel": nivel,
    };
}