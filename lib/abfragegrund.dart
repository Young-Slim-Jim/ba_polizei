import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Abfragegrund extends StatefulWidget {
  @override
  _AbfragegrundState createState() => _AbfragegrundState();
}

class _AbfragegrundState extends State<Abfragegrund> {
  List<String> gruende = [
    "Abwehr von -einer im Einzelfall bestehenden-Gefahr(en)",
    "Strafverfolgung",
    "Überwachung Straßenverkehr",
    "Aktenbereinigung",
    "Amtshilfe",
    "Aufgefundenene oder verkehrsbehindernde Fahrzeuge",
    "Auswertung",
    "Datenpflege",
    "Datenschutzrechtliches Auskunfts-/Löschungsersuchen",
    "Fahndung, Grenzfahndung, Kontrollstelle",
    "Grenzkontrolle",
    "Identitätsprüfung",
    "Nichtbeachten Aufforderung oder Unfallflucht",
    "Ordnungswidrigkeiten",
    "Polizeiliche Rechtshilfe",
    "Sonstige Anlässe",
    "Strafverfolgung Dritter",
    "Strafverfolgung gegen Betroffenen",
  ];

  List<String> gruendegefiltert = [];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Expanded(
                flex: 25,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: AutoSizeText(
                    "Abbrechen",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: Container(),
              ),
              Expanded(
                flex: 37,
                child: AutoSizeText(
                  "Abfragegrund",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                flex: 30,
                child: Container(),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(height * 0.07),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, bottom: 10, top: 5),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  onChanged: (text) {
                    filter(text);
                  },
                  autofocus: false,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).secondaryHeaderColor),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).secondaryHeaderColor),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      filled: true,
                      isDense: true,
                      fillColor: Theme.of(context).secondaryHeaderColor),
                ),
              ),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(height * 0.15),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: height * 0.08,
              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Auswahl löschen",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).primaryColor,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: gruendegefiltert.length == 0
                  ? gruende.length
                  : gruendegefiltert.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(
                        context,
                        gruendegefiltert.length == 0
                            ? gruende[index]
                            : gruendegefiltert[index]);
                  },
                  child: Container(
                    height: height * 0.09,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          gruendegefiltert.length == 0
                              ? gruende[index]
                              : gruendegefiltert[index],
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void filter(String text) {
    setState(
      () {
        gruendegefiltert = gruende
            .where(
              (element) => element.toLowerCase().contains(text.toLowerCase()),
            )
            .toList();

        if (text != "" && gruendegefiltert.length == 0) {
          gruendegefiltert = ["Nichts gefunden"];
        }
      },
    );
  }
}
