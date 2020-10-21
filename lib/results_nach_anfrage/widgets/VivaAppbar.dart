import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ba_polizei/icons/IOScons/i_o_s_icons_icons.dart' as IOScons;

class VivaAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return AppBar(
      iconTheme: IconThemeData(color: Theme.of(context).accentColor),
      leading: IconButton(
        icon: Icon(Icons.chevron_left, size: 30),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      elevation: 0.0,
      title: Row(
        children: [
          Expanded(
            flex: 45,
            child: Text(
              Platform.isIOS ? "ViVA Person" : "SIS Person",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
              flex: 13,
              child: IconButton(
                  icon: Icon(IOScons.IOSIcons.xmark_square), onPressed: () {})),
          Expanded(
              flex: 13,
              child: IconButton(
                  icon: Icon(IOScons.IOSIcons.doc_text_viewfinder),
                  onPressed: () => {})),
          Expanded(
            flex: 13,
            child: IconButton(
              icon: Icon(CupertinoIcons.search),
              onPressed: () => {},
            ),
          ),
        ],
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.05),
        child: Container(
          width: double.infinity,
          color: Platform.isIOS
              ? Theme.of(context).secondaryHeaderColor
              : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Platform.isIOS
                ? Text("Angemeldet als plxtu62",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 13))
                : RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Angemeldet als'),
                        TextSpan(
                            text: ' plxtu62',
                            style:
                                TextStyle(color: Theme.of(context).hoverColor)),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
