import 'package:ba_polizei/results_nach_anfrage/ChipNavigator.dart';
import 'package:flutter/material.dart';

class Personenfandungsnotierung extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        title: Text("ViVA Person"),
        actions: [Icon(Icons.share)],
      ),
      body: Column(
        children: [
          ChipNavigator(),
          FlatButton(
              onPressed: () {

                Navigator.of(context).popUntil(ModalRoute.withName('/MainScreenDetails'));
              },
              child: Text("test"))
        ],
      ),
    );
  }
}