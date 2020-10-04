import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;
import 'classes/ReqResAlerta.dart';

class FullScreenMap extends StatefulWidget {
  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController mapController;
  String selectedStyle = 'mapbox://styles/nitenichi/ckfm5xo5337h519pfvucg6y1c';
  final streetStyle = 'mapbox://styles/nitenichi/ckfm5xo5337h519pfvucg6y1c';
  final outStreetStyle = 'mapbox://styles/nitenichi/ckfm6m75g082r19qhwnpfzzri';

  Map data;
  List alertsData;

  getAlerts() async {
    http.Response res = await http.get('http://143.110.154.244/api/alert');
    final alertas = reqResAlertaFromJson(res.body);

    alertas.alertas.forEach((alerta) => mapController.addSymbol(SymbolOptions(
          geometry: LatLng(alerta.latitud, alerta.longitud),
          iconSize: 4,
          iconImage: 'park-11',
        )));
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    getAlerts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crearMetodo(),
      floatingActionButton: botoneFlotantes(),
    );
  }

  Column botoneFlotantes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        //Agregar un marcador al mapa
        FloatingActionButton(
          child: Icon(
            Icons.sentiment_very_satisfied,
            size: 40,
          ),
          onPressed: () {
            mapController.addSymbol(SymbolOptions(
              geometry: LatLng(-32.449895, -71.232461),
              iconSize: 4,
              iconImage: 'park-11',
            ));
          },
        ),
        SizedBox(
          height: 8,
        ),

        //Zoom In
        FloatingActionButton(
          child: Icon(
            Icons.zoom_in,
            size: 40,
          ),
          onPressed: () {
            mapController.animateCamera(CameraUpdate.zoomIn());
          },
        ),
        SizedBox(
          height: 8,
        ),

        //Zoom Out
        FloatingActionButton(
          child: Icon(
            Icons.zoom_out,
            size: 40,
          ),
          onPressed: () {
            mapController.animateCamera(CameraUpdate.zoomOut());
          },
        ),
        SizedBox(
          height: 8,
        ),

        //Cambiar Estilo
        FloatingActionButton(
            child: Icon(Icons.add_to_home_screen),
            onPressed: () {
              if (selectedStyle == streetStyle) {
                selectedStyle = outStreetStyle;
              } else {
                selectedStyle = streetStyle;
              }

              setState(() {});
            })
      ],
    );
  }

  //Se Crea el mapa y se muestra en pantalla completa
  MapboxMap crearMetodo() {
    return MapboxMap(
      myLocationEnabled: true,
      styleString: selectedStyle,
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
          target: LatLng(-32.449895, -71.232461), zoom: 14),
    );
  }
}
