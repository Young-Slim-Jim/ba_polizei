import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoLoadingSheet extends StatefulWidget {
  @override
  _CupertinoLoadingSheetState createState() => _CupertinoLoadingSheetState();
}

class _CupertinoLoadingSheetState extends State<CupertinoLoadingSheet> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Theme(
                data: ThemeData(
                    cupertinoOverrideTheme:
                        CupertinoThemeData(brightness: Brightness.dark)),
                child: CupertinoActivityIndicator(
                  radius: 20,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Anfrage wird durchgeführt ...",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
