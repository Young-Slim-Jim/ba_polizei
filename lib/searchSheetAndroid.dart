import 'package:flutter/material.dart';

class SearchSheetAndroid extends StatefulWidget {
  final List<String> auswahl;
  final String title;

  SearchSheetAndroid({this.auswahl, this.title});
  @override
  _SearchSheetAndroidState createState() => _SearchSheetAndroidState();
}

class _SearchSheetAndroidState extends State<SearchSheetAndroid> {
  List<String> gefiltert = [];
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        color: Colors.blue,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(widget.title),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
          body: Scrollbar(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  selectionTile("Auswahl löschen"),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: gefiltert.length == 0
                          ? widget.auswahl.length
                          : gefiltert.length,
                      itemBuilder: (context, index) {
                        return selectionTile(gefiltert.length == 0
                            ? widget.auswahl[index]
                            : gefiltert[index]);
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget selectionTile(String text) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 98,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(text,
                    style: text == "Auswahl löschen"
                        ? TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Theme.of(context).textSelectionColor,
                            fontSize: 18)
                        : TextStyle(fontSize: 14)),
              ),
            ),
          ),
          Expanded(flex: 2, child: Container(color: Colors.grey, height: 1))
        ],
      ),
    );
  }
}
