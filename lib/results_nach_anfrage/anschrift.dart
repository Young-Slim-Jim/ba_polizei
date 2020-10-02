import 'package:ba_polizei/results_nach_anfrage/ChipNavigator.dart';
import 'package:flutter/material.dart';

class Anschrift extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        title: Text("ViVA Person"),
        actions: [Icon(Icons.share)],
      ),
      body: ChipNavigator(),
    );
  }
}
