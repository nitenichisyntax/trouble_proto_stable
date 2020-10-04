import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_state.dart';
import 'navigation.dart';
import 'login.dart';

void main() {
  runApp(
    MaterialApp(home: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginState>(
      builder: (BuildContext context) => LoginState(),
      child: MaterialApp(
        routes: {
          '/': (BuildContext context) {
            var state = Provider.of<LoginState>(context);
            if (state.isLoggedIn()) {
              return BottomNavigation();
            } else {
              return LoginPage();
            }
          },
        },
      ),
    );
  }
}
