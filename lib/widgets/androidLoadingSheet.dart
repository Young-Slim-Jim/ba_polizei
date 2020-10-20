import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AndroidLoadingSheet extends StatefulWidget {
  @override
  _AndroidLoadingSheetState createState() => _AndroidLoadingSheetState();
}

class _AndroidLoadingSheetState extends State<AndroidLoadingSheet> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 60,
              child: AutoSizeText(
                "Schnellauskunft",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              flex: 40,
              child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      backgroundColor: Theme.of(context).hoverColor,
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 80,
                    child: AutoSizeText(
                      "Anfrage wird durchgeführt...",
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
