import 'dart:io';

import 'package:ba_polizei/icons/AndroidIcons/android_icons_icons.dart';
import 'package:ba_polizei/results_nach_anfrage/widgets/ChipNavigator.dart';
import 'package:ba_polizei/results_nach_anfrage/ChipProvider.dart';
import 'package:ba_polizei/results_nach_anfrage/widgets/displayData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../personHitsProvider.dart';
import 'package:ba_polizei/icons/IOScons/i_o_s_icons_icons.dart' as IOScons;

class Personalie extends StatefulWidget {
  final String ident;
  final String id;
  Personalie({this.ident, this.id});

  @override
  _PersonalieState createState() => _PersonalieState();
}

class _PersonalieState extends State<Personalie> {
  String name;
  String nachname;
  String bdayOrt;
  String geschlecht;
  String statusDerP;
  String geburtsname;
  String geburtsland;
  List staatsangehoerigkeiten;
  bool showMore = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final hitsProvider =
          Provider.of<PersonHitProvider>(context, listen: false);
      setState(() {
        name = hitsProvider.getVorname(widget.id);
        nachname = hitsProvider.getNachname(widget.id);
        bdayOrt = hitsProvider.getBdayOrt(widget.id);
        geschlecht = hitsProvider.getGeschlecht(widget.id);
        statusDerP = hitsProvider.getGeschlecht(widget.id);
        geburtsname = hitsProvider.getGeburstsname(widget.id);
        geburtsland = hitsProvider.getGeburstsland(widget.id);
        staatsangehoerigkeiten =
            hitsProvider.getStaatsangehoerigkeiten(widget.id);
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
          actions: [
            Platform.isIOS
                ? Icon(IOScons.IOSIcons.square_and_arrow_up)
                : Icon(IOScons.IOSIcons.square_and_arrow_up),
            Icon(AndroidIcons.account_box_outline)
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  ChipNavigator(),
                  DisplayData(
                    label: "Führungspersonalie",
                    content: "JA",
                  ),
                  DisplayData(
                    label: "Status der Personalie",
                    content: statusDerP,
                  ),
                  DisplayData(
                    label: "Vorname",
                    content: name,
                  ),
                  DisplayData(
                    label: "Familien- / Ehename",
                    content: nachname,
                  ),
                  DisplayData(
                    label: "Geburtsname",
                    content: geburtsname,
                  ),
                  DisplayData(
                    label: "Geschlecht",
                    content: geschlecht,
                  ),
                  DisplayData(
                    label: "Geburtsort",
                    content: bdayOrt,
                  ),
                  DisplayData(
                    label: "Geburtsland",
                    content: geburtsland,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showMore = !showMore;
                      });
                    },
                    child: showMore == false
                        ? Stack(
                            alignment: Alignment.centerRight,
                            children: <Widget>[
                              TextField(
                                controller: TextEditingController()
                                  ..text = "Personalie (2)",
                                autofocus: false,
                                readOnly: true,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Theme.of(context).primaryColor),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[200]),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[200]),
                                  ),
                                  labelStyle:
                                      TextStyle(color: Colors.grey[600]),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 5,
                                  ),
                                ),
                              ),
                              Icon(Icons.arrow_downward,
                                  color: Theme.of(context).primaryColor),
                            ],
                          )
                        : Column(
                            children: [
                              DisplayData(
                                label: "Staatsangehörigkeit",
                                content: staatsangehoerigkeiten[0]["value"],
                              ),
                              DisplayData(
                                label: "Staatsangehörigkeit",
                                content: staatsangehoerigkeiten[1]["value"],
                              )
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
