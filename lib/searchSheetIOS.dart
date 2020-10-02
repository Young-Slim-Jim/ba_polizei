import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SearchSheetIOS extends StatefulWidget {
  final List<String> auswahl;
  final String title;

  SearchSheetIOS({this.auswahl, this.title});

  @override
  _SearchSheetIOSState createState() => _SearchSheetIOSState();
}

class _SearchSheetIOSState extends State<SearchSheetIOS> {
  List<String> gefiltert = [];

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
                    maxLines: 1,
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 37,
                child: Center(
                  child: AutoSizeText(
                    widget.title,
                    maxLines: 1,
                  ),
                ),
              ),
              Expanded(
                flex: 15,
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
            GestureDetector(
              onTap: () => Navigator.pop(context,
                  widget.title == "Abfragegrund" ? " Bitte auswählen" : "..."),
              child: Container(
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
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: gefiltert.length == 0
                  ? widget.auswahl.length
                  : gefiltert.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(
                        context,
                        gefiltert.length == 0
                            ? widget.auswahl[index]
                            : gefiltert[index]);
                  },
                  child: Container(
                    height: height * 0.09,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          gefiltert.length == 0
                              ? widget.auswahl[index]
                              : gefiltert[index],
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
        gefiltert = widget.auswahl
            .where(
              (element) => element.toLowerCase().contains(text.toLowerCase()),
            )
            .toList();

        if (text != "" && gefiltert.length == 0) {
          gefiltert = ["Nichts gefunden"];
        }
      },
    );
  }
}
