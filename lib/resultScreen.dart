import 'package:ba_polizei/personHitsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'PersonAnimatedConatiner.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    final hitsProvider = Provider.of<PersonHitProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        title: Text("ViVA Person"),
      ),
      body: ListView.builder(
        itemCount: hitsProvider.hits.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return GestureDetector(
            onTap: () {
              hitsProvider
                  .changeSelection(hitsProvider.hits.keys.toList()[index]);
            },
            child: PersonAnimatedContainer(
              danger: hitsProvider
                  .isDangerous(hitsProvider.hits.keys.toList()[index]),
              vorname: hitsProvider
                  .getVorname(hitsProvider.hits.keys.toList()[index]),
              nachname: hitsProvider
                  .getNachname(hitsProvider.hits.keys.toList()[index]),
              bday:
                  hitsProvider.getBday(hitsProvider.hits.keys.toList()[index]),
              selected: hitsProvider
                  .isSelected(hitsProvider.hits.keys.toList()[index]),
            ),
          );
        },
      ),
    );
  }
}
