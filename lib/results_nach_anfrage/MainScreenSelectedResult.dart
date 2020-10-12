import 'package:ba_polizei/personHitsProvider.dart';
import 'package:ba_polizei/results_nach_anfrage/ChipNavigator.dart';
import 'package:ba_polizei/results_nach_anfrage/ChipProvider.dart';
import 'package:ba_polizei/results_nach_anfrage/displayDropdown.dart';
import 'package:ba_polizei/results_nach_anfrage/weitereDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'displayData.dart';

class MainScreenSelectedResult extends StatefulWidget {
  final String id;

  MainScreenSelectedResult({this.id});
  @override
  _MainScreenSelectedResultState createState() =>
      _MainScreenSelectedResultState();
}

class _MainScreenSelectedResultState extends State<MainScreenSelectedResult> {
  String name;
  String nachname;
  String bday;
  String ausschreibungsanlass;
  String bdayOrt;
  String geschlecht;
  String staatsangehoerigkeit;
  String statusDerP;
  String angelegtAm;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final hitsProvider =
          Provider.of<PersonHitProvider>(context, listen: false);
      setState(() {
        name = hitsProvider.getVorname(widget.id);
        nachname = hitsProvider.getNachname(widget.id);
        bday = transformBday(hitsProvider.getBday(widget.id));
        ausschreibungsanlass = hitsProvider.getAusschreibungsanlass(widget.id);
        bdayOrt = hitsProvider.getBdayOrt(widget.id);
        geschlecht = hitsProvider.getGeschlecht(widget.id);
        staatsangehoerigkeit = hitsProvider.getStaatsangehoerigkeit(widget.id);
        statusDerP = hitsProvider.getGeschlecht(widget.id);
        angelegtAm = hitsProvider.getAngelegtAm(widget.id);
      });
    });
    super.initState();
  }

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
                label: "Auschreibungsanlass/-zweck",
                content: ausschreibungsanlass),
            DisplayData(label: "Aktive Fahndungen", content: "1"),
            DisplayData(label: "Familien- / Ehename", content: nachname),
            DisplayData(label: "Vorname", content: name),
            DisplayData(label: "Geburtsdatum", content: bday),
            DisplayData(label: "Geburtsort", content: bdayOrt),
            DisplayData(label: "Geschlecht", content: geschlecht),
            DisplayData(
                label: "Staatsangehörigkeit", content: staatsangehoerigkeit),
            DisplayData(label: "Status der Personalie", content: statusDerP),
            DisplayData(label: "Angelegt am", content: angelegtAm),
            DisplayDropdown(
              text: "weitere Details",
              pushWidget: WeitereDetails(widget.id),
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

  String transformBday(String unformatted) {
    String jahr = unformatted.substring(0, 4);
    String monat = unformatted.substring(5, 7);
    String tag = unformatted.substring(8, 10);
    String formatiert = tag + "." + monat + "." + jahr;
    return formatiert;
  }
}
