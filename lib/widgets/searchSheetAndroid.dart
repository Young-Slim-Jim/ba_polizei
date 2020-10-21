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
  bool search = false;

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        color: Colors.blue,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: search
                ? TextField(
                    controller: searchController,
                    autofocus: true,
                    onChanged: (value) {
                      filter(value);
                    },
                    autocorrect: false,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: widget.title,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  )
                : Text(widget.title),
            actions: [
              search
                  ? IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            gefiltert = [];
                            search = !search;
                          },
                        );
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(
                          () {
                            search = !search;
                          },
                        );
                      },
                    ),
            ],
          ),
          body: Scrollbar(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(
                        context,
                        widget.title == "Abfragegrund"
                            ? " Bitte auswählen"
                            : "..."),
                    child: selectionTile("Auswahl löschen"),
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
                          child: selectionTile(gefiltert.length == 0
                              ? widget.auswahl[index]
                              : gefiltert[index]),
                        );
                      })
                ],
              ),
            ),
          ),
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
                padding: const EdgeInsets.only(left: 16.0, right: 8),
                child: Text(text,
                    style: text == "Auswahl löschen"
                        ? TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Theme.of(context).hoverColor,
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
