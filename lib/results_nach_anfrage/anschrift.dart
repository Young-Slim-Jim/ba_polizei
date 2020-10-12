import 'package:ba_polizei/personHitsProvider.dart';
import 'package:ba_polizei/results_nach_anfrage/ChipNavigator.dart';
import 'package:ba_polizei/results_nach_anfrage/ChipProvider.dart';
import 'package:ba_polizei/results_nach_anfrage/displayData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Anschrift extends StatefulWidget {
  final String ident;
  final String id;
  Anschrift({this.ident, this.id});

  @override
  _AnschriftState createState() => _AnschriftState();
}

class _AnschriftState extends State<Anschrift> {
  String plz;
  String nation;
  String ort;
  String ortsbezeichnung;
  String hausnummer;
  String letztesAenderungsdatum;
  String verfasser;
  String artDerOrtsbezeichnung;
  String angelegtAm;
  String titel;
  String angelegtDurch;
  String artDerAnschrift;
  String letzterAenderer;
  String loeschtermin;
  String prueftermin;
  String statusLoeschtermin;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final hitsProvider =
          Provider.of<PersonHitProvider>(context, listen: false);
      setState(() {
        plz = hitsProvider.getPlz(widget.id);
        nation = hitsProvider.getNation(widget.id);
        ort = hitsProvider.getOrt(widget.id);
        ortsbezeichnung = hitsProvider.getOrtsbezeichnung(widget.id);
        hausnummer = hitsProvider.getHausnummer(widget.id);
        letztesAenderungsdatum =
            hitsProvider.getLetztesAenderungsdatum(widget.id);
        verfasser = hitsProvider.getVerfasser(widget.id);
        angelegtAm = hitsProvider.getAngelegtAm(widget.id);
        artDerOrtsbezeichnung =
            hitsProvider.getArtderOrtsbezeichnung(widget.id);

        angelegtDurch = hitsProvider.getAngelegtDurch(widget.id);
        artDerAnschrift = hitsProvider.getArtDerAnschrift(widget.id);
        letzterAenderer = hitsProvider.getLetzterAenderer(widget.id);
        loeschtermin = hitsProvider.getLoeschtermin(widget.id);
        prueftermin = hitsProvider.getPrueftermin(widget.id);
        statusLoeschtermin = hitsProvider.getStatusLoeschtermin(widget.id);

        titel = ort +
            ", " +
            ortsbezeichnung +
            ", " +
            hausnummer +
            " (" +
            artDerAnschrift +
            ")";
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        final chips = Provider.of<ChipProvider>(context, listen: false);
        chips.removeChipOnPop(widget.ident);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).accentColor),
          title: Text("ViVA Person"),
          actions: [Icon(Icons.share)],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  ChipNavigator(),
                  DisplayData(label: "PLZ", content: plz),
                  DisplayData(label: "Nation", content: nation),
                  DisplayData(label: "Ort", content: ort),
                  DisplayData(
                      label: "Ortsbezeichnung", content: ortsbezeichnung),
                  DisplayData(label: "Hausnr.", content: hausnummer),
                  DisplayData(
                      label: "letztes Änderungsdatum",
                      content: letztesAenderungsdatum),
                  DisplayData(label: "Verfasser/ Besitzer", content: verfasser),
                  DisplayData(label: "Angelegt am", content: angelegtAm),
                  DisplayData(label: "Titel", content: titel),
                  DisplayData(
                      label: "Art der Ortsbezeichnung",
                      content: artDerOrtsbezeichnung),
                  DisplayData(label: "Angelegt durch", content: angelegtDurch),
                  DisplayData(
                      label: "Art der Anschrift", content: artDerAnschrift),
                  DisplayData(
                      label: "letzter Änderer", content: letzterAenderer),
                  DisplayData(label: "Löschtermin", content: loeschtermin),
                  DisplayData(label: "Prüftermin", content: prueftermin),
                  DisplayData(
                      label: "Status des Löschtermins",
                      content: statusLoeschtermin),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
