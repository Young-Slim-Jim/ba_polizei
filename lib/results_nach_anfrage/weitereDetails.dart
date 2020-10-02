import 'package:ba_polizei/results_nach_anfrage/ChipNavigator.dart';
import 'package:ba_polizei/results_nach_anfrage/anschrift.dart';
import 'package:ba_polizei/results_nach_anfrage/displayData.dart';
import 'package:ba_polizei/results_nach_anfrage/displayDropdown.dart';
import 'package:ba_polizei/results_nach_anfrage/personalie.dart';
import 'package:ba_polizei/results_nach_anfrage/personenfandungsnotierung.dart';
import 'package:flutter/material.dart';

class WeitereDetails extends StatefulWidget {
  @override
  _WeitereDetailsState createState() => _WeitereDetailsState();
}

class _WeitereDetailsState extends State<WeitereDetails> {
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
          DisplayData(label: "Titel", content: "Name, Nachname, Datum"),
          DisplayData(label: "Angelegt am ", content: "22.09.2020"),
          DisplayDropdown(
            text: "Anschrift",
            pushWidget: Anschrift(),
            chip: GestureDetector(
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName("Anschrift"));
              },
              child: Chip(
                backgroundColor: Theme.of(context).primaryColor,
                label: Text("Anschrift", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          DisplayDropdown(
            text: "Personalie",
            pushWidget: Personalie(),
            chip: GestureDetector(
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName("Personalie"));
              },
              child: Chip(
                backgroundColor: Theme.of(context).primaryColor,
                label:
                    Text("Personalie", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          DisplayDropdown(
            text: "Personenfahndungsnotierung",
            pushWidget: Personenfandungsnotierung(),
            chip: GestureDetector(
              onTap: () {
                Navigator.popUntil(
                    context, ModalRoute.withName("Personenfahndungsnotierung"));
              },
              child: Chip(
                backgroundColor: Theme.of(context).primaryColor,
                label: Text(
                  "Personenfahndungsnotierung",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
