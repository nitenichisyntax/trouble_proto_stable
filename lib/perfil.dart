import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'classes/ReResUsuario.dart';
import 'login.dart';
import 'login_state.dart';
import 'utils/custom_clippers.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  User usuarioSession = new User();
  getUser() async {
    http.Response res = await http.get('http://143.110.154.244/api/user');
    var state = Provider.of<LoginState>(context);
    final users = reqResUsuarioFromJson(res.body);

    for (final user in users.users) {
      if (user.id == state.idLogged()) {
        setState(() {
          usuarioSession.id = user.id;
          usuarioSession.nombres = user.nombres;
          usuarioSession.apellidos = user.apellidos;
          usuarioSession.correo = user.correo;
          usuarioSession.avatar = user.avatar;
          usuarioSession.password = user.password;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TopBox(usuarioSession),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 14.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_location,
                        size: 40.0,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 24.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Alertas Publicadas',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          "0",
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  var state = Provider.of<LoginState>(context);
                  state.logout();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()),
                      (Route<dynamic> route) => false);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 1.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          var state = Provider.of<LoginState>(context);
                          state.logout();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage()),
                              (Route<dynamic> route) => false);
                        },
                        icon: Icon(
                          Icons.exit_to_app,
                          size: 30.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 14.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Cerrar Sesión',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container TopBox(User usuarioSession) {
  return Container(
    height: 500.0,
    child: Stack(
      children: <Widget>[
        Container(),
        ClipPath(
          clipper: MyCustomClipper(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue, Colors.teal],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            height: 300.0,
          ),
        ),
        Align(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProfileAvatar(
                usuarioSession.avatar == null ? '' : usuarioSession.avatar,
                borderWidth: 4.0,
                radius: 80.0,
              ),
              SizedBox(height: 4.0),
              Text(
                usuarioSession.nombres == null
                    ? ''
                    : usuarioSession.nombres + ' ' + usuarioSession.apellidos,
                style: TextStyle(
                  fontSize: 21.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                usuarioSession.correo == null ? '' : usuarioSession.correo,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
