import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoDateDialog extends StatefulWidget {
  @override
  _CupertinoDateDialogState createState() => _CupertinoDateDialogState();
}

class _CupertinoDateDialogState extends State<CupertinoDateDialog> {
  DateTime date;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        height: height * 0.3,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (value) {
                    setState(() {
                      date = value;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoDialogAction(
                      child: Text(
                        "OK",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => Navigator.of(context).pop(date),
                    ),
                  ),
                  Expanded(
                    child: CupertinoDialogAction(
                      child: Text("Abbrechen"),
                      onPressed: () => Navigator.of(context).pop(),
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
