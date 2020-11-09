import 'dart:io';

import 'package:ba_polizei/icons/AndroidIcons/android_icons_icons.dart';
import 'package:ba_polizei/personHitsProvider.dart';
import 'package:ba_polizei/results_nach_anfrage/widgets/ChipNavigator.dart';
import 'package:ba_polizei/results_nach_anfrage/ChipProvider.dart';
import 'package:ba_polizei/results_nach_anfrage/screens/anschrift.dart';
import 'package:ba_polizei/results_nach_anfrage/widgets/displayData.dart';
import 'package:ba_polizei/results_nach_anfrage/widgets/displayDropdown.dart';
import 'package:ba_polizei/results_nach_anfrage/screens/personalie.dart';
import 'package:ba_polizei/results_nach_anfrage/screens/personenfandungsnotierung.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ba_polizei/icons/IOScons/i_o_s_icons_icons.dart' as IOScons;

class WeitereDetails extends StatefulWidget {
  final String id;

  WeitereDetails(this.id);
  @override
  _WeitereDetailsState createState() => _WeitereDetailsState();
}

class _WeitereDetailsState extends State<WeitereDetails> {
  String name;
  String nachname;
  String bday;
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
        angelegtAm = hitsProvider.getAngelegtAm(widget.id);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        final chips = Provider.of<ChipProvider>(context, listen: false);
        chips.removeChipOnPop("weitere Details");
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).accentColor),
          automaticallyImplyLeading: Platform.isIOS ? true : false,
          title: Platform.isIOS
              ? Text(
                  "ViVA Person",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )
              : Text(
                  "SIS Person",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white),
                ),
          actions: [
            Platform.isIOS
                ? Icon(IOScons.IOSIcons.square_and_arrow_up)
                : IconButton(
                    icon: Icon(IOScons.IOSIcons.square_and_arrow_up),
                    onPressed: () {},
                  ),
            IconButton(
              icon: Icon(AndroidIcons.account_box_outline),
              onPressed: () {},
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              ChipNavigator(),
              DisplayData(
                  label: "Titel",
                  content: name + ", " + nachname + ", " + bday),
              DisplayData(label: "Angelegt am ", content: angelegtAm),
              DisplayDropdown(
                text: "Anschrift",
                pushWidget: Anschrift(ident: "Anschrift", id: widget.id),
                chip: GestureDetector(
                  onTap: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName("Anschrift"));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      backgroundColor: Theme.of(context).primaryColor,
                      label: Text("Anschrift",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
              DisplayDropdown(
                text: "Personalie",
                pushWidget: Personalie(ident: "Personalie", id: widget.id),
                chip: GestureDetector(
                  onTap: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName("Personalie"));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      backgroundColor: Theme.of(context).primaryColor,
                      label: Text("Personalie",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
              DisplayDropdown(
                text: "Personenfahndungsnotierung",
                pushWidget: Personenfandungsnotierung(
                    ident: "Personenfahndungsnotierung", id: widget.id),
                chip: GestureDetector(
                  onTap: () {
                    Navigator.popUntil(context,
                        ModalRoute.withName("Personenfahndungsnotierung"));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      backgroundColor: Theme.of(context).primaryColor,
                      label: Text(
                        "Personenfahndungsnotierung",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
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
