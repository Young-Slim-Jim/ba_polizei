import 'package:ba_polizei/personHitsProvider.dart';
import 'package:ba_polizei/results_nach_anfrage/ChipProvider.dart';
import 'package:ba_polizei/results_nach_anfrage/MainScreenSelectedResult.dart';
import 'package:flutter/material.dart';
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
                    Expanded(flex: 2, child: Icon(Icons.dangerous)),
                    Expanded(
                      flex: 11,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              widget.nachname +
                                  ", " +
                                  widget.vorname +
                                  ", " +
                                  widget.bday,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          widget.danger
                              ? Flexible(
                                  fit: FlexFit.tight,
                                  child: Text(
                                    "Achtung! Zur Person existiert mindestens eine eingeleitete Fahndung.",
                                    style: TextStyle(fontSize: 16),
                                    maxLines: widget.selected ? 2 : 1,
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
