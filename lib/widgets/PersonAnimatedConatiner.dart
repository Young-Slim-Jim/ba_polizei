import 'package:auto_size_text/auto_size_text.dart';
import 'package:ba_polizei/personHitsProvider.dart';
import 'package:ba_polizei/results_nach_anfrage/ChipProvider.dart';
import 'package:ba_polizei/results_nach_anfrage/screens/MainScreenSelectedResult.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PersonAnimatedContainer extends StatefulWidget {
  String nachname;
  String vorname;
  String bday;
  bool danger;
  bool selected;
  String id;
  PersonAnimatedContainer({
    this.nachname,
    this.vorname,
    this.bday,
    this.danger,
    this.selected,
    this.id,
    Key key,
  }) : super(key: key);

  @override
  _PersonAnimatedContainerState createState() =>
      _PersonAnimatedContainerState();
}

class _PersonAnimatedContainerState extends State<PersonAnimatedContainer> {
  double heightFactorSelected = 0.165;
  double heightFactorUnselected = 0.085;

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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: FaIcon(FontAwesomeIcons.exclamation,
                          color: widget.selected ? Colors.red : Colors.white),
                    ),
                    Expanded(
                      flex: 11,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: AutoSizeText(
                              widget.nachname +
                                  ", " +
                                  widget.vorname +
                                  ", " +
                                  widget.bday,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: widget.selected
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                          widget.danger
                              ? Flexible(
                                  child: AutoSizeText(
                                    "Achtung! Zur Person existiert mindestens eine eingeleitete Fahndung.",
                                    maxLines: widget.selected ? 2 : 1,
                                    style: TextStyle(
                                        color: widget.selected
                                            ? Colors.white
                                            : Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              : Flexible(
                                  child: Text("Keine taktische Hinweise"),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            widget.selected
                ? Expanded(
                    flex: 30,
                    child: GestureDetector(
                      onTap: () {
                        final hitsProvider = Provider.of<PersonHitProvider>(
                            context,
                            listen: false);

                        hitsProvider.resetSelection();

                        final chips =
                            Provider.of<ChipProvider>(context, listen: false);
                        chips.addChip(
                          key: "MainScreenSelectedResult",
                          chip: GestureDetector(
                            onTap: () {
                              chips.removeChipFromChip(
                                  "MainScreenSelectedResult");
                              Navigator.of(context).popUntil(
                                  ModalRoute.withName(
                                      'MainScreenSelectedResult'));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                            settings:
                                RouteSettings(name: "MainScreenSelectedResult"),
                            builder: (context) =>
                                MainScreenSelectedResult(id: widget.id),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Details anzeigen",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                : Container(),
            Container(color: Colors.grey, height: 1),
          ],
        ),
      ),
    );
  }
}
