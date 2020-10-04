import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Map data;
List alertsData;

class _HomePageState extends State<HomePage> {
  getAlerts() async {
    http.Response res = await http.get('http://143.110.154.244/api/alert/');
    data = json.decode(res.body);
    setState(() {
      alertsData = data['alertas'];
    });
  }

  @override
  void initState() {
    super.initState();
    getAlerts();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, value) {
        return [
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blue],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 25),
                  child: SafeArea(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Newsfeed",
                        style: TextStyle(
                          fontFamily: "",
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
            ),
          ),
        ];
      },
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: ListView.builder(
          itemCount: alertsData == null ? 0 : alertsData.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 3.0,
              margin: EdgeInsets.only(bottom: 10.0),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(100),
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(9.0),
                  child: Row(
                    children: [
                      Container(
                        width: 140.0,
                        height: 140.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(alertsData[index]['foto']),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${alertsData[index]["descripcion"]}"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// return AspectRatio(
//   aspectRatio: 10 / 4,
//   child: Card(
//     elevation: 6,
//     child: Container(
//       margin: const EdgeInsets.all(2.0),
//       padding: const EdgeInsets.all(4.0),
//       child: InkWell(
//         splashColor: Colors.blue.withAlpha(100),
//         onTap: () {
//           print('Card tapped.');
//         },
//         child: SafeArea(
//           child: Flexible(
//             child: Row(
//               children: <Widget>[
//                 Padding(
//                     padding: const EdgeInsets.all(14.0),
//                     child: OctoImage(
//                       image: NetworkImage(alertsData[index]['foto']),
//                     )),
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(0.0),
//                       child: Text(
//                         "${alertsData[index]["descripcion"]}",
//                         maxLines: 3,
//                         softWrap: false,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ),
//   ),
// );
