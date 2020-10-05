import 'package:ba_polizei/results_nach_anfrage/ChipNavigator.dart';
import 'package:ba_polizei/results_nach_anfrage/ChipProvider.dart';
import 'package:ba_polizei/results_nach_anfrage/displayDropdown.dart';
import 'package:ba_polizei/results_nach_anfrage/weitereDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'displayData.dart';

class MainScreenSelectedResult extends StatefulWidget {
  @override
  _MainScreenSelectedResultState createState() =>
      _MainScreenSelectedResultState();
}

class _MainScreenSelectedResultState extends State<MainScreenSelectedResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        title: Text("ViVA Person"),
        actions: [Icon(Icons.share)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ChipNavigator(),
            DisplayData(
                label: "Aschreibungsanlass/-zweck", content: "Straftat"),
            DisplayData(label: "Aktive Fahndungen", content: "2"),
            DisplayData(label: "Familien- / Ehename", content: "Atze"),
            DisplayData(label: "Vorname", content: "Atzig"),
            DisplayData(label: "Geburtsdatum", content: "20.04.2020"),
            DisplayData(label: "Geburtsort", content: "Berlin"),
            DisplayData(label: "Geschlecht", content: "männlich"),
            DisplayData(label: "Staatsangehörigkeit", content: "deutsch"),
            DisplayData(
                label: "Status der Personalie", content: "wie auch immer"),
            DisplayData(label: "Angelegt am", content: "gestern"),
            DisplayDropdown(
              text: "weitere Details",
              pushWidget: WeitereDetails(),
              chip: GestureDetector(
                onTap: () {
                  final chips =
                      Provider.of<ChipProvider>(context, listen: false);
                  chips.removeChipFromChip("weitere Details");
                  Navigator.popUntil(
                      context, ModalRoute.withName("weitere Details"));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      "Weitere Details",
                      style: TextStyle(color: Colors.white),
                    ),
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
