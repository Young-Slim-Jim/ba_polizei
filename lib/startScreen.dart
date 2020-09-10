import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.113),
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
                child: Text("Angemeldet als plxtu62",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 13)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
