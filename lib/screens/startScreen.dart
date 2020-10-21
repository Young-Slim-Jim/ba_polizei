import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ba_polizei/screens/vivaPerson.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../icons/Grid Icons/grid_icons_icons.dart' as CustomIcons;

class StartScreen extends StatelessWidget {
  final List grids = [
    ["ViVA/INPOL/SIS", "PERSON", CustomIcons.GridIcons.customer_insight],
    ["ViVA", "Vorgang", CustomIcons.GridIcons.binder],
    ["ViVA", "Person", CustomIcons.GridIcons.find_user_male],
    ["INPOL", "Person", CustomIcons.GridIcons.find_user_male],
    ["SIS", "Person", CustomIcons.GridIcons.find_user_male],
    ["ViVA", "Kfz", CustomIcons.GridIcons.car],
    [
      "ViVA",
      "Sachtyp unbekannt",
      CustomIcons.GridIcons.binder,
    ],
    ["Inpol", "Sache", CustomIcons.GridIcons.driving_guidelines],
    ["Sis", "Sache", CustomIcons.GridIcons.driving_guidelines],
    ["EMA", "Meldedaten", CustomIcons.GridIcons.contact_card],
    ["Zevis", "ZFZR Person", CustomIcons.GridIcons.find_user_male],
    ["ZEVIS", "ZFZR Kfz und Halter", CustomIcons.GridIcons.driving_guidelines],
    ["ZEVIS", "ZFER Person", CustomIcons.GridIcons.find_user_male],
    ["ZEVIS", "ZFER Sache", CustomIcons.GridIcons.car],
  ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: <Color>[
            Color(0xffdddddd),
            Color(0xffdddddd),
            Colors.white,
            Colors.white,
            Colors.white
          ],
          stops: [
            0.0,
            0.05,
            0.7,
            0.9,
            1.0,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Platform.isIOS
              ? Size.fromHeight(height * 0.113)
              : Size.fromHeight(height * 0.14),
          child: AppBar(
            iconTheme: IconThemeData(color: Theme.of(context).accentColor),
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    "Abmelden",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  flex: 3,
                  child: Text("Auskunft", style: TextStyle(fontSize: 20)),
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  child: Icon(CupertinoIcons.info),
                )
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(height * 0.05),
              child: Container(
                width: double.infinity,
                color: Theme.of(context).secondaryHeaderColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Platform.isIOS
                      ? Text("Angemeldet als plxtu62",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white, fontSize: 13))
                      : RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'Angemeldet als'),
                              TextSpan(
                                  text: ' plxtu62',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textSelectionColor)),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
          child: CupertinoScrollbar(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                grids.length,
                (index) => Padding(
                  padding:
                      const EdgeInsets.only(left: 2.0, bottom: 4.0, right: 2.0),
                  child: GestureDetector(
                    onTap: () {
                      if (grids[index][0] == "ViVA" &&
                          grids[index][1] == "Person") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VivaPerson()),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Icon(
                                grids[index][2],
                                size: 100,
                                color: Colors.amber,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AutoSizeText(
                                  grids[index][0],
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                ),
                                AutoSizeText(
                                  grids[index][1],
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
