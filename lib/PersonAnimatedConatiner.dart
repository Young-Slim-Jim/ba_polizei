import 'package:ba_polizei/results_nach_anfrage/ChipProvider.dart';
import 'package:ba_polizei/results_nach_anfrage/MainScreenSelectedResult.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PersonAnimatedContainer extends StatefulWidget {
  String content;
  bool danger;
  bool selected;
  PersonAnimatedContainer({
    this.content,
    this.danger,
    this.selected,
    Key key,
  }) : super(key: key);

  @override
  _PersonAnimatedContainerState createState() =>
      _PersonAnimatedContainerState();
}

class _PersonAnimatedContainerState extends State<PersonAnimatedContainer> {
  double heightFactorSelected = 0.185;
  double heightFactorUnselected = 0.065;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      child: AnimatedContainer(
        color: widget.selected
            ? widget.danger
                ? Colors.red
                : Colors.blue
            : Colors.white,
        height: widget.selected
            ? height * heightFactorSelected
            : height * heightFactorUnselected,
        duration: Duration(milliseconds: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.content),
            GestureDetector(
              onTap: () {
                final chips = Provider.of<ChipProvider>(context, listen: false);
                chips.addChip(
                  key: "MainScreenSelectedResult",
                  chip: GestureDetector(
                    onTap: () {
                      chips.removeChipFromChip("MainScreenSelectedResult");
                      Navigator.of(context).popUntil(
                          ModalRoute.withName('MainScreenSelectedResult'));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Chip(
                        backgroundColor: Colors.orange,
                        label: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    settings: RouteSettings(name: "MainScreenSelectedResult"),
                    builder: (context) => MainScreenSelectedResult(),
                  ),
                );
              },
              child: Text(
                "Details anzeigen",
                textAlign: TextAlign.right,
              ),
            ),
            Container(color: Colors.grey, height: 1),
          ],
        ),
      ),
    );
  }
}
