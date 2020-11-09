import 'dart:io';

import 'package:ba_polizei/personHitsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/PersonAnimatedConatiner.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    final hitsProvider = Provider.of<PersonHitProvider>(context);
    return WillPopScope(
      onWillPop: () {
        hitsProvider.resetSelection();
        Navigator.of(context).pop(false);
        return Future.value(false);
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
        ),
        backgroundColor:
            hitsProvider.hits.length > 0 ? Colors.white : Colors.grey[300],
        body: hitsProvider.hits.length > 0
            ? ListView.builder(
                itemCount: hitsProvider.hits.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return GestureDetector(
                    onTap: () {
                      hitsProvider.changeSelection(
                          hitsProvider.hits.keys.toList()[index]);
                    },
                    child: PersonAnimatedContainer(
                        danger: hitsProvider.isDangerous(
                            hitsProvider.hits.keys.toList()[index]),
                        vorname: hitsProvider
                            .getVorname(hitsProvider.hits.keys.toList()[index]),
                        nachname: hitsProvider.getNachname(
                            hitsProvider.hits.keys.toList()[index]),
                        bday: hitsProvider
                            .getBday(hitsProvider.hits.keys.toList()[index]),
                        selected: hitsProvider
                            .isSelected(hitsProvider.hits.keys.toList()[index]),
                        id: hitsProvider.hits.keys.toList()[index]),
                  );
                },
              )
            : Platform.isIOS
                ? Theme(
                    data: ThemeData.light(),
                    child: CupertinoAlertDialog(
                      actions: [
                        CupertinoActionSheetAction(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("OK"))
                      ],
                      content: Column(
                        children: [
                          Text(
                            "Schnellauskunft",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          Text(
                            "Keine Treffer.",
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                    ),
                  )
                : AlertDialog(
                    content: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Schnellauskunft",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Keine Treffer.",
                              style: TextStyle(fontSize: 17),
                            ),
                          )
                        ],
                      ),
                    ),
                    actions: [
                      FlatButton(
                        child: Text('OK'),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ),
      ),
    );
  }
}
