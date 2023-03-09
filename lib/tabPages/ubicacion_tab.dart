import 'package:flutter/material.dart';

class UbicacionTabPage extends StatefulWidget {
  UbicacionTabPage({Key? key}) : super(key: key);

  @override
  State<UbicacionTabPage> createState() => _UbicacionTabPageState();
}

class _UbicacionTabPageState extends State<UbicacionTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(22.0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Buscar por Zona",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 103, 103, 103)),
                      icon: Icon(Icons.search,
                          color: Color.fromARGB(255, 103, 103, 103))),
                ),
              ),
            ],
          )),
    );
  }
}
