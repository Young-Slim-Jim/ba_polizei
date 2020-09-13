import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VivaPerson extends StatefulWidget {
  @override
  _VivaPersonState createState() => _VivaPersonState();
}

class _VivaPersonState extends State<VivaPerson> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 40),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Expanded(
              flex: 45,
              child: Text(
                "ViVA Person",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
                flex: 13,
                child:
                    IconButton(icon: Icon(Icons.cancel), onPressed: () => {})),
            Expanded(
                flex: 13,
                child: IconButton(
                    icon: Icon(Icons.scatter_plot), onPressed: () => {})),
            Expanded(
                flex: 13,
                child: IconButton(
                    icon: Icon(CupertinoIcons.search), onPressed: () => {})),
          ],
        ),
        centerTitle: true,
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
    );
  }
}
