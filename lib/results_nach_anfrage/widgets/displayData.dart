import 'dart:io';

import 'package:flutter/material.dart';

class DisplayData extends StatelessWidget {
  final String label;
  final String content;

  DisplayData({this.label, this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: label != "Auschreibungsanlass/-zweck" || label != "Titel"
          ? const EdgeInsets.only(top: 12.0)
          : const EdgeInsets.only(top: 0),
      child: Container(
        height: Platform.isIOS
            ? MediaQuery.of(context).size.height * 0.06
            : MediaQuery.of(context).size.height * 0.07,
        child: TextField(
          controller: TextEditingController()..text = content,
          readOnly: true,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.grey[600]),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[200]),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[200]),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 5,
            ),
          ),
        ),
      ),
    );
  }
}
