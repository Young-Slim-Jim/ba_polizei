import 'package:ba_polizei/personHitsProvider.dart';
import 'package:ba_polizei/results_nach_anfrage/ChipNavigator.dart';
import 'package:ba_polizei/results_nach_anfrage/ChipProvider.dart';
import 'package:ba_polizei/results_nach_anfrage/displayData.dart';
import 'package:ba_polizei/results_nach_anfrage/displayDropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Personenfandungsnotierung extends StatefulWidget {
  final String ident;
  final String id;
  Personenfandungsnotierung({this.ident, this.id});

  @override
  _PersonenfandungsnotierungState createState() =>
      _PersonenfandungsnotierungState();
}

class _PersonenfandungsnotierungState extends State<Personenfandungsnotierung> {
  String ausschreibungsanlass;
  String ausschreibungszweck;
  String ausschreibendeBehoerde;
  String azAB;
  String fahndungsregion;
  String statusFahndung;
  String dienststelle;
  String azAS;
  String angelegtAm;
  String angelegtDurch;
  String schengen;
  String ereignisbezeichnung;
  String besitzendeBehoerde;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final hitsProvider =
          Provider.of<PersonHitProvider>(context, listen: false);
      setState(() {
        ausschreibungsanlass = hitsProvider.getAuschreibungsanlass(widget.id);
        ausschreibungszweck = hitsProvider.getAuschreibungszweck(widget.id);
        ausschreibendeBehoerde =
            hitsProvider.getAuschreibendeBehoerde(widget.id);
        azAB = hitsProvider.getAzAb(widget.id);
        fahndungsregion = hitsProvider.getFahndungsregion(widget.id);
        statusFahndung = hitsProvider.getFahndungsregion(widget.id);
        dienststelle = hitsProvider.getDienstelle(widget.id);
        azAS = hitsProvider.getAzAs(widget.id);
        angelegtAm = hitsProvider.getAngelegtAm(widget.id);
        angelegtDurch = hitsProvider.getAngelegtDurch(widget.id);
        schengen = hitsProvider.getSchengen(widget.id);
        ereignisbezeichnung = hitsProvider.getereignisbezeichnung(widget.id);
        besitzendeBehoerde = hitsProvider.getBesitzendeBehoerde(widget.id);
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
                  DisplayData(
                    label: "Auschreibungsanlass",
                    content: ausschreibungsanlass,
                  ),
                  DisplayData(
                    label: "Auschreibungszweck",
                    content: ausschreibungszweck,
                  ),
                  DisplayData(
                    label: "Auschreibende Behörde",
                    content: ausschreibendeBehoerde,
                  ),
                  DisplayData(
                    label: "AZ der auschreibenden Behörde",
                    content: azAB,
                  ),
                  DisplayData(
                    label: "Fahndungsregion",
                    content: fahndungsregion,
                  ),
                  DisplayData(
                    label: "Status der Personenfahndung",
                    content: statusFahndung,
                  ),
                  DisplayData(
                    label: "Sachbearbeitende Dienststelle",
                    content: dienststelle,
                  ),
                  DisplayData(
                    label: "AZ der der sachbearbeitenden Dienstelle",
                    content: azAS,
                  ),
                  DisplayData(
                    label: "Angelegt am",
                    content: angelegtAm,
                  ),
                  DisplayData(
                    label: "Angelegt durch",
                    content: angelegtDurch,
                  ),
                  DisplayData(
                    label: "Schengener System",
                    content: schengen,
                  ),
                  DisplayData(
                      label: "Ergebnisbezeichnung",
                      content: ereignisbezeichnung),
                  DisplayData(
                    label: "besitzende Behörde",
                    content: besitzendeBehoerde,
                  ),
                  DisplayDropdown(text: "Fremdobjektreferenz")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
