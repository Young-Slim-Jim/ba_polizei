import 'package:flutter/material.dart';

import 'PersonAnimatedConatiner.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Map<String, bool> containers = {
    " knoot": false,
    "knoot knoot 2": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        title: Text("ViVA Person"),
      ),
      body: ListView.builder(
        itemCount: containers.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                containers.updateAll((key, value) => false);
                containers.update(
                    containers.keys.toList()[index], (value) => true);
              });
            },
            child: PersonAnimatedContainer(
              danger: true,
              content: containers.keys.toList()[index],
              selected: containers.values.toList()[index],
            ),
          );
        },
      ),
    );
  }
}
